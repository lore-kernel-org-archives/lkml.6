Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD04C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A115420811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A115420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeLMKe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:34:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbeLMKe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:34:29 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0D98AB95CBA6;
        Thu, 13 Dec 2018 18:34:24 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 18:34:21 +0800
Subject: Re: [PATCH] staging: erofs: Add a blank line after declarations
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Sungkyung Kim <jotun9935@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>
References: <20181212155023.45294-1-jotun9935@gmail.com>
 <9d1280a1-d4bd-d64d-20ff-1468408f9607@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8c8c61ca-196c-af95-7211-4e504fc85e59@huawei.com>
Date:   Thu, 13 Dec 2018 18:34:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9d1280a1-d4bd-d64d-20ff-1468408f9607@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/13 9:51, Gao Xiang wrote:
> Hi Sungkyung,
> 
> On 2018/12/12 23:50, Sungkyung Kim wrote:
>> Fix a warning from checkpathch.pl: 'Missing a blank line after
>> declarations'
>>
>> Signed-off-by: Sungkyung Kim <jotun9935@gmail.com>
>> ---
>>  drivers/staging/erofs/inode.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
>> index 04c61a9d7b76..82b6ad5badff 100644
>> --- a/drivers/staging/erofs/inode.c
>> +++ b/drivers/staging/erofs/inode.c
>> @@ -278,6 +278,7 @@ struct inode *erofs_iget(struct super_block *sb,
>>  	if (inode->i_state & I_NEW) {
>>  		int err;
>>  		struct erofs_vnode *vi = EROFS_V(inode);
>> +
> 
> Thanks for your patch, is there a only one 'Missing a blank line after declarations' in erofs?
> 
> If not, could you have time check the other files? That is my personal thought, and
> I cc-ed the staging mailing list as well.

Agreed, it needs to check all files, and fix similar coding style issues in
one patch.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>  		vi->nid = nid;
>>  
>>  		err = fill_inode(inode, isdir);
>>
> 
> .
> 

