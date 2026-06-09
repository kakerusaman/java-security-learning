import { useNavigate } from 'react-router-dom'
import type { Product } from '../../types'
import { ProductImage } from './ProductImage'
import { Button } from '../../components/Button'

interface ProductCardProps {
  product: Product
}

export const ProductCard = ({ product }: ProductCardProps) => {
  const navigate = useNavigate()

  return (
    <div className="border border-gray-200 rounded-lg p-4 flex flex-col items-center gap-3 hover:shadow-md transition-shadow">
      <ProductImage src={product.imageUrl} alt={product.name} size="md" />
      <h2 className="text-base font-medium text-gray-800 text-center">{product.name}</h2>
      <p className="text-blue-600 font-bold">¥{product.price.toLocaleString()}</p>
      <Button
        label="詳細を見る"
        onClick={() => navigate(`/products/${product.id}`)}
      />
    </div>
  )
}
