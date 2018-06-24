Shader "udemy/packedPractice" {
	Properties{
		_myColor("example color",color)=(1,1,1,1)
		

	}
	SubShader{
		CGPROGRAM 
		#pragma surface surf Lambert

		struct Input{
			float2 uvMainTex;
		};

		fixed4 _myColor;
		
		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo.r= _myColor.x;
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
