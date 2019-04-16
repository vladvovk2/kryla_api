class BlogsController < ApplicationController
  def index; end

  def download_menu
    GenerateMenuWorker.perform_async
  end

  private

  def generate_pdf
    Prawn::Document.generate('public/pdfs/menu_4.pdf') do |pdf|
      Category.includes(products: :product_types).all.each do |category|
        pdf.text "Category: #{category.title}", align: :center, size: 20
        category.products.each do |product|
          pdf.text "Product: #{product.title}", size: 15
          product.product_types.each do |pt|
            pdf.text "proportion: #{pt.proportion}, price: #{pt.price}, weight: #{pt.weight}", size: 10
          end
          pdf.text '-' * 50
        end
      end
      pdf.render
    end
  end
end
