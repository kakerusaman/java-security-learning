import { Routes, Route, Navigate } from 'react-router-dom'
import ProductListPage from './pages/ProductListPage'
import ProductDetailPage from './pages/ProductDetailPage'

const App = () => {
  return (
    <Routes>
      <Route path="/products" element={<ProductListPage />} />
      <Route path="/products/:id" element={<ProductDetailPage />} />
      <Route path="*" element={<Navigate to="/products" replace />} />
    </Routes>
  )
}

export default App
