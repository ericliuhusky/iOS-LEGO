//
//  Constants.swift
//  LargeImage
//
//  Created by lzh on 2022/6/20.
//

/* 图像常量: 用MB为单位定义生成图像的大小和图像分割贴片的大小。图像的大小可以转化为像素数。
 这个图像大小与磁盘上压缩格式（PNG,JPEG）的文件大小不同。

 展示在iOS上的图像必须先从磁盘上解压（解码），从磁盘上解码的像素数据的近似区域由两者决定：当前绘图上下文的裁剪矩形，
 以及图像内容相当于当前上下文的偏移量
 
 图像解码文件的大小 = 宽 x 高 / pixelsPerMB
 32位颜色空间(iOS做了优化本应为 1000 * 1000 * 8 / 32 = 250000) pixelsPerMB = 262144
 
 支持的格式有：PNG、TIFF、JPEG。不支持的格式：GIF、BMP、隔行扫描图像。
*/
let imageFilename = "large_leaves_70mp.jpg"

/* 缩小例程的参数是生成图像的大小和图像分割贴片的大小，它们以MB为单位以简化应用可用内存和图像间的相关性
 
 图像分割贴片是一次性从输入图像加载到内存的最大像素数据，图像分割贴片的大小决定了将生成的图像拼接在一起所需要的迭代次数
 
 根据以下两个条件决定生成图像的大小，目标设备的硬件配置和其它应用占用的内存
 
 选择最大的输入图像分割贴片大小，将会使完成缩小例程的次数达到最小。因此性能必须与生成图像的质量相平衡
 
 获取设备名称：
 size_t size;
 sysctlbyname("hw.machine", NULL, &size, NULL, 0);
 char *machine = malloc(size);
 sysctlbyname("hw.machine", machine, &size, NULL, 0);
 NSString* _platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
 free(machine);
 */

// 这些常量是iPad1和iPhone3GS的建议初始值
let destImageSizeMB: Float = 60.0 // 生成的图像将是（x）MB的未压缩图像数据。
let sourceImageTileSizeMB: Float = 20.0 // 图像分割贴片的大小将是（x）MB的未压缩图像数据。

// 这些常量是iPad2和iPhone 4的建议初始值
//let destImageSizeMB: Float = 120.0
//let sourceImageTileSizeMB: Float = 40.0

// 这些常量是iPhone3G和iPod2以及更早设备的建议初始值
//let destImageSizeMB: Float = 30.0
//let sourceImageTileSizeMB: Float = 10.0

let bytesPerMB: Float = 1048576.0
let bytesPerPixel: Float = 4.0
let pixelsPerMB = bytesPerMB / bytesPerPixel // 262144
let destTotalPixels = destImageSizeMB * pixelsPerMB
let tileTotalPixels = sourceImageTileSizeMB * pixelsPerMB
let destSeemOverlap = 2.0 // 图像分割贴片相交的地方重叠的像素数
