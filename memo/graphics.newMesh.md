# love.graphics.newMesh

メッシュオブジェクトを作成します。
メッシュが `Image` や `Canvas` に対して適用される場合は `Mesh:setTexture` を使用して下さい。

:::info
メッシュ … 網目のこと
:::


## 関数

頂点を指定して標準的なメッシュを作成します。


### 概要

```lua
mesh = love.graphics.newMesh( vertices, mode, usage )
```


### 引数

table vertices
The table filled with vertex information tables for each vertex as follows:
number [1]
The position of the vertex on the x-axis.
number [2]
The position of the vertex on the y-axis.
number [3] (0)
The u texture coordinate of the vertex. Texture coordinates are normally in the range of [0, 1], but can be greater or less (see WrapMode.)
number [4] (0)
The v texture coordinate of the vertex. Texture coordinates are normally in the range of [0, 1], but can be greater or less (see WrapMode.)
number [5] (1)
The red component of the vertex color.
number [6] (1)
The green component of the vertex color.
number [7] (1)
The blue component of the vertex color.
number [8] (1)
The alpha component of the vertex color.
MeshDrawMode mode ("fan")
How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
SpriteBatchUsage usage ("dynamic")
The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
Returns
Mesh mesh
The new mesh.
Function
Available since LÖVE 0.10.0
This variant is not supported in earlier versions.
Creates a standard Mesh with the specified number of vertices.

Synopsis
mesh = love.graphics.newMesh( vertexcount, mode, usage )
Arguments
number vertexcount
The total number of vertices the Mesh will use. Each vertex is initialized to {0,0, 0,0, 1,1,1,1}.
MeshDrawMode mode ("fan")
How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
SpriteBatchUsage usage ("dynamic")
The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
Returns
Mesh mesh
The new mesh.
Notes
Mesh:setVertices or Mesh:setVertex and Mesh:setDrawRange can be used to specify vertex information once the Mesh is created.

Function
Available since LÖVE 0.10.0
This variant is not supported in earlier versions.
Creates a Mesh with custom vertex attributes and the specified vertex data.

Synopsis
mesh = love.graphics.newMesh( vertexformat, vertices, mode, usage )
Arguments
table vertexformat
A table in the form of {attribute, ...}. Each attribute is a table which specifies a custom vertex attribute used for each vertex.
table attribute
A table containing the attribute's name, its data type, and the number of components in the attribute, in the form of {name, datatype, components}.
table ...
Additional vertex attribute format tables.
table vertices
The table filled with vertex information tables for each vertex, in the form of {vertex, ...} where each vertex is a table in the form of {attributecomponent, ...}.
number attributecomponent
The first component of the first vertex attribute in the vertex.
number ...
Additional components of all vertex attributes in the vertex.
MeshDrawMode mode ("fan")
How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
SpriteBatchUsage usage ("dynamic")
The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
Returns
Mesh mesh
The new mesh.
Notes
The values in each vertex table are in the same order as the vertex attributes in the specified vertex format. If no value is supplied for a specific vertex attribute component, it will be set to a default value of 0 if its data type is "float", or 1 if its data type is "byte".

If the data type of an attribute is "float", components can be in the range 1 to 4, if the data type is "byte" it must be 4.

If a custom vertex attribute uses the name "VertexPosition", "VertexTexCoord", or "VertexColor", then the vertex data for that vertex attribute will be used for the standard vertex positions, texture coordinates, or vertex colors respectively, when drawing the Mesh. Otherwise a Vertex Shader is required in order to make use of the vertex attribute when the Mesh is drawn.

A Mesh must have a "VertexPosition" attribute in order to be drawn, but it can be attached from a different Mesh via Mesh:attachAttribute.

To use a custom named vertex attribute in a Vertex Shader, it must be declared as an attribute variable of the same name. Variables can be sent from Vertex Shader code to Pixel Shader code by making a varying variable. For example:

Vertex Shader code

attribute vec2 CoolVertexAttribute;

