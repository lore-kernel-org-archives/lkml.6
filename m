Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeFALQg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:16:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbeFALQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:16:22 -0400
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
To: Richard Weinberger <richard@sigma-star.at>
CC: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, <miaoxie@huawei.com>,
        <yuchao0@huawei.com>, <sunqiuyang@huawei.com>, <fangwei1@huawei.com>,
        <liguifu2@huawei.com>, <weidu.du@huawei.com>,
        <chen.chun.yen@huawei.com>, <brooke.wangzhigang@hisilicon.com>,
        <dongjinguang@huawei.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
 <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
 <1670077.cnVahIradn@blindfold>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <863d726d-e919-9ee1-56e4-994c8ab09f4b@huawei.com>
Date: Fri, 1 Jun 2018 19:16:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1670077.cnVahIradn@blindfold>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/1 17:28, Richard Weinberger wrote:
> Am Freitag, 1. Juni 2018, 11:11:21 CEST schrieb Gao Xiang:
>>> In which sense is it extendable?
>>
>> Actually, the meaning of an enhanced (means not just read-only, but with the scalable
>> on-disk layout, compression, or fs-verify in the future) read-only file system is emphasized.
> 
> ah ok.
>  
>> We also think of other candidate full names, such as
>> Enhanced / Extented Read-only File System, all the names short for "erofs" are okay.
> 
> TBH, I read "erofs" as "error fs". ;-)
eh..."erofs" indeed comes from the EROFS error code, that is a playful behaviour...
I think the error code of EROFS is not so bad... :'(


Also hope for a better name but not only highlight the compression...
We have some further plans other than the compression.

Anyway, the name is currently not vital tho. :D

> 
>>> How does it compare to existing read only filesystems, such as squashfs?
>>>
>>
>> You are quite right.
>>
>> We are now focusing on improving our decompression subsystem and
>> these numbers will be successively added in the future non-RFC patches.
>>
>> We haven't pay much attention on comparing squashfs and erofs
>> yet since we once tried to use squashfs on our products with
>> different block sizes several years ago, it behaves
>> unacceptable in the low free memory scenario besides its
>> performance.
> 
> I'm interested in the comparison because I use squashfs often
> for embedded devices on top of ubiblock (raw nand).
> If there is something that can do better, I'm all for it.
> 

We're trying our best. ;)

> Thanks,
> //richard
> 

Thanks,
