Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04755C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73342082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73342082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLKLWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:22:31 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35899 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeLKLWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:22:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B27EA5C890133;
        Tue, 11 Dec 2018 19:22:27 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 11 Dec
 2018 19:22:21 +0800
Subject: Re: [PATCH 2/5] drivers: staging: erofs: Fix comparison to NULL
 issues.
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@i4.cs.fau.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
 <20181211105443.21826-3-aaron.strahlberger@posteo.de>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <fcfd717b-13ed-a189-a056-13edca9b08b7@huawei.com>
Date:   Tue, 11 Dec 2018 19:22:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181211105443.21826-3-aaron.strahlberger@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On 2018/12/11 18:54, Aaron Strahlberger wrote:
> Fix of 7 `CHECK: Comparison to NULL could be written ...` issues.
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>
> ---
>  drivers/staging/erofs/data.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

It has been fixed in the following upstreamed commit...
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/drivers/staging/erofs/data.c?h=staging-next&id=d1ab82443bed2b2562e5331d6aa53e3b878b16d0

and the "git am -k -3" log
[gaoxiang@138 linux-staging]$ git am -k -3 1.patch
Applying: Fix of 7 `CHECK: Comparison to NULL could be written ...` issues.
Using index info to reconstruct a base tree...
M       drivers/staging/erofs/data.c
Falling back to patching base and 3-way merge...
No changes -- Patch already applied.


Thanks,
Gao Xiang

