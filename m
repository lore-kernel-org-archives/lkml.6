Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B6520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfAQKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:24:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35479 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfAQKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:24:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so5908230vsc.2;
        Thu, 17 Jan 2019 02:24:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFaszenHP0mg2Zminh7yDg/lWMiPNkpGV9LlgJOnUME=;
        b=WUoiYro2s2BfsHwpopTYpxKjiWnRazrsq7RB0cqtvjliHb/dDiRIDYfcof3eJ4aPew
         fHfFuqjTRT3ZbSXvP6i9rjHX8nx/e+zTn4GyXtA9zWHETVOQs8c2nqChYUh4uYE6HSxR
         bR1hPb3qpW6muKa64YJSb6OqG2Szv+Gpz8AN7UlFWLojIDrNbF1QkSdxr1BxUuy6yQ5H
         3FpUOG190zRAT7U3DExuhn0Ci8T0RVmbh2pqxWGI3gCcQSgz66Egz8nCOY7CPeSmxfel
         MPtCV1tkLGk+EVXLQOebZy0+h4aLPWp5by379n41Sk0Xtz2u+8zbPTTgCvd7oeZeWk2V
         gBLw==
X-Gm-Message-State: AJcUukeuY6UwG/S8I0ynl1OG1Hd8TEaAZXWlVY4EWDGd1zR1yvWeMOnX
        a88TdjNTtXmU3yfhkCtIfm+Mh3rdvm7BWiLaRNQ=
X-Google-Smtp-Source: ALg8bN6UkWZ+lV9e2poKQFRM/gE3waxIF4+nqOVdrWrO69gQ6EIZJne2WYrdq8JfzXTc6bOjT1X5oIDmriwnBZHhKH0=
X-Received: by 2002:a67:d119:: with SMTP id u25mr5175134vsi.63.1547720657774;
 Thu, 17 Jan 2019 02:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20190117101321.2164-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190117101321.2164-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Jan 2019 11:24:06 +0100
Message-ID: <CAMuHMdWtXA9Q66vCuG6U-+04kqu2F=DOA63pTkeMZ06EzfOQkQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: driver: fix wire name for I2C
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:14 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Typo: the data line is called "SDA" not "SCA".
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
