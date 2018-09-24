Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E20C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2E4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2E4214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeIXTWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:22:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38769 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeIXTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:22:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id z13-v6so9319799qts.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIzR1/hrrLXgQrE8yufc1jiGCT5qUVhXYOOQrqt+xn0=;
        b=kr+xrxGsIT/lNE8OFyO2WsD+UBI2kV/9WO1MM8jqwO4MZyIryJLBuI73geqg6tax+S
         ByA0FyX4xQ8x/VJTt6vZNj+6iglVFRY1jXQXM2+t0S4c0DkLu04wyJ/v95GtWP8pM/0Q
         LBFkBtT1zCPedKBS3x9J8nmoexB/u3PjVAtGa45ce5rDRs1UzJ6f7nAA+rp515pI/RMR
         hLIKkPzMtwptYNHqsTdLnClVs1Rp97sx/3D1+9Ws7oVV8Q3LtzQGI6Qk+yxLsvcmBPZi
         y2VmkNYRIQxUPnfC4MGsVfS1ro2xpdD/fUyFtR9us57b2PGevKyierGgH6ng1dOMBnpt
         jZyA==
X-Gm-Message-State: ABuFfoibijSO/YVIuG8/kVFypjk2Ez4xxiCs4bGm1XuJrQH8MABtokJ6
        Cg2nyYSkseTYD2AYl+DlgOnH2GUwwC7MDT1L+d0=
X-Google-Smtp-Source: ACcGV60pScxNx1Xt8J26SGjIiHA4B+/TJTJ1jQbdiXP2WcfVZFoubr6nittYFMIswrHcb8x2lxfZrLFVqHMlIX297Ng=
X-Received: by 2002:a0c:8834:: with SMTP id 49-v6mr4247272qvl.40.1537795212945;
 Mon, 24 Sep 2018 06:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <1537764195-19117-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1537764195-19117-1-git-send-email-daniel.lezcano@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 15:19:57 +0200
Message-ID: <CAK8P3a0YjbCHRHaTzev-rwi5qM3aBeFUUObL1dPKww_o_J_2vw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Set ARM/LPC18XX architecture orphan
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 6:43 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> While sending patches around, Joachim Eastwood was Cc'ed but I got an error
> its mailbox was full and the mail can not be delivered which makes me think
> there is no body at the other end of the line.
>
> After doing some statistics, it appears the latest commit as author/commiter
> is:
>
> commit b16ebc017ebf52a81e5e88743ccd68fc25e99ba9
> Author: Joachim Eastwood <manabian@gmail.com>
> Date:   Mon Oct 31 14:45:17 2016 +0000
>
> Remove the maintainer entry and set the component as orphan.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I also checked the github account and any other mails I could
find from Joachim, which stopped around the same time.

I've added the lpc32xx maintainers to Cc, as the two platforms are
related. Maybe they are interested in picking up support for this
as well, and/or merge the two directories into one (there is only
one trivial file in mach-lpc18xx, the rest are drivers).

       Arnd

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67e877c..f3612f6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1599,9 +1599,8 @@ L:        linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>
>  ARM/LPC18XX ARCHITECTURE
> -M:     Joachim Eastwood <manabian@gmail.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:     Maintained
> +S:     Orphan
>  F:     arch/arm/boot/dts/lpc43*
>  F:     drivers/clk/nxp/clk-lpc18xx*
>  F:     drivers/clocksource/timer-lpc32xx.c
> --
> 2.7.4
>