varying vec2 CoolVariable;

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    CoolVariable = CoolVertexAttribute;
    return transform_projection * vertex_position;
}
Pixel Shader code

varying vec2 CoolVariable;

vec4 effect(vec4 color, Image tex, vec2 texcoord, vec2 pixcoord)
{
    vec4 texcolor = Texel(tex, texcoord + CoolVariable);
    return texcolor * color;
}
Function
Available since LÖVE 0.10.0
This variant is not supported in earlier versions.
Creates a Mesh with custom vertex attributes and the specified number of vertices.

Synopsis
mesh = love.graphics.newMesh( vertexformat, vertexcount, mode, usage )
Arguments
table vertexformat
A table in the form of {attribute, ...}. Each attribute is a table which specifies a custom vertex attribute used for each vertex.
table attribute
A table containing the attribute's name, it's data type, and the number of components in the attribute, in the form of {name, datatype, components}.
table ...
Additional vertex attribute format tables.
number vertexcount
The total number of vertices the Mesh will use.
MeshDrawMode mode ("fan")
How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
SpriteBatchUsage usage ("dynamic")
The expected usage of the Mesh. The specified usage mode affects the Mesh's memory usage and performance.
Returns
Mesh mesh
The new mesh.
Notes
Each vertex attribute component is initialized to 0 if its data type is "float", or 1 if its data type is "byte". Mesh:setVertices or Mesh:setVertex and Mesh:setDrawRange can be used to specify vertex information once the Mesh is created.

If the data type of an attribute is "float", components can be in the range 1 to 4, if the data type is "byte" it must be 4.

If a custom vertex attribute uses the name "VertexPosition", "VertexTexCoord", or "VertexColor", then the vertex data for that vertex attribute will be used for the standard vertex positions, texture coordinates, or vertex colors respectively, when drawing the Mesh. Otherwise a Vertex Shader is required in order to make use of the vertex attribute when the Mesh is drawn.

A Mesh must have a "VertexPosition" attribute in order to be drawn, but it can be attached from a different Mesh via Mesh:attachAttribute.

Function
Removed in LÖVE 0.10.0
This variant is not supported in that and later versions.
Synopsis
mesh = love.graphics.newMesh( vertices, texture, mode )
Arguments
table vertices
The table filled with vertex information tables for each vertex as follows:
number [1]
The position of the vertex on the x-axis.
number [2]
The position of the vertex on the y-axis.
number [3]
The u texture coordinate. Texture coordinates are normally in the range of [0, 1], but can be greater or less (see WrapMode.)
number [4]
The v texture coordinate. Texture coordinates are normally in the range of [0, 1], but can be greater or less (see WrapMode.)
number [5] (255)
The red color component.
number [6] (255)
The green color component.
number [7] (255)
The blue color component.
number [8] (255)
The alpha color component.
Texture texture (nil)
The Image or Canvas to use when drawing the Mesh. May be nil to use no texture.
MeshDrawMode mode ("fan")
How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
Returns
Mesh mesh
The new mesh.
Function
Available since LÖVE 0.9.1 and removed in LÖVE 0.10.0
This variant is not supported in earlier or later versions.
Synopsis
mesh = love.graphics.newMesh( vertexcount, texture, mode )
Arguments
number vertexcount
The total number of vertices the Mesh will use. Each vertex is initialized to {0,0, 0,0, 255,255,255,255}.
Texture texture (nil)
The Image or Canvas to use when drawing the Mesh. May be nil to use no texture.
MeshDrawMode mode ("fan")
How the vertices are used when drawing. The default mode "fan" is sufficient for simple convex polygons.
Returns
Mesh mesh
The new mesh.
Notes
Mesh:setVertices or Mesh:setVertex and Mesh:setDrawRange can be used to specify vertex information once the Mesh is created.

