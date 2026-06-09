import { useParams, useNavigate } from 'react-router-dom'
import { mockProducts } from '../features/product/mockProducts'
import { ProductImage } from '../features/product/ProductImage'
import { Button } from '../components/Button'

const ProductDetailPage = () => {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const product = mockProducts.find((p) => p.id === Number(id))

  if (!product) {
    return (
      <div className="p-8 text-center">
        <p className="text-gray-500 mb-4">商品が見つかりませんでした。</p>
        <Button label="一覧に戻る" onClick={() => navigate('/products')} />
      </div>
    )
  }

  return (
    <div className="p-8 max-w-2xl mx-auto">
      <Button
        label="← 一覧に戻る"
        variant="secondary"
        onClick={() => navigate('/products')}
      />
      <div className="mt-6 flex flex-col items-center gap-6">
        <ProductImage src={product.imageUrl} alt={product.name} size="lg" />
        <div className="w-full">
          <h1 className="text-2xl font-bold text-gray-800 mb-2">{product.name}</h1>
          <p className="text-2xl text-blue-600 font-bold mb-4">
            ¥{product.price.toLocaleString()}
          </p>
          <p className="text-gray-600 leading-relaxed">{product.description}</p>
        </div>
      </div>
    </div>
  )
}

export default ProductDetailPage
