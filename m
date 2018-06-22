Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBA8241A8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBA8241A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeFVMOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:14:45 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46864 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:14:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id b134-v6so3763924vke.13;
        Fri, 22 Jun 2018 05:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4nEGCrd0zf6AXCuFkxvhZkf3e5imlxghkkIB50bC+I=;
        b=C0fHXQSdZpT/xKugfVG2qG/3DfIkxu31T1y+iNIacr4Gv/HvuOTihZW3ewH/8k5XmB
         CkE/p0OkKyOzm7YlxwRkJ+4UDoPmdwdGWU23h+zveIHbtY/6oRBTxEl5LuGU8WvFPbDO
         2stwEgA/AuH726mtIJOnIi9K2c2AwlC5NpCLtxx88CsM4nzeCVMp7LBCbg6GUptdSWQk
         2vmMF29BJjW5Yq23/q0Q3zbqqhop+RCZY6hNrQyNsgnOvjS347UOku890mgJVhFc16gQ
         +dt+isjQkaOpmCueBQt/5KYdf/1yfDv1GJq1fL7hRU/bqgW9mRAxTyA9aK5Uo0VTZ2LN
         rHqg==
X-Gm-Message-State: APt69E3SFWBb9oW71z+lzFo96kWHvFsVflb/zMDPtqhJcOMiMBJbuaPG
        ZPiLEJ8bbKPP60aaD58yJCaw5qo9ByIhQqP6r6o=
X-Google-Smtp-Source: ADUXVKL++pF9T672h/0S/yThskPOo7AolQQeSK+5IKrAsoljBWRILP4FI2xG5ZxuRdyI+wrer/6K7UIZNqZ6FmheJwc=
X-Received: by 2002:a1f:eecc:: with SMTP id m195-v6mr793643vkh.50.1529669681728;
 Fri, 22 Jun 2018 05:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com> <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 14:14:30 +0200
Message-ID: <CAMuHMdXamhn2GZs41i=wHXSRn0HgeHg4=7=g7pg7uni3LizK9w@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] ARM: dts: Renesas R9A06G032 base device tree file
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

CC MarcZ

On Thu, Jun 14, 2018 at 1:02 PM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas R9A06G032 bare bone support.
>
> This currently only handles the SYSCTRL block note,
> generic parts (gic, architected timer) and a UART.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi

> +       timer {
> +               compatible = "arm,cortex-a7-timer",

Checkpatch says:
WARNING: DT compatible string "arm,cortex-a7-timer" appears
un-documented -- check ./Documentation/devicetree/bindings/

> +                            "arm,armv7-timer";

Documentation/devicetree/bindings/arm/arch_timer.txt says:

    compatible should at least contain "arm,armv7-timer"

but fails to list other possible values?

> +               interrupt-parent = <&gic>;
> +               arm,cpu-registers-not-fw-configured;
> +               always-on;
> +               interrupts =
> +                       <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                       <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                       <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                       <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