Examples
Creates and draws a Mesh identical to a normal drawn image but with different colors at each corner
function love.load()
	image = love.graphics.newImage("pig.png")
	
	local vertices = {
		{
			-- top-left corner (red-tinted)
			0, 0, -- position of the vertex
			0, 0, -- texture coordinate at the vertex position
			1, 0, 0, -- color of the vertex
		},
		{
			-- top-right corner (green-tinted)
			image:getWidth(), 0,
			1, 0, -- texture coordinates are in the range of [0, 1]
			0, 1, 0
		},
		{
			-- bottom-right corner (blue-tinted)
			image:getWidth(), image:getHeight(),
			1, 1,
			0, 0, 1
		},
		{
			-- bottom-left corner (yellow-tinted)
			0, image:getHeight(),
			0, 1,
			1, 1, 0
		},
	}

	-- the Mesh DrawMode "fan" works well for 4-vertex Meshes.
	mesh = love.graphics.newMesh(vertices, "fan")
        mesh:setTexture(image)
end

function love.draw()
	love.graphics.draw(mesh, 0, 0)
end
Creates and draws a textured circle with a red tint at the center.
function CreateTexturedCircle(image, segments)
	segments = segments or 40
	local vertices = {}
	
	-- The first vertex is at the center, and has a red tint. We're centering the circle around the origin (0, 0).
	table.insert(vertices, {0, 0, 0.5, 0.5, 255, 0, 0})
	
	-- Create the vertices at the edge of the circle.
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2

		-- Unit-circle.
		local x = math.cos(angle)
		local y = math.sin(angle)
		
		-- Our position is in the range of [-1, 1] but we want the texture coordinate to be in the range of [0, 1].
		local u = (x + 1) * 0.5
		local v = (y + 1) * 0.5
		
		-- The per-vertex color defaults to white.
		table.insert(vertices, {x, y, u, v})
	end
	
	-- The "fan" draw mode is perfect for our circle.
	local mesh = love.graphics.newMesh(vertices, "fan")
        mesh:setTexture(image)

        return mesh
end

function love.load()
	image = love.graphics.newImage("pig.png")
	mesh = CreateTexturedCircle(image)
end

function love.draw()
	local radius = 100
	local mx, my = love.mouse.getPosition()
	
	-- We created a unit-circle, so we can use the scale parameter for the radius directly.
	love.graphics.draw(mesh, mx, my, 0, radius, radius)
end
Creates a circle and draws it more efficiently than love.graphics.circle.
function CreateCircle(segments)
	segments = segments or 40
	local vertices = {}
	
	-- The first vertex is at the origin (0, 0) and will be the center of the circle.
	table.insert(vertices, {0, 0})
	
	-- Create the vertices at the edge of the circle.
	for i=0, segments do
		local angle = (i / segments) * math.pi * 2

		-- Unit-circle.
		local x = math.cos(angle)
		local y = math.sin(angle)

		table.insert(vertices, {x, y})
	end
	
	-- The "fan" draw mode is perfect for our circle.
	return love.graphics.newMesh(vertices, "fan")
end

function love.load()
	mesh = CreateCircle()
end

function love.draw()
	local radius = 100
	local mx, my = love.mouse.getPosition()
	
	-- We created a unit-circle, so we can use the scale parameter for the radius directly.
	love.graphics.draw(mesh, mx, my, 0, radius, radius)
end

Using custom vertex attributes, create a 3D mesh.
local vertexFormat = {
    {"VertexPosition", "float", 3},
    {"VertexTexCoord", "float", 2},
}

-- Vertices are defined in the order that the vertexFormat table is in
-- So, the first 3 numbers in each vertex are "VertexPosition" and the last 2 are "VertexTexCoord"

local vertices = {
    {-0.5, -0.5, -0.5, 0, 0},
    { 0.5, -0.5, -0.5, 1, 1},
    { 0.5,  0.5, -0.5, 0, 1},
    --and so on.
}

-- The "triangles" mode creates a separate triangle for each set of 3 vertices.
mesh = love.graphics.newMesh(vertexFormat, vertices, "triangles")