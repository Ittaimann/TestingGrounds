Shader "udemy/helloShader" {
	Properties{
		_myColor("example color",color)=(1,1,1,1)
		_myEmission("Emission color",color)=(1,1,1,1)
		_myNormals("normals",color)=(1,1,1,1)

	}
	SubShader{
		CGPROGRAM 
		#pragma surface surf Lambert

		struct Input{
			float2 uvMainTex;
		};

		fixed4 _myColor;
		fixed4 _myEmission;
		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo= _myColor.rgb;
			o.Emission  = _myEmission.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
