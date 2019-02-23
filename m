Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5796C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD68A20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBWNWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:22:52 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43178
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbfBWNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:22:51 -0500
X-IronPort-AV: E=Sophos;i="5.58,403,1544482800"; 
   d="scan'208";a="297103495"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2019 14:22:48 +0100
Date:   Sat, 23 Feb 2019 14:22:48 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jules Irenge <jbi.octave@gmail.com>
cc:     jreuter@yaina.de, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        ralf@linux-mips.org, netdev@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] net: ax25: Fix multiple blank lines
 warning
In-Reply-To: <20190223111751.14620-1-jbi.octave@gmail.com>
Message-ID: <alpine.DEB.2.21.1902231421530.2551@hadrien>
References: <20190223111751.14620-1-jbi.octave@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2019, Jules Irenge wrote:

You need a commit message here.

> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  net/ax25/af_ax25.c | 2 --

This is the same file as in your previous patch, so they should be in a
series.

But please work on files in drivers/staging instead.

julia

>  1 file changed, 2 deletions(-)
>
> diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> index 5048790a75f6..2da349b7854a 100644
> --- a/net/ax25/af_ax25.c
> +++ b/net/ax25/af_ax25.c
> @@ -49,8 +49,6 @@
>  #include <net/ip.h>
>  #include <net/arp.h>
>
> -
> -
>  HLIST_HEAD(ax25_list);
>  DEFINE_SPINLOCK(ax25_list_lock);
>
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20190223111751.14620-1-jbi.octave%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
