Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38674C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D75720693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D75720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJHUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:32:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbeJHUcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:32:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C7479FAF5E146;
        Mon,  8 Oct 2018 21:21:07 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 8 Oct 2018
 21:21:01 +0800
Subject: Re: [PATCH] staging: erofs: add SPDX identifer
To:     Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20181008104100.2369-1-loic.tourlonias.lkml@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <fe0ab9ae-3b71-7d63-053c-53b6dab95ef6@huawei.com>
Date:   Mon, 8 Oct 2018 21:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181008104100.2369-1-loic.tourlonias.lkml@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 2018/10/8 18:41, Loic Tourlonias wrote:
> Add SPDX identifier to simplify header and remove whole license text
> 
> Signed-off-by: Loic Tourlonias <loic.tourlonias.lkml@gmail.com>
> ---
>  drivers/staging/erofs/lz4defs.h | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/erofs/lz4defs.h b/drivers/staging/erofs/lz4defs.h
> index 00a0b58a0871..bdb1022981d8 100644
> --- a/drivers/staging/erofs/lz4defs.h
> +++ b/drivers/staging/erofs/lz4defs.h
> @@ -1,32 +1,13 @@
>  #ifndef __LZ4DEFS_H__
>  #define __LZ4DEFS_H__
>  
> +// SPDX-License-Identifier: BSD-2-Clause

For *.h files, it seems SPDX Identifier should be /* SPDX-License-Identifier: */
rather than // SPDX-License-Identifier:

And I think it should be placed at the first line of the line, but I am not sure of that.

Thanks,
Gao Xiang

>  /*
>   * lz4defs.h -- common and architecture specific defines for the kernel usage
>  
>   * LZ4 - Fast LZ compression algorithm
>   * Copyright (C) 2011-2016, Yann Collet.
> - * BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions are
> - * met:
> - *	* Redistributions of source code must retain the above copyright
> - *	  notice, this list of conditions and the following disclaimer.
> - *	* Redistributions in binary form must reproduce the above
> - * copyright notice, this list of conditions and the following disclaimer
> - * in the documentation and/or other materials provided with the
> - * distribution.
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
>   * You can contact the author at :
>   *	- LZ4 homepage : http://www.lz4.org
>   *	- LZ4 source repository : https://github.com/lz4/lz4
> 
