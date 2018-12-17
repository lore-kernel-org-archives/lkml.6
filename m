Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39610C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1373D206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeLQQEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:04:39 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33303 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeLQQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:04:38 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so2959169vka.0;
        Mon, 17 Dec 2018 08:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aygFarhoqpcyMq3/upStBIT7RWvxGMUx7ETRaBhZXs4=;
        b=jGoZnxFduYZk7xe6FJtwBWhFt/FsPq3kmaWjiOTOESRB+GK2Og5649pVHnwS2zmc/3
         yBCxVVv8/LkMTVqumxHEU8FHgLgLy2lTP1CzVYVkceHQEF4z1cxfREUAMSJ8BMoPZoy7
         peXxcBvg53L4Y/Pp5A+Qv3BLjz73XwghVgAj82YOGooGG89qVXdEB5ljY+E2KWRizdl9
         8BlmSlujCzLYfRlvwV4TlKoeFlAi6C3ybjWHfk0F4zO9vDQE678O7IJwpN2Hf4UUFdgu
         1g2MrKVlw6NmDGvgxsZ+h8Pp49rpP6cC313/0Vk0rsnMLa3f1WeCeeUUnC6I25qh8jik
         855A==
X-Gm-Message-State: AA+aEWZ3OmTLR23VXYswVyAVHDiW30gsIYhNpsiEly8trtgWwwwY+oGf
        0vYGV/yrZWgOb1XKFIJl7WDU83oeILvwuJoG5Yg=
X-Google-Smtp-Source: AFSGD/VLVMgJZ/cbcq5C918ggZoD+u17xWwq6OXTytgCOrm8nOiTF6CaUqfuNqvdBx78BfD1ZINt2amTtB7U1rM3ZB4=
X-Received: by 2002:a1f:298e:: with SMTP id p136mr3855061vkp.40.1545062676802;
 Mon, 17 Dec 2018 08:04:36 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-2-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:04:22 +0100
Message-ID: <CAMuHMdV-2FLKt=CbnSiHDWokWw8TXLLGOxBUg3y0LOupuVpgeg@mail.gmail.com>
Subject: Re: [PATCH 1/9] arm64: dts: renesas: Initial device tree for r8a774c0
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:10 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Basic support for the RZ/G2E SoC (a.k.a. r8a774c0).
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
