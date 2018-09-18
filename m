Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDC7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2652150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2652150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeIRUvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:51:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbeIRUvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:51:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C3314C2AED4D5;
        Tue, 18 Sep 2018 23:18:12 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 23:18:11 +0800
Message-ID: <5BA11732.3060500@huawei.com>
Date:   Tue, 18 Sep 2018 23:18:10 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <shawnguo@kernel.org>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com> <5BA112BC.8080108@huawei.com> <20180918150244.GA21766@kroah.com>
In-Reply-To: <20180918150244.GA21766@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/18 23:02, Greg KH wrote:
> On Tue, Sep 18, 2018 at 10:59:08PM +0800, zhong jiang wrote:
>> Hi,  Greg
>>
>> Can you pick up the patch? 
> Nope:
> $ ./scripts/get_maintainer.pl --file drivers/gpu/drm/zte/zx_drm_drv.c
> Shawn Guo <shawnguo@kernel.org> (maintainer:DRM DRIVERS FOR ZTE ZX)
> David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
> dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ZTE ZX)
> linux-kernel@vger.kernel.org (open list)
>
> why would I take thi when all of those others are the correct
> maintainers?
>
> Also, you only posted this 1 day ago.  Please relax and give people time
> and a chance to review your patch.  It is not instant.
No,  I posted the patch a month ago.  I have sent a ping. but It do not work. :-( . 

Thanks,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


