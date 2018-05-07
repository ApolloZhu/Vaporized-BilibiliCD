# Bilibili Cover Downloader

用 [![Swift 4.1](https://img.shields.io/badge/Swift-4.1-ffac45.svg)](https://swift.org)
 来下载B站视频封面的 <span style="color:#2196f3;">Vapor</span> Cloud App

## 使用方法

请将 `:aid` 替换为实际的 av 号（数字）。如果提示超过每月请求次数，请更换 `vapor.cloud` 为 `herokuapp.com`。

|功能|链接|
|-:|--|
|下载|bilibilicd.vapor.cloud/av/download/:aid|
|展示|bilibilicd.vapor.cloud/av/show/:aid|
|链接|bilibilicd.vapor.cloud/av/url/:aid|
|信息|bilibilicd.vapor.cloud/av/info/:aid|
|UI（暂未实现）|bilibilicd.vapor.cloud/av/:aid|

## License [![GPL License](https://img.shields.io/github/license/apollozhu/vaporized-bilibilicd.svg)](./LICENSE)

    Vaporized BilibiliCD. Download bilibili video covers with Swift.
    Copyright (C) 2018  Zhiyu Zhu <public-apollonian@outlook.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
