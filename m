Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030616AbeBNOIN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:08:13 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43399 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030290AbeBNOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:08:10 -0500
X-Google-Smtp-Source: AH8x224BXxZQ3HFYF3arqPzs9aaWWNYiJAvRaBVkoFZ6QQ4jCtcvldn3uOyPDwIs/jFtlJQzn/1xSDgSP6cOOAVhyes=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-8-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-8-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 15:08:09 +0100
X-Google-Sender-Auth: mXLzHZbRoOvAnVzjTBoZ9bfJ90M
Message-ID: <CAMuHMdWswgBrY5hOws0kx-WVShuh8Gv7+oDDA=qa-kpJi5B_cA@mail.gmail.com>
Subject: Re: [PATCH 07/15] ARM64: dts: r8a77965: Add dmac device nods
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add dmac[0-2] device nodes for R-Car M3-N (r8a77965) SoC.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
