require "net/http"
require "uri"
require "json"

class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:ai_generate] # Only skip for AI JSON requests

  def index
    @blogs = Blog.all.order(created_at: :desc)
  end

  def show; end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to @blog, notice: "Blog was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: "Blog was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "Blog was successfully deleted."
  end

  # ✅ AI blog generation
  def ai_generate
    prompt_text = params[:prompt].presence || params.dig(:blog, :title).presence || params[:title].presence
    prompt_text = prompt_text.to_s.strip

    if prompt_text.blank?
      render json: { body: "AI generation failed: No title or prompt provided." } and return
    end

    response = generate_ai_content(prompt_text)
    render json: { body: response }
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to blogs_path, alert: "Blog not found."
  end

  def blog_params
    params.require(:blog).permit(:title, :body)
  end

  # ✅ Gemini free-tier API integration
  def generate_ai_content(prompt_text)
    api_key = ENV["GEMINI_API_KEY"]

    if api_key.blank?
      Rails.logger.error("❌ Missing GEMINI_API_KEY in environment.")
      return "AI generation failed: Missing API key."
    end

    uri = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateText?key=#{api_key}")


    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    # Gemini free-tier expects `prompt` to be a hash with `text`
    request_body = {
      prompt: { text: prompt_text },
      temperature: 0.7,
      maxOutputTokens: 1024
    }.to_json

    req = Net::HTTP::Post.new(uri, { "Content-Type" => "application/json" })
    req.body = request_body

    res = http.request(req)
    body = JSON.parse(res.body)

    Rails.logger.info("Gemini API raw response: #{body}")

    # Extract text safely
    text_output = body.dig("candidates", 0, "output", 0, "content") || "AI generation failed."
    text_output
  rescue => e
    Rails.logger.error("AI Generation Error: #{e.message}")
    "AI generation failed."
  end
end
