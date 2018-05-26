Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031281AbeEZHka (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 03:40:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58080 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031131AbeEZHk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 03:40:29 -0400
Subject: Re: [PATCH V2 rdma-next 0/4] Misc update for hns driver
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <1527070590-94399-1-git-send-email-xavier.huwei@huawei.com>
 <20180524214342.GA13272@ziepe.ca>
CC: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5B090F5A.9020306@huawei.com>
Date: Sat, 26 May 2018 15:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180524214342.GA13272@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/25 5:43, Jason Gunthorpe wrote:
> On Wed, May 23, 2018 at 06:16:26PM +0800, Wei Hu (Xavier) wrote:
>> This patchset included fixing bug, some optimization, reset
>> process for hns driver.
>>
>> v1->v2: 1.pull the patch out of the series. The name of the patch is 
>> 	  RDMA/hns: Implement the disassociate_ucontext API.
>> 	2.Modify the fixes statement according to Leon's comment.
>> 	3.Address the Jason's comment in reset relevant patch.
>>
>> Wei Hu (Xavier) (4):
>>   RDMA/hns: Modify uar allocation algorithm to avoid bitmap exhaust
>>   RDMA/hns: Increase checking CMQ status timeout value
> I took these two to for-next , the others have to respun.
Hi, Jason
   
    I will send V3 for these two patches and about disassociate_ucontext
the according to your comments.
    By the way,  About this patch as follows will still be in this
series, and you and other experts can continue giving comment. Thanks
             RDMA/hns: Add reset process for RoCE in hip08for these two
patches and the refactored patches

    Regards
Wei Hu
>
>>   RDMA/hns: Add reset process for RoCE in hip08
>>   RDMA/hns: Fix the illegal memory operation when cross page
> Thanks,
> Jason
>
>
