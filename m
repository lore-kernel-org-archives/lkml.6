Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF70C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC020851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BC020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeKTL3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:29:14 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50660 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeKTL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:29:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id AC29627C98;
        Mon, 19 Nov 2018 20:02:44 -0500 (EST)
Date:   Tue, 20 Nov 2018 12:02:49 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/14] m68k: mac: Clean up unused timer
 definitions
In-Reply-To: <fff9ef81e86dc588335bdb0a623a851d324315e9.1542589838.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1811201157510.250@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <fff9ef81e86dc588335bdb0a623a851d324315e9.1542589838.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert,

Please consider cherry-picking this patch. It isn't particularly relevant 
to the API conversion so I'd better not to include it in v3, when I submit 
v3.

-- 

On Mon, 19 Nov 2018, Finn Thain wrote:

> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>  arch/m68k/include/asm/macints.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/macints.h b/arch/m68k/include/asm/macints.h
> index cddb2d3ea49b..4da172bd048c 100644
> --- a/arch/m68k/include/asm/macints.h
> +++ b/arch/m68k/include/asm/macints.h
> @@ -121,7 +121,4 @@
>  #define SLOT2IRQ(x)	  (x + 47)
>  #define IRQ2SLOT(x)	  (x - 47)
>  
> -#define INT_CLK   24576	    /* CLK while int_clk =2.456MHz and divide = 100 */
> -#define INT_TICKS 246	    /* to make sched_time = 99.902... HZ */
> -
>  #endif /* asm/macints.h */
> 
