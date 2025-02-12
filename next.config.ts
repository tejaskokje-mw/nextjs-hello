import type { NextConfig } from "next";

const nextConfig = {
  // ...
  // Your existing config
   experimental: {
       instrumentationHook: true, 
       serverComponentsExternalPackages: ['@middleware.io/agent-apm-nextjs']
   }
}

module.exports = nextConfig
export default nextConfig;
