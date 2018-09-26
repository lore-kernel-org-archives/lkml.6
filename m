Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352ACC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBB3214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBB3214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeIZRy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:54:26 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40592 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeIZRy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:54:26 -0400
Received: by mail-vs1-f66.google.com with SMTP id z130-v6so4221855vsc.7;
        Wed, 26 Sep 2018 04:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UETU5qzMInr0XD+KEGNysUiyxZYOa5rBe6BkaJxJbSM=;
        b=siFPgj8MNELdDCmsvNc7BMub1YuqcnT58xk65DWgv4iU3qB2ADNxwVZuwLLn+wFyKG
         ea542uhx3hOfoe327cFUp8UsAIR3wInfQJXxuhWs6L+QX43i1YUzO7TkjIt0zkUOkeCp
         h68ds1ooGNpv4SC+GHY+pHvVA76AwH+89ozflhH8/f7o83aEmywiYjqndMNd2wAlTHXk
         yjJBsx8l0/B1IXvJH8RJ6KE7LK7eadvojACz/606TB680ciiqIcw/xx9YGW7qHPxTRIk
         Zne74pnZAForzMIwfw3vIfbCttVK4FmCJt7G6FdSe8pxRUUyFZ6NHGsBqltCfXk/P8cV
         dVSg==
X-Gm-Message-State: ABuFfohF6G7A+QVzTlCduGs7O8SqePIX1INB120XwXBqV6tsL8+CyWt1
        dL7KsDBP2coJfwL2zPKz+1XrQZb3agDJhn4P4NxsDQ==
X-Google-Smtp-Source: ACcGV60CSO7sLOLLuvRn/QZQMwJTX7+h9EnCxZocK/q3dlGGrgdHsKzM3+afJcksPIP+D96NTM1kSItWYUxZIOMLkqs=
X-Received: by 2002:a67:68ce:: with SMTP id d197-v6mr468087vsc.152.1537962111153;
 Wed, 26 Sep 2018 04:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180926091053.21255-1-phil.edworthy@renesas.com> <20180926091053.21255-4-phil.edworthy@renesas.com>
In-Reply-To: <20180926091053.21255-4-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Sep 2018 13:41:39 +0200
Message-ID: <CAMuHMdVg8XZQxpGM5ZB5P03SNbsr3y=kBg-pftNrRLt6xE-34w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ARM: dts: r9a06g032: Add pinctrl node
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:11 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> This provides a pinctrl driver for the Renesas R9A06G032 SoC
>
> Based on a patch originally written by Michel Pollet at Renesas.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
