Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D452C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE3120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE3120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeILNhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:37:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeILNhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:37:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5E05C6C48197E;
        Wed, 12 Sep 2018 16:34:02 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 16:33:54 +0800
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        <devel@driverdev.osuosl.org>, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, <weidu.du@huawei.com>,
        <linux-erofs@lists.ozlabs.org>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
 <20180828054444.GA4453@kroah.com>
 <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
 <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
 <20180828130559.GA5427@kroah.com>
 <16974cb6-2eed-7c12-9e27-c65a32b81673@huawei.com>
 <20180829094403.3a3bf19b@canb.auug.org.au>
 <20180906092504.282d5f62@canb.auug.org.au>
 <58dbf050-ac24-9d8a-bbf3-0e28e10149ff@huawei.com>
 <20180912173404.288ea2e5@canb.auug.org.au>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bdb3e07b-b769-34a4-28c9-630131db2c55@huawei.com>
Date:   Wed, 12 Sep 2018 16:33:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912173404.288ea2e5@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2018/9/12 15:34, Stephen Rothwell wrote:
> Hi Chao,
> 
> On Wed, 12 Sep 2018 15:19:16 +0800 Chao Yu <yuchao0@huawei.com> wrote:
>>
>> To make sure, did -next tree enable erofs compiling now?
> 
> Yes, from yesterday.

Great, thanks for your help. :)

> 
>> Xiang has made two patches to fix integration issue with other vfs changes,
>> and Greg and David have already picked them in their tree.
>>
>> staging: erofs: rename superblock flags (MS_xyz -> SB_xyz)
>> staging: erofs: update .mount and .remount_sb
> 
> I noticed, thanks.
> 

