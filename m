Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED86C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2770206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2770206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeIJNOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:14:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbeIJNOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:14:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3176B7F72A32;
        Mon, 10 Sep 2018 16:21:27 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 10 Sep
 2018 16:21:22 +0800
Subject: Re: [PATCH 1/2 dhowells/mount-api] staging: erofs: rename superblock
 flags (MS_xyz -> SB_xyz)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, <weidu.du@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-erofs@lists.ozlabs.org>
References: <1536224508-66168-1-git-send-email-gaoxiang25@huawei.com>
 <17402.1536228489@warthog.procyon.org.uk>
 <1643231b-7538-0f43-1670-7fddadd7ca87@huawei.com>
 <20180910081304.GA19096@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <5c8b8c33-ceff-f1c7-866b-3d58167be7ac@huawei.com>
Date:   Mon, 10 Sep 2018 16:21:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180910081304.GA19096@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/9/10 16:13, Greg Kroah-Hartman wrote:
> On Thu, Sep 06, 2018 at 06:37:37PM +0800, Gao Xiang wrote:
>>
>>
>> On 2018/9/6 18:08, David Howells wrote:
>>> Gao Xiang <gaoxiang25@huawei.com> wrote:
>>>
>>>> This patch follows commit 1751e8a6cb93 ("Rename superblock
>>>> flags (MS_xyz -> SB_xyz)") and after commit ("vfs: Suppress
>>>> MS_* flag defs within the kernel unless explicitly enabled"),
>>>> there is no MS_RDONLY and MS_NOATIME at all.
>>>>
>>>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>> I recommend pushing this one to Linus now.  It's trivial enough.
>>
>> Hi David,
>> I personally think that is fine, but I'd like to get Greg's idea and agreement, too...
>>
>>>
>>> Reviewed-by: David Howells <dhowells@redhat.com>
>>
>> Hi Greg,
>>
>> As David suggested above, could you please help merge this patch to Linus?
>> It's trivial enough (since the commit 1751e8a6cb93) and MS_xyz will be removed
>> in the new mount apis patchset...
> 
> Now applied to my local tree, thanks.
> 

Thanks for applying. :)

Thanks,
Gao Xiang


> greg k-h
> 
