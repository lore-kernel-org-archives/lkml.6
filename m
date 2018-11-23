Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA815C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA85620861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85620861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440516AbeKXDQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:16:30 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:40435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388562AbeKXDQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:16:30 -0500
Received: from oxbaltgw59.schlund.de ([172.19.246.146]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McXwD-1fqLBG0VP3-00cvOK; Fri, 23 Nov 2018 17:31:15 +0100
Date:   Fri, 23 Nov 2018 17:31:13 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Marc Zyngier <marc.zyngier@arm.com>, Eric Anholt <eric@anholt.net>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Arlott <simon@arlott.org>
Message-ID: <2029817264.143270.1542990673605@email.ionos.de>
In-Reply-To: <dda72906-fc11-da81-8aa2-c53639b3dbcc@arm.com>
References: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
 <7ab4438c-6cdd-8655-0745-2bbc137970d0@i2se.com>
 <dda72906-fc11-da81-8aa2-c53639b3dbcc@arm.com>
Subject: Re: [PATCH 09/17] irqchip: bcm283x: Switch to SPDX identifier
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:XPVDjVc6eh+Pm3e3we8KcenZpZ/JKpQYd3K/sBJQqVCouGhaGkq
 eMxeJD1pkpfjninNX9Gux7ouyiG8vKAi6m106UW+qDArPYXjT3JCcpxcj1yA6vgR++3nOdW
 Or0EUZNQD7HuW/9A3qN+1018Nb71M06pZbqNcPajDdnphpVj3WzlhE6Po1xArLy7LnqzsTW
 Q0ei5LkBYjlQzE1VfJkjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A4evQH9FZU0=:TKRy9xzLvlq13s8QFp9jvO
 S1jtWRQz2CLpySkotbOFC+I6kHTcHCJBvJmvoIiYbg6LfzfaJMuoAewMmmOtZ6x2T0i5KoJCN
 pxhHFGIfSdX8KPwtIX30w2bPVETSjB7H+4NNvT5/SBCkkxtMCe+Ky5OuXcM0kE6dX4+kXOoDp
 Kz+sHRd7hNMCwpXx+FWTv1tiYmI8sw04rPQ3cyQajLMo/HRXoEdI2ULtkAIPiMO+Uy3vCI1Q3
 /1KcHk41kMFtziBJohZxdxvED2V+IC1Kg7K94FoXUJ12scNo2FuBNt9AzodO1D5S+R0E6KFci
 S/mXPYiI6mopzwCkMaPP+Rd43YV4un8LsQJzZLkwv8k/jont3lHF+kpVFsbUefw+II/CjAf7H
 eyu4RLVm3bD6VLd8dWQU3qDAe6yJqDU9uvbVXe1gWkno45T9hsKn+bWOE/foQEfBomJO3zxNy
 Qr8VBDE0bgBYMyEXbsJw/Zl60Wk1EXREewfjtmWsusAjK9NzT9Hn+stOEeCtwRaMO1r8zBRic
 LOqVxUA19vFPNPngmids1HsDaZz1Ycb1KcdpH60bRBzvPEI0J7NNqrtLENsjM90dTX0cT+Hl1
 gB8axMuPq6TMQP1ZcN+ijRJRZwi1yaXUcsc2LuHxd8wIhy96kP/YFyuY/yGj8lBPb63Z8ffTy
 U1aP1pIPI7nYQ0A63fF1OXsWgpx0uAD6ErI0ns4ZgE2gkYBAbDmUQ1EhQX8gPexQH64j7wi4n
 eVw456tvjkTKX2RlFzMX2fiL+GZBpdLkA5jlGoUuAHjqXRYKkwe7U+aumQzmU1DCasbLCos2H
 5AGMx9A9QX8m8ukO8o4z6riLFzDmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> Marc Zyngier <marc.zyngier@arm.com> hat am 23. November 2018 um 16:34 geschrieben:
> 
> 
> On 23/11/2018 15:23, Stefan Wahren wrote:
> > Hi Jason,
> > hi Marc,
> > 
> > Am 10.11.18 um 16:54 schrieb Stefan Wahren:
> >> Adopt the SPDX license identifier headers to ease license compliance
> >> management.
> >>
> >> Cc: Simon Arlott <simon@arlott.org>
> >> Cc: Eric Anholt <eric@anholt.net>
> >> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >> ---
> >>  drivers/irqchip/irq-bcm2835.c | 11 +----------
> >>  drivers/irqchip/irq-bcm2836.c | 11 +----------
> >>  2 files changed, 2 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> >> index d2da8a1..418245d 100644
> >> --- a/drivers/irqchip/irq-bcm2835.c
> >> +++ b/drivers/irqchip/irq-bcm2835.c
> >> @@ -1,17 +1,8 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >>  /*
> >>   * Copyright 2010 Broadcom
> >>   * Copyright 2012 Simon Arlott, Chris Boot, Stephen Warren
> >>   *
> >> - * This program is free software; you can redistribute it and/or modify
> >> - * it under the terms of the GNU General Public License as published by
> >> - * the Free Software Foundation; either version 2 of the License, or
> >> - * (at your option) any later version.
> >> - *
> >> - * This program is distributed in the hope that it will be useful,
> >> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> - * GNU General Public License for more details.
> >> - *
> >>   * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
> >>   *
> >>   * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
> >> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> >> index dfe4a46..2038693 100644
> >> --- a/drivers/irqchip/irq-bcm2836.c
> >> +++ b/drivers/irqchip/irq-bcm2836.c
> >> @@ -1,17 +1,8 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >>  /*
> >>   * Root interrupt controller for the BCM2836 (Raspberry Pi 2).
> >>   *
> >>   * Copyright 2015 Broadcom
> >> - *
> >> - * This program is free software; you can redistribute it and/or modify
> >> - * it under the terms of the GNU General Public License as published by
> >> - * the Free Software Foundation; either version 2 of the License, or
> >> - * (at your option) any later version.
> >> - *
> >> - * This program is distributed in the hope that it will be useful,
> >> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> - * GNU General Public License for more details.
> >>   */
> >>  
> >>  #include <linux/cpu.h>
> > 
> > Eric already made a review. Are you fine with it?
> 
> Sure. How do you want this to go in?

i would prefer if this patch go via irqchip tree.

Thanks Stefan

> If you have a series repainting
> multiple subsystems, I'd rather it stays as such, and you can stick my
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> on it.
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
