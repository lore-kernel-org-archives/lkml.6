Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18FCC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A22206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A22206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJETeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:34:01 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35213 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbeJETeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:34:00 -0400
Received: by mail-ua1-f68.google.com with SMTP id m18so4438811uaq.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ys9oB8+PURfnZ3V+gPj7aUxaPEwUS4zlroDvceP2ono=;
        b=ZyOaRWdi0HhcitKxXML3cqx/7CT50oCFQIJAdB4lnqKA2weAIe0RBNZg0y0+GXmUAq
         6x/016M0OeskTagwOKszIYboztffDosqshmdMP/jYVr++XsLbVC1v/V6EqAOv1nD/DkY
         3hWhiIxWDem03V3AIEJ0E0DR+umrWW3D/BIb8qan36QPTyG8i6YfWQhjc2hQsNOm6S33
         FR7T6uM5270DHWaZaKPi4t6CQEbtO7JLG273Bqigsq9LPMr71MyHB0dC15HbKse1wMkY
         kQa0O4WohFwz1dM4pg7YdlDibDz/BW2f/eaKlCcrRvIFyE6ygyougqLUozojsHMBrUgt
         cwmQ==
X-Gm-Message-State: ABuFfogHq2SYtGMirKbT5cgRy8kAxbVMDO//KOFQauBpZbI1t9J7AOF9
        I8wUMBDRpjpMBJXH8Cj6BIpcs0G0RApBWLUvXAI=
X-Google-Smtp-Source: ACcGV62p0zZVMOFdquHf09k/rRONA9XNGi11MH1kG9s/M8HbZbAGp3j3miOlYu+3klqLp16edQK6yLu5J4qcHGVRuVM=
X-Received: by 2002:ab0:47ed:: with SMTP id w45mr4195071uac.78.1538742928281;
 Fri, 05 Oct 2018 05:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181005123021.13364-1-wsa@the-dreams.de>
In-Reply-To: <20181005123021.13364-1-wsa@the-dreams.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 5 Oct 2018 14:35:16 +0200
Message-ID: <CAMuHMdVw0RDa+dqTkN7fk1rfi-=aoDx8JdoEz2QxRQMZDd2DOQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mail to Baoyou Xie bounces, so remove
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baoyou Xie <baoyou.xie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Fri, Oct 5, 2018 at 2:30 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> No activity since late 2017 and I couldn't find a new email address.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> This patch can be happily dropped, of course, if someone knows a new
> contact (and assuming still interest in this maintainership).

I found a recent bug report sent from Baoyou Xie <baoyou.xie@gmail.com> (CCed).

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2263,7 +2263,6 @@ F:        arch/arm/mach-pxa/include/mach/z2.h
>
>  ARM/ZTE ARCHITECTURE
>  M:     Jun Nie <jun.nie@linaro.org>
> -M:     Baoyou Xie <baoyou.xie@linaro.org>
>  M:     Shawn Guo <shawnguo@kernel.org>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
