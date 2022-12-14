## List of effects

現在、moonshine では以下のエフェクトをサポートしています（五十音順）

* `boxblur`          : 単純なぼかし
* `chromasep`        : 安価な/偽の色収差
* `colorgradesimple` : 色チャンネルの重み付け
* `crt`              : crt/バレルディストーション
* `desaturate`       : 脱色と色合い調整
* `dmg`              : ゲームボーイなどの4色パレット
* `fastgaussianblur` : 高速ガウシアンフィルタ
* `filmgrain`        : 画像ノイズ
* `gaussianblur`     : ガウスぼかし ガウスぼかし
* `glow`             : ライトブルーム
* `godsray`          : 光の散乱
* `pixelate`         : サブサンプリング(インディーズ風)
* `posterize`        : 色数を制限する
* `scanlines`        : 水平線
* `sketch`           : 鉛筆画をシミュレートする
* `vignette`         : 四隅に影をつける


### boxblur

```lua
moonshine.effects.boxblur
```

**Parameters:**

| Name     | Type                       | Default |
| -------- | -------------------------- | ------- |
| radius   | number or table of numbers | {3,3}   |
| radius_x | number                     | 3       |
| radius_y | number                     | 3       |


### chromasep

```lua
moonshine.effects.chromasep
```

**Parameters:**

| Name   | Type                | Default |
| ------ | ------------------- | ------- |
| angle  | number (in radians) | 0       |
| radius | number              | 0       |


### colorgradesimple

```lua
moonshine.effects.colorgradesimple
```

**Parameters:**

| Name    | Type             | Default |
| ------- | ---------------- | ------- |
| factors | table of numbers | {1,1,1} |


### crt

```lua
moonshine.effects.crt
```

**Parameters:**

| Name             | Type                       | Default       |
| ---------------- | -------------------------- | ------------- |
| distortionFactor | table of numbers           | {1.06, 1.065} |
| x                | number                     | 1.06          |
| y                | number                     | 1.065         |
| scaleFactor      | number or table of numbers | {1,1}         |
| feather          | number                     | 0.02          |


### desaturate

```lua
moonshine.effects.desaturate
```

**Parameters:**

| Name     | Type                     | Default       |
| -------- | ------------------------ | ------------- |
| tint     | color / table of numbers | {255,255,255} |
| strength | number between 0 and 1   | 0.5           |


### dmg

```lua
moonshine.effects.dmg
```

| Name    | Type                                          | Default   |
| ------- | --------------------------------------------- | --------- |
| palette | number or string or table of table of numbers | "default" |

DMG ships with 7 palettes:

1. `default`
2. `dark_yellow`
3. `light_yellow`
4. `green`
5. `greyscale`
6. `stark_bw`
7. `pocket`

Custom palettes must be in the format `{{R,G,B}, {R,G,B}, {R,G,B}, {R,G,B}}`,
where `R`, `G`, and `B` are numbers between `0` and `255`.


### fastgaussianblur

```lua
moonshine.effects.fastgaussianblur
```

**Parameters:**

| Name   | Type            | Default |
| ------ | --------------- | ------- |
| taps   | odd number >= 3 | 7       | (amount of blur) |
| offset | number          | 1       |
| sigma  | number          | -1      |


### filmgrain

```lua
moonshine.effects.filmgrain
```

**Parameters:**

| Name    | Type   | Default |
| ------- | ------ | ------- |
| opacity | number | 0.3     |
| size    | number | 1       |


### gaussianblur

```lua
moonshine.effects.gaussianblur
```

**Parameters:**

| Name  | Type   | Default |
| ----- | ------ | ------- |
| sigma | number | 1       | (amount of blur) |


### glow

```lua
moonshine.effects.glow
```

**Parameters:**

| Name     | Type                   | Default |
| -------- | ---------------------- | ------- |
| min_luma | number between 0 and 1 | 0.7     |
| strength | number >= 0            | 5       |


### godsray

```lua
moonshine.effects.godsray
```

**Parameters:**

| Name           | Type                   | Default    |
| -------------- | ---------------------- | ---------- |
| exposire       | number between 0 and 1 | 0.5        |
| decay          | number between 0 and 1 | 0.95       |
| density        | number between 0 and 1 | 0.05       |
| weight         | number between 0 and 1 | 0.5        |
| light_position | table of two numbers   | {0.5, 0.5} |
| light_x        | number                 | 0.5        |
| light_y        | number                 | 0.5        |
| samples        | number >= 1            | 70         |


### pixelate

```lua
moonshine.effects.pixelate
```

**Parameters:**

| Name     | Type                           | Default |
| -------- | ------------------------------ | ------- |
| size     | number or table of two numbers | {5,5}   |
| feedback | number between 0 and 1         | 0       |


### posterize

```lua
moonshine.effects.posterize
```

**Parameters:**

| Name      | Type        | Default |
| --------- | ----------- | ------- |
| num_bands | number >= 1 | 3       |


### scanlines

```lua
moonshine.effects.scanlines
```

**Parameters:**

| Name      | Type                     | Default       |
| --------- | ------------------------ | ------------- |
| width     | number                   | 2             |
| frequency | number                   | screen-height |
| phase     | number                   | 0             |
| thickness | number                   | 1             |
| opacity   | number                   | 1             |
| color     | color / table of numbers | {0,0,0}       |


### sketch

```lua
moonshine.effects.sketch
```

**Parameters:**

| Name   | Type             | Default |
| ------ | ---------------- | ------- |
| amp    | number           | 0.0007  |
| center | table of numbers | {0,0}   |


### vignette

```lua
moonshine.effects.vignette
```

**Parameters:**

| Name     | Type                     | Default |
| -------- | ------------------------ | ------- |
| radius   | number > 0               | 0.8     |
| softness | number > 0               | 0.5     |
| opacity  | number > 0               | 0.5     |
| color    | color / table of numbers | {0,0,0} |

### fog

```lua
moonshine.effects.fog
```

**Parameters:**

| Name      | Type                   | Default            |
| --------- | ---------------------- | ------------------ |
| fog_color | color/table of numbers | {0.35, 0.48, 0.95} |
| octaves   | number > 0             | 4                  |
| speed     | vec2/table of numbers  | {0.5, 0.5}         |


## Writing effects

An effect is essentially a function that returns a `moonshine.Effect{}`, which
must specify at least a `name` and a `shader` or a `draw` function.

It may also specify a `setters` table that contains functions that set the
effect parameters and a `defaults` table with the corresponding default values.
The default values will be set when the effect is instantiated.

A good starting point to see how to write effects is the `colorgradesimple`
effect, which uses the `shader`, `setters` and `defaults` fields.

Moonshine uses double buffering to draw the effects. A function to swap and
access the buffers is provided to the `draw(buffer)` function of your effect:

```lua
front, back = buffer() -- swaps front and back buffer and returns both
```

You don't have to care about canvases or restoring defaults, moonshine handles
all that for you.

If you only need a custom draw function because your effect needs multiple
shader passes, moonshine provides the `draw_shader(buffer, shader)` function.
As you might have guessed, this function uses `shader` to draw the front buffer
to the back buffer. The `boxblur` effect gives a simple example how to use this
function.

If for some reason you need more than two buffer, you are more or less on your
own. You can do everything, but make sure that the blend mode and the order of
back and front buffer is the same before and after your custom `draw` function.
The `glow` effect gives an example of a more complicated `draw` function.

