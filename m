Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE62BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A1B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A1B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeIJIsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:48:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeIJIsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:48:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D6F6830F8BA9F;
        Mon, 10 Sep 2018 11:56:45 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 10 Sep
 2018 11:56:41 +0800
Subject: Re: [PATCH] MAINTAINERS: add tree location for staging/erofs
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
 <20180909183432.9752-1-linux@weissschuh.net>
From:   Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <2dc6fb51-dfd6-3509-8833-c889193dd4a9@huawei.com>
Date:   Mon, 10 Sep 2018 11:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180909183432.9752-1-linux@weissschuh.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/10 2:34, Thomas Weißschuh wrote:
> Hi Chao, hi Gao,
> 
> On Sun, 2018-09-09T23:16+0800, Chao Yu wrote:
>> Hi Thomas,
>>
>> On 2018/9/8 11:28, Gao Xiang wrote:
>>> Hi Thomas,
>>>
>>> Thanks for your new patch.
>>>
>>> It seems that this patch also introduces 2 new 'WARNING: line over 80 characters',
>>> could you please fix it in the patch?
> 
> @Chao,Gao: For some reason there seems to be a problem when receiving mails
> from you. The one I received now was the first one from you that reached me
> directly. Before I only got your messages in the quotes from Dan and now in the
> quotes from the mail I am responding to.
> (I will try to investigate the reason for this)
> 
> Sorry for my slow responses before.
> 
>> It will be better to fix that.
> 
> A new patch will shortly follow.
> 
>> Some reviewed cleanup patches are merged before this patch, then I failed to add
>> this one, so could you rebase on top of erofs dev branch in below link:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs
> 
> I was not aware of this tree and worked off of staging / next.
> A patch is attached to this message that adds the tree to the MAINTAINERS file.

Hi Chao,

I think this tree has some PREVIEW patches which preview in linux-erofs mailing list only and
doesn't send to staging mailing list and LKML,

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs

so erofs tree is actually Greg's staging tree.

> 
> -- >8 --
> 
> Currently this location is not documented.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b25905..9087e0b74821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13747,6 +13747,7 @@ F:	drivers/staging/comedi/
>  STAGING - EROFS FILE SYSTEM
>  M:	Gao Xiang <gaoxiang25@huawei.com>
>  M:	Chao Yu <yuchao0@huawei.com>
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git erofs

Hi Thomas,
nope, the erofs tree is actually the same as staging tree, so any patch should be based
on Greg's upstream tree.

Thanks,
Gao Xiang

>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  F:	drivers/staging/erofs/
> 
