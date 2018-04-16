Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbeDPLJO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:09:14 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43339 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeDPLJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:09:12 -0400
X-Google-Smtp-Source: AIpwx4918RMbrdfRiIPx3EE19RUUVL0kVCgWk7pVeyLDIIIHrSt2srQ88oo2qHm8IO9lSBPc91UzuXgfFLhztXb4sAc=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-11-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-11-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Apr 2018 13:09:10 +0200
X-Google-Sender-Auth: Hc69O-qOAsPFyxntMj5KmhLj8CY
Message-ID: <CAMuHMdWS+6g=e-jzve74530zR-fw43oLeJaa+h7TWZ0nyjgMwg@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] dt-bindings: dmaengine: rcar-dmac: document
 R8A77965 support
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add documentation for r8a77965 compatible string to rcar-dmac device
> tree bindings documentation.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Can you please resend to the DMA engine maintainer?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
