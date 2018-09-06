Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C3FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D7420857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D7420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeIFPOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:14:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727738AbeIFPOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:14:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 241947449EE;
        Thu,  6 Sep 2018 18:39:25 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 18:39:16 +0800
Subject: Re: [PATCH 1/2 dhowells/mount-api] staging: erofs: rename superblock
 flags (MS_xyz -> SB_xyz)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <1536224508-66168-1-git-send-email-gaoxiang25@huawei.com>
 <17402.1536228489@warthog.procyon.org.uk>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <1643231b-7538-0f43-1670-7fddadd7ca87@huawei.com>
Date:   Thu, 6 Sep 2018 18:37:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <17402.1536228489@warthog.procyon.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/6 18:08, David Howells wrote:
> Gao Xiang <gaoxiang25@huawei.com> wrote:
> 
>> This patch follows commit 1751e8a6cb93 ("Rename superblock
>> flags (MS_xyz -> SB_xyz)") and after commit ("vfs: Suppress
>> MS_* flag defs within the kernel unless explicitly enabled"),
>> there is no MS_RDONLY and MS_NOATIME at all.
>>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> I recommend pushing this one to Linus now.  It's trivial enough.

Hi David,
I personally think that is fine, but I'd like to get Greg's idea and agreement, too...

> 
> Reviewed-by: David Howells <dhowells@redhat.com>

Hi Greg,

As David suggested above, could you please help merge this patch to Linus?
It's trivial enough (since the commit 1751e8a6cb93) and MS_xyz will be removed
in the new mount apis patchset...

Thanks in advance...

Thanks,
Gao Xiang
