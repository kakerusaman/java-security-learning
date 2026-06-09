interface ProductImageProps {
  src: string
  alt: string
  size?: 'sm' | 'md' | 'lg'
}

const sizeClass = {
  sm: 'w-24 h-24',
  md: 'w-48 h-48',
  lg: 'w-96 h-96',
}

export const ProductImage = ({ src, alt, size = 'md' }: ProductImageProps) => {
  return (
    <div className={`${sizeClass[size]} overflow-hidden rounded-lg bg-gray-100`}>
      <img
        src={src}
        alt={alt}
        className="w-full h-full object-cover"
        onError={(e) => {
          e.currentTarget.src = '/placeholder.png'
        }}
      />
    </div>
  )
}
