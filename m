Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeEGDJu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:09:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751880AbeEGDJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:09:47 -0400
Subject: Re: [PATCH] VFIO: Fix Documentation
To: Alex Williamson <alex.williamson@redhat.com>
References: <1524218521-61496-1-git-send-email-zhangshaokun@hisilicon.com>
 <36f5940b-cac5-9a4a-86cb-7ad9766d5d62@huawei.com>
 <20180430123857.006a0697@w520.home>
CC: <corbet@lwn.net>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "dongbo (E)" <dongbo4@huawei.com>
Message-ID: <0f6b31a8-1be4-8817-a27c-716aa334efe8@huawei.com>
Date: Mon, 7 May 2018 11:09:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20180430123857.006a0697@w520.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.195.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alex.

On 2018/5/1 2:38, Alex Williamson wrote:
> On Fri, 20 Apr 2018 18:07:27 +0800
> "dongbo (E)" <dongbo4@huawei.com> wrote:
> 
>> From: Dong Bo <dongbo4@huawei.com>
>>
>> Signed-off-by: Dong Bo <dongbo4@huawei.com>
>> ---
> 
> Hi Dong Bo,
> 
> The patch is corrupted, please resend and also include a commit log,
> something as simple as "Update vfio_add_group_dev description to match
> the current API" would be fine.  Thanks,
> 
> Alex
> 
Sorry for the corrupted patch. I've resent one and added the commit log
you suggested. Hope it would apply. Thanks.

Best Regards,
Dong Bo

>>  Documentation/vfio.txt | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
>> index ef6a511..f1a4d3c 100644
>> --- a/Documentation/vfio.txt
>> +++ b/Documentation/vfio.txt
>> @@ -252,15 +252,14 @@ into VFIO core.  When devices are bound and unbound to the driver,
>>  the driver should call vfio_add_group_dev() and vfio_del_group_dev()
>>  respectively::
>>  -	extern int vfio_add_group_dev(struct iommu_group *iommu_group,
>> -	                              struct device *dev,
>> +	extern int vfio_add_group_dev(struct device *dev,
>>  				      const struct vfio_device_ops *ops,
>>  				      void *device_data);
>>   	extern void *vfio_del_group_dev(struct device *dev);
>>   vfio_add_group_dev() indicates to the core to begin tracking the
>> -specified iommu_group and register the specified dev as owned by
>> +iommu_group of the specified dev and register the dev as owned by
>>  a VFIO bus driver.  The driver provides an ops structure for callbacks
>>  similar to a file operations structure::
>>  -- 1.9.1
>>
>>
>> .
>>
>>
> 
> 
> .
> 
