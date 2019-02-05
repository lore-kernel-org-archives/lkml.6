Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA291C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854FC2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="kE1ZQQ6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBEAle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:41:34 -0500
Received: from vern.gendns.com ([98.142.107.122]:35490 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfBEAld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x1IBYwMqTuE0fCSkVpBVTu6oQAZSMUD6tRou2yPJdwk=; b=kE1ZQQ6AmT5JqL9crI/O7HgwNW
        Equa0IWwCHmpUShxeoxAzYLPl+jbHUy06/E322g2fdonvOY9uD9WC9c4QzCpCYZZeFPbm/GaZ75Ah
        J9gvrnM+xzpTnQrse2XmU+bEADL555/AfW1Gpo3q6IIYHZWdIFNyhTG7naWx7sDJmWHyfABrGN7kR
        GsZPrEFAiyCGCKM99ynm99Rk2JNIrhxPl5Hn7Sn4dJZTDG2QtCWypWOXH287wUqT/GmNlYcHWpopb
        ickxEpXe7o1Rhf4gwj5lw8RPSYKU3NZbi8c5s14YbiUJ0e7LVYdNfdcUEwiZhom4vbgH1BAdITKGQ
        gluHI+Tg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60758 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqokO-00053t-3l; Mon, 04 Feb 2019 19:37:56 -0500
Subject: Re: [PATCH 29/35] ARM: davinci: cp-intc: drop GPL license boilerplate
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-30-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <a455d610-bbaf-bb70-9e4b-09c56bc15181@lechnology.com>
Date:   Mon, 4 Feb 2019 18:41:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-30-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Replace the GPLv2 license boilerplate with an SPDX identifier.

Should also mention that you are adding an author and copyright.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 812e49fcaa8b..780b3f57aa59 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -1,13 +1,11 @@
> -/*
> - * TI Common Platform Interrupt Controller (cp_intc) driver
> - *
> - * Author: Steve Chen <schen@mvista.com>
> - * Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
> - */
> +// SPDX-License-Identifier: GPL-2.0

GPL-2.0-only ?

> +//
> +// Author: Steve Chen <schen@mvista.com>
> +// Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +// Copyright (C) 2019, Texas Instruments
> +//
> +// TI Common Platform Interrupt Controller (cp_intc) driver
>   
>   #include <linux/export.h>
>   #include <linux/init.h>
> 

