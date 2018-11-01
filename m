Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D8CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831022081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831022081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKATQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:16:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57205 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeKATQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:16:30 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gI9zG-0002N7-Ml; Thu, 01 Nov 2018 11:14:02 +0100
Date:   Thu, 1 Nov 2018 11:14:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peng Hao <penghao122@sina.com.cn>
cc:     rkrcmar@redhat.com, pbonzini@redhat.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH] kvmclock : convert to SPDX identifiers
In-Reply-To: <1541007211-5041-1-git-send-email-penghao122@sina.com.cn>
Message-ID: <alpine.DEB.2.21.1811011105020.1642@nanos.tec.linutronix.de>
References: <1541007211-5041-1-git-send-email-penghao122@sina.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peng,

On Wed, 31 Oct 2018, Peng Hao wrote:

a few nitpicks upfront. The proper prefix for this is: x86/kvmclock

Most of the time, you can deduce the prefix from running 'git log
path/to/file'.

> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text

git grep 'This patch' Documentation/process

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/x86/kernel/kvmclock.c | 15 +--------------
>  1 files changed, 1 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 1e67646..0ebd715 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -1,19 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0

But, this is the wrong tag. The verbose text has:

> -    the Free Software Foundation; either version 2 of the License, or
> -    (at your option) any later version.

So what you want here is: GPL-2.0+ or GPL-2.0-or-later

You really need to be very careful when replacing boiler plate text with
SPDX identifiers.

Thanks,

	tglx
