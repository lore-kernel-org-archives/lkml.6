Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FBFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F5B20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F5B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKSGmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:42:42 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36548 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKSGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:42:40 -0500
Received: by mail-ua1-f65.google.com with SMTP id j3so10015280uap.3;
        Sun, 18 Nov 2018 12:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gN2d6u0WDxp40EqbBOFTL9LFRlYMZZJnkg/iMAJIljc=;
        b=Viumdit6D2wVez1IyrM1VZbOMm2TpDTRmoLcD64iulpNNI7OK2iMF0U3yMlu8mQ5Cy
         GlurnVniJDsWVhjQ7ZZPgzSX4IKEFGcQMqE7HSzgDDhLuLFAmfY/kUVWg9o6TO0Xbpm/
         QMqMHWOanY2XgTwePB4Ze+TdAKQO8J2F9f+MinDgPpkPjOT0aO1shqNU+schysAHz5w2
         XcIspglUsOswVwEAaHgIFKdqWG/u7qXg5zU8Z3xQPzugk6qFevIpPaND1753L+RQTbp2
         Iz5oYfxyOL9XD1I334cNMrNhqpjFQDU5SpXY7bwMh1LX8TKpQGjwdFvqdyUfChw58BV+
         qS6Q==
X-Gm-Message-State: AGRZ1gK8BvIIt75PaLq/hxAUoG9eGjGHeJxEbIKuor+1iKlK7hSKpr9Z
        G0BL40zUlJUdXmvt3KnmV/+xeK+0BZrREPH+zkM=
X-Google-Smtp-Source: AJdET5fut298vE5ge9R0LRW+btbrZzhRby+ol8nKEwG5z5QwUa5GnQiU0QGjICVHi8OUC4lmaRxkpDB1NXduvD3cmbA=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr8245143uae.75.1542572482650;
 Sun, 18 Nov 2018 12:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20181106222750.12939-1-aaro.koskinen@iki.fi>
In-Reply-To: <20181106222750.12939-1-aaro.koskinen@iki.fi>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Nov 2018 21:21:11 +0100
Message-ID: <CAMuHMdVCWLmyS+rFEQBHFGTpkw2=xk+Ub9VCnaobA+L9vGLOHw@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: update OMAP MMC entry
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        ext Tony Lindgren <tony@atomide.com>,
        jarkko.lavinen@nokia.com,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        j.lavinen@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaro,

CC Jarkko (from his last patch)

On Tue, Nov 6, 2018 at 11:29 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Jarkko's e-mail address hasn't worked for a long time. We still want
> to keep this driver working as it is critical for some of the OMAP boards.
> I use and test this driver frequently, so change myself as a maintainer
> with "Odd Fixes" status.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
>         v2: Add Jarkko to CREDITS.
>
>         v1: https://patchwork.kernel.org/patch/10369861/
>
> diff --git a/CREDITS b/CREDITS
> index 5befd2d714d0..84cbec4c6211 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2138,6 +2138,10 @@ E: paul@laufernet.com
>  D: Soundblaster driver fixes, ISAPnP quirk
>  S: California, USA
>
> +N: Jarkko Lavinen
> +E: jarkko.lavinen@nokia.com

If this address hasn't worked for a long time, what's the point of adding
it to CREDITS?

> +D: OMAP MMC support
> +
>  N: Jonathan Layes
>  D: ARPD support
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f325..1c2badfec2ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10793,9 +10793,9 @@ F:      drivers/media/platform/omap3isp/
>  F:     drivers/staging/media/omap4iss/
>
>  OMAP MMC SUPPORT
> -M:     Jarkko Lavinen <jarkko.lavinen@nokia.com>
> +M:     Aaro Koskinen <aaro.koskinen@iki.fi>
>  L:     linux-omap@vger.kernel.org
> -S:     Maintained
> +S:     Odd Fixes
>  F:     drivers/mmc/host/omap.c
>
>  OMAP POWER MANAGEMENT SUPPORT

Seems like Jarkko himself tried to update his address a long time ago,
but the patch was never applied?
https://lore.kernel.org/lkml/1380886987-20517-1-git-send-email-j.lavinen@samsung.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
