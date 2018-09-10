Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18510C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E2C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNWE12pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E2C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeIJUys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeIJUys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:54:48 -0400
Received: from [192.168.0.101] (unknown [49.77.179.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659AA20865;
        Mon, 10 Sep 2018 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536595203;
        bh=3cZhwFVPU1w4eSrTiV0BzCIvAYgTam4YnTRwJ2jqioY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HNWE12pPfFY72POwG6QI/7BE51M0Hqy+HzfNR86aO3H+MA6WTLQGI+jPAszAykAqg
         wzONGg/YADvYu41J3Joyv9ovMbFmJ7eLO9RR/CUlA+YNdnT/d3SJQXi6uKXvjSvslf
         kZG/SXrQ9TqNsSyYDiS3oG3d43laoBxXvhAJcpwY=
Subject: Re: [PATCH] MAINTAINERS: add tree location for staging/erofs
To:     Gao Xiang <gaoxiang25@huawei.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5c44a63b-041d-1fce-0748-53c0b44f5983@huawei.com>
 <20180909183432.9752-1-linux@weissschuh.net>
 <2dc6fb51-dfd6-3509-8833-c889193dd4a9@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <23218dc6-8aba-a4e6-7c18-64380082f747@kernel.org>
Date:   Mon, 10 Sep 2018 23:59:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2dc6fb51-dfd6-3509-8833-c889193dd4a9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 11:56, Gao Xiang wrote:
> 
> 
> On 2018/9/10 2:34, Thomas Weißschuh wrote:
>> Hi Chao, hi Gao,
>>
>> On Sun, 2018-09-09T23:16+0800, Chao Yu wrote:
>>> Hi Thomas,
>>>
>>> On 2018/9/8 11:28, Gao Xiang wrote:
>>>> Hi Thomas,
>>>>
>>>> Thanks for your new patch.
>>>>
>>>> It seems that this patch also introduces 2 new 'WARNING: line over 80 characters',
>>>> could you please fix it in the patch?
>>
>> @Chao,Gao: For some reason there seems to be a problem when receiving mails
>> from you. The one I received now was the first one from you that reached me
>> directly. Before I only got your messages in the quotes from Dan and now in the
>> quotes from the mail I am responding to.
>> (I will try to investigate the reason for this)
>>
>> Sorry for my slow responses before.
>>
>>> It will be better to fix that.
>>
>> A new patch will shortly follow.
>>
>>> Some reviewed cleanup patches are merged before this patch, then I failed to add
>>> this one, so could you rebase on top of erofs dev branch in below link:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs
>>
>> I was not aware of this tree and worked off of staging / next.
>> A patch is attached to this message that adds the tree to the MAINTAINERS file.
> 
> Hi Chao,
> 
> I think this tree has some PREVIEW patches which preview in linux-erofs mailing list only and
> doesn't send to staging mailing list and LKML,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=erofs
> 
> so erofs tree is actually Greg's staging tree.

Thomas,

I confirmed that erofs git repository for linux upstream is Greg's staging tree.

Let me explain, in order to avoid sending buggy or preview patch, Xiang and me
plan to review patches in erofs mailing list first, and then cache reviewed
patches in my git tree before sending them to Greg and staging mailing list.

Based on that, I'm trying to serialize all erofs patches, expecting that can
help those patches sent to staging mailing list can be merged by Greg with
lesser conflict. But I made a mistake that my erofs branch has merged some
pending patches, result in failing to merge yours, that mislead me to ask you to
rebase the code, sorry about that.

Now I can confirm that your v2 patch can apply on Greg's staging-next, so fixing
warning reported by checkpatch.pl on your v2 patch is enough. :)

Thanks,

> 
>>
>> -- >8 --
>>
>> Currently this location is not documented.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a5b256b25905..9087e0b74821 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13747,6 +13747,7 @@ F:	drivers/staging/comedi/
>>  STAGING - EROFS FILE SYSTEM
>>  M:	Gao Xiang <gaoxiang25@huawei.com>
>>  M:	Chao Yu <yuchao0@huawei.com>
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git erofs
> 
> Hi Thomas,
> nope, the erofs tree is actually the same as staging tree, so any patch should be based
> on Greg's upstream tree.
> 
> Thanks,
> Gao Xiang
> 
>>  L:	linux-erofs@lists.ozlabs.org
>>  S:	Maintained
>>  F:	drivers/staging/erofs/
>>
