Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB6CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95646206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95646206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410097AbeKXCIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:08:35 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55597 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbeKXCIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:08:34 -0500
Received: from [192.168.178.52] ([109.104.55.85]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2E9Y-1fQImF2nPi-013ez7; Fri, 23 Nov 2018 16:23:37 +0100
Subject: Re: [PATCH 09/17] irqchip: bcm283x: Switch to SPDX identifier
To:     Eric Anholt <eric@anholt.net>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Arlott <simon@arlott.org>
References: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <7ab4438c-6cdd-8655-0745-2bbc137970d0@i2se.com>
Date:   Fri, 23 Nov 2018 16:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:eBCPkaoMljw60Dtdj1H7PGjhVOJpcPJrmyuMFkg7d2Mq2XRZL7u
 6dDjsmLfI5ZyOYTRBwcZXb5h/SDfxu7Nxs16KrXr7pTGp4XOJCqEq8TCj76BYFFLGlZZMTK
 PN2YLX071P/30AhT0u0wmOoPSN+/oJioiGN5cyaOqhwiZqZkwyTy1smDdK5wMrkvYu4iS7p
 jP90O3aOltcC5tjaOGk9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7FS/EWDgGw=:pn6g3LUdn348mG6a9MPDfx
 msdByhWT/wzlOt4fgSk+mUk2210ReVxEIwGt8ubij1PicWAmbE4t8n0vg5Upxm9aoGUtLNppD
 VLoddOCyju/OhsKG5FX2joV5qVRPV1aQkIL7RG3AaguOAxO6ySV8M/Png+JC+mrfXCpzSivLs
 XNSzzq6wQXc0iXPLs8UjYvtOzBmX7Vv9PI61PfXpQHq5AQ4D/WgFC7QQcmfFc1/Asms7yZWgZ
 OyUv5H7KQWO7sRPk581xwwkXB+UH4l2uBD9ADnRomzuFtqdQNRIZG77RR0b6mdJONAOZQFxbn
 vYOl0PllXX2JD3OCCqKS/BztRqGP43j9/yfYqEcxlUQdfaakxwruP2K4B2OixqPigvl6rBNC+
 o/OAvbu30Ewujtpr7HtAVJKxnq3SUG2Nx0NUYPtG+i1F6zYCJ/xschYLVqSPyiy0S4WpoJOGM
 QBKVTTvUUni2j4ZKUgprcZ44m7hpweFvq2avomEO/EnTnAFRbGlD0hI717ghKExCbu8kwtpGi
 SgabFiK4I/4p4vt555XlVLO67Feg1fT5zu2SbMwUYrvTqweF3x3uBq8FiWLyWBEiGucK2hhwl
 1NmX2zU5/AjhKFalM5WhKoaMsJhM7wrKDIDRAOTP/3k/z5SMfQ48a+fFbLtzlKLxOgMMODYGS
 axskx0vlwqG+VhgkwsuKaenKXZjIs7FzF1Sx+8HaiOsZOMUweQkZwddnARhoYbLdYXMUp5pYv
 AqGF8IjcqXDgTU5eGE+AiOQJRK+5h05JOxM+SBP/CXZdkP79+trRKleQGxkCDWqoGhrFIam/M
 4oxEPgMt8t9DicyKrooAA4o3aDPPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,
hi Marc,

Am 10.11.18 um 16:54 schrieb Stefan Wahren:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Cc: Simon Arlott <simon@arlott.org>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/irqchip/irq-bcm2835.c | 11 +----------
>  drivers/irqchip/irq-bcm2836.c | 11 +----------
>  2 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> index d2da8a1..418245d 100644
> --- a/drivers/irqchip/irq-bcm2835.c
> +++ b/drivers/irqchip/irq-bcm2835.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright 2010 Broadcom
>   * Copyright 2012 Simon Arlott, Chris Boot, Stephen Warren
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
>   *
>   * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index dfe4a46..2038693 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Root interrupt controller for the BCM2836 (Raspberry Pi 2).
>   *
>   * Copyright 2015 Broadcom
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/cpu.h>

Eric already made a review. Are you fine with it?

Stefan

