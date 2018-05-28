//
//  ViewController.m
//  SortTest
//
//  Created by dx l on 2018/5/28.
//  Copyright © 2018年 dx l. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *sortArr;
@property (weak, nonatomic) IBOutlet UITextField *numTf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)button1:(id)sender {
    NSLog(@"begin bubbling sort");
    /*
     self.sortArr.count - 1:增加效率
     self.sortArr.count - 1 - i:防止越界
     */
    
    for (int i = 0; i < self.sortArr.count - 1; i++) {
        for (int j = 0; j < self.sortArr.count - 1 - i; j++) {
            if (self.sortArr[j] > self.sortArr[j+1]) {
                [self.sortArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"end bubbling sort");
//    NSLog(@"bubbling sorted result:%@",self.sortArr);
}
- (IBAction)button2:(id)sender {
    //找到数组中的最小（大）值，并将其放到第一位，然后找到第二小的值放到第二位……以此类推。
    NSLog(@"begin selection sort");
    NSInteger count = self.sortArr.count;
    for (int i = 0; i < count; i++) {
        for (int j = i; j < count; j++) {
            if (self.sortArr[i] > self.sortArr[j]) {
                [self.sortArr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"end selection sort");
//    NSLog(@"selectionSortedData:%@",self.sortArr);
    
}
- (IBAction)button3:(id)sender {
    //插入排序：也叫希尔排序
    /**
     *  插入排序是最接近生活的排序，因为我们打牌时就差不多是采用的这种排序方法。该方法从数组的第二项开始遍历数组的n-1项（n为数组长度），遍历过程中对于当前项的左边数组项，依次从右到左进行对比，如果左边选项大于（或小于）当前项，则左边选项向右移动，然后继续对比前一项，直到找到不大于（不小于）自身的选项为止，对于所有大于当前项的选项，都在原来位置的基础上向右移动了一项。
     */
    
    /**
     *  实现起来简单，理解起来不是很复杂。
     *  对于较小的数据集而言比较高效。
     *  相对于其他复杂度为O(n^2)的排序算法（冒泡、选择）而言更加快速。
     */
    NSLog(@"begin insert sort");
    
    for (int i = 1; i < self.sortArr.count; i++) {
        int j = i;
        NSNumber *num_i = self.sortArr[i];
        while (j > 0 && self.sortArr[j - 1] > num_i) {
            [self.sortArr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
            j--;
        }
        self.sortArr[j] = num_i;
    }
    
    NSLog(@"end insert sort");
//    NSLog(@"insertSortData:%@",self.sortArr);
}

/**
 *  到目前为止，已经介绍了三种排序方法，包括冒泡排序、选择排序和插入排序。这三种排序方法的时间复杂度都为O(n^2)，其中冒泡排序实现最简单，性能最差，选择排序比冒泡排序稍好，但是还不够，插入排序是这三者中表现最好的，对于小数据集而言效率较高。这些原因导致三者的实用性并不高，都是最基本的简单排序方法，多用于教学，很难用于实际中，从这节开始介绍更加高级的排序算法
 */
- (IBAction)button4:(id)sender {
    /** 归并排序的时间复杂度为O(nlogn)
     *  归并排序的核心思想是分治，分治是通过递归地将问题分解成相同或者类型相关的两个或者多个子问题，直到问题简单到足以解决，然后将子问题的解决方案结合起来，解决原始方案的一种思想。
     归并排序通过将复杂的数组分解成足够小的数组（只包含一个元素），然后通过合并两个有序数组（单元素数组可认为是有序数组）来达到综合子问题解决方案的目的。所以归并排序的核心在于如何整合两个有序数组，拆分数组只是一个辅助过程。
     */
    NSLog(@"归并 begin sort");
    [self sortArr:self.sortArr];
    NSLog(@"归并 end sort");
//    NSLog(@"归并result:%@",self.sortArr);
}

- (void)sortArr:(NSMutableArray *)sorttingArr {
    NSMutableArray *arr = @[].mutableCopy;
    if (self.sortArr.count <= 1) {
        return;
    }
    [self sortArr:sorttingArr withLeftIndex:0 rightIndex:sorttingArr.count - 1 newArr:arr];
}

- (void)sortArr:(NSMutableArray *)sorttingArr withLeftIndex:(NSInteger)left rightIndex:(NSInteger)right newArr:(NSMutableArray *)newArr{
    if (left < right) {
        NSInteger mid = (left + right) / 2;
        [self sortArr:sorttingArr withLeftIndex:left rightIndex:mid newArr:newArr];
        [self sortArr:sorttingArr withLeftIndex:mid + 1 rightIndex:right newArr:newArr];
        [self mergeArr:sorttingArr withLeftIndex:left mid:mid rightIndex:right newArr:newArr];
    }
}

- (void)mergeArr:(NSMutableArray *)sorttingArr withLeftIndex:(NSInteger)left mid:(NSInteger)mid rightIndex:(NSInteger)right newArr:(NSMutableArray *)newArr {
    NSInteger i = left;
    NSInteger j = mid + 1;
    NSInteger t = 0;
    while (i <= mid && j <= right) {
        if (sorttingArr[i] <= sorttingArr[j]) {
            newArr[t++] = sorttingArr[i++];
        } else {
            newArr[t++] = sorttingArr[j++];
        }
    }
    
    while (i <= mid) {
        newArr[t++] = sorttingArr[i++];
    }
    
    while (j <= right) {
        newArr[t++] = sorttingArr[j++];
    }
    
//    t = 0;
//    while (left <= right) {
//        [sorttingArr insertObject:newArr[t++] atIndex:left++];
//    }
    
    for ( int i = 0; i < t; i++) {
        sorttingArr[i + left] = newArr[i];
    }
}



- (IBAction)button5:(id)sender {
    
    /**
     *  基本思想：
     在数组中选取一个参考点（pivot），然后对于数组中的每一项，大于
     pivot的项都放到数组右边，小于pivot的项都放到左边，左右两边的
     数组项可以构成两个新的数组（left和right），然后继续分别对left
     和right进行分解，直到数组长度为1，最后合并（其实没有合并，因为
     是在原数组的基础上操作的，只是理论上的进行了数组分解）。
     基本步骤：
     （1）首先，选取数组的中间项作为参考点pivot。
     （2）创建左右两个指针left和right，left指向数组的第一项，right
         指向最后一项，然后移动左指针，直到其值不小于pivot，然后移动右指针，
         直到其值不大于pivot。
     （3）如果left仍然不大于right，交换左右指针的值（指针不交换），
         然后左指针右移，右指针左移，继续循环直到left大于right才结束，返回left指针的值。
     （4）根据上一轮分解的结果（left的值），切割数组得到left和right两个数组，
         然后分别再分解。
     （5）重复以上过程，直到数组长度为1才结束分解。
     */
    NSLog(@"begin quickSort sort");
    
    [self quickSort:self.sortArr left:0 right:self.sortArr.count - 1];
    
    NSLog(@"end quickSort sort");
//    NSLog(@"quickSortData:%@",self.sortArr);
}

- (void)quickSort:(NSMutableArray *)arr left:(NSInteger)left right:(NSInteger)right {
    if (arr.count <= 1) {
        return;
    }
    NSInteger index = [self partitionArr:arr withLeft:left right:right];
    if (left < index - 1) {
        //分解左边数组。
        [self quickSort:arr left:left right:index - 1];
    }
    
    if (index < right) {
        //分解右边数组。
        [self quickSort:arr left:index right:right];
    }
}

- (NSInteger)partitionArr:(NSMutableArray *)sorttingArr withLeft:(NSInteger)left
               right:(NSInteger)right{
    NSInteger mid = (left + right) / 2;
    //循环left > right
    while (left <= right) {
        //持续右移左指针直到其值不小于mid
        while (sorttingArr[left] < sorttingArr[mid]) {
            left++;
        }
        
        //持续左移右指针直到其值不大于mid
        while (sorttingArr[right] > sorttingArr[mid]) {
            right --;
        }
        
        //此时左指针的值不小于mid，右指针的值不大于mid。
        //如果left仍然不大于right
        if (left <= right) {
            //交换两者的值，使得不大于mid的值在其左侧，不小于mid的值在其右侧。
            [sorttingArr exchangeObjectAtIndex:left withObjectAtIndex:right];
            //左指针右移，右指针左移准备开始下一轮，
            //防止arr[left]和arr[right]都等于mid然后导致死循环。
            
            left++;
            right--;
        }
    }
    //返回左指针作为下一轮分解的依据
    return left;
}


- (IBAction)button6:(id)sender {
    
    NSLog(@"heapSort begin");
    
    [self buildHeapWithArr:self.sortArr];
    
    for (NSInteger i = self.sortArr.count - 1; i > 0; i--) {
        // 从最右侧的叶子节点开始，依次与根节点的值交换。
        [self.sortArr exchangeObjectAtIndex:0 withObjectAtIndex:i];
        //每次交换之后都要重新构建堆结构，记得传入i限制范围，防止已经交换的值仍然被重新构建。
        [self heapifyArr:self.sortArr heapSize:i index:0];
    }
    NSLog(@"heapSort end");
    NSLog(@"%@",self.sortArr);
}

- (void)buildHeapWithArr:(NSMutableArray *)arr {
    NSInteger mid = arr.count / 2;
    for (NSInteger i = mid; i >= 0; i--) {
        [self heapifyArr:arr heapSize:arr.count index:i];
    }
}

- (void)heapifyArr:(NSMutableArray *)arr heapSize:(NSInteger)heapSize index:(NSInteger)i {
    //左子节点 下标
    NSInteger left = 2 * i + 1;
    //右子节点 下标
    NSInteger right = 2 * i + 2;
    //假设当前父节点满足要求（比子节点都大）
    NSInteger largest = i;
    //如果左子节点在heapSize内，并且值大于其父节点，那么left赋给largest。
    if (left < heapSize && arr[left] > arr[largest]) {
        largest = left;
    }
    
    //如果右子节点在heapSize内，并且值大于其父节点，那么right赋给largest。
    if (right < heapSize && arr[right] > arr[largest]) {
        largest = right;
    }
    
    if (largest != i) {
        // 如果largest被修改了，那么交换两者的值使得构造成一个合格的堆结构。
        [arr exchangeObjectAtIndex:largest withObjectAtIndex:i];
        // 递归调用自身，将节点i所有的子节点都构建成堆结构。
        [self heapifyArr:arr heapSize:heapSize index:largest];
    }
//    return arr;
}

- (IBAction)button8:(id)sender {
    if (self.sortArr) {
        [self.sortArr removeAllObjects];
    } else {
        self.sortArr = [NSMutableArray array];
    }
    NSLog(@"begin get data");
    NSInteger num = self.numTf.text.integerValue;
    num = (num == 0 ? 100 : num);
    for (int i =0; i < num; i++) {
        int numObj = arc4random() % (num * 10);
        [self.sortArr addObject:@(numObj)];
    }
    NSLog(@"end get data-----%ld",num);
//    NSLog(@"beginSortData:%@",self.sortArr);
}
/**
 *  1000:
 1、冒泡：0.118
 2、选择：0.103
 3、插入：0.069
 4、归并：0.006
 5、快速：0.002
 
 *  10000:
 1、冒泡：8.879
 2、选择：6.486
 3、插入：2.911
 4、归并：0.043
 5、快速：0.028
 
 *  10 0000:
 1、冒泡：
 2、选择：
 3、插入：
 4、归并：0.210
 5、快速：0.103
 6、堆：0.243
 
 *  100 0000：
 1、冒泡：
 2、选择：
 3、插入：
 4、归并：1.972
 5、快速：0.793
 6、堆：2.836
 
 
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
