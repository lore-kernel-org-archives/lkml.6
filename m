Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB0C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6996F242A8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996F242A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeFVN1m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:27:42 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44123 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeFVN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:27:39 -0400
Received: by mail-ua0-f193.google.com with SMTP id f30-v6so4268923uab.11;
        Fri, 22 Jun 2018 06:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zz8nxdFFmrrYAZbejOkgba99tJBDc4c7h2z/8c70GS0=;
        b=D2lKuBxtNedurvpIZ4hOF7trC94ZjtoDomcG4o1ND8WBVBtlaICidwxVNJtIR1gLkv
         R95J9zLhRhFpJZq31m4GWyaq4tBz/jWkJL0xo+1FyiL4SbQDyitCEo9x++G66VDnU5dV
         GXZeYLC1mWL1dG7marTP33LSFsip32+AEG8WEriF52b960Re83spgBYA0JeUo+XwBzoT
         nLkL4OvBfgB/SWKQ97Djt+UXAZuwrI2c5Je3TjKzRJ2+4yEfDLWiaLJG4ArvGpJnLfvD
         RrcuEUcAFawkkHF1QN4KPiR1RglzBxkJD/q9kvx61HXMrN8xpyRtRSwi38PNPUIc5Zff
         I9oQ==
X-Gm-Message-State: APt69E3tydoOEkr3Q2NRjvAtjxFHOxOXQtDQGqD/ocWRn9KfifHoWZxu
        +ECPPAx2HbjZ/4erFN49/JwD4BozlZFKbxIlYVA=
X-Google-Smtp-Source: ADUXVKLA1LZNT8P/pUN+9JoBa1ZG6vIVbOt0SB351vJzWBa58QR26FxYkBLIOdolmfFO4VH7pBdKjAkqtBottk/c+Cs=
X-Received: by 2002:ab0:25d6:: with SMTP id y22-v6mr303373uan.33.1529674058425;
 Fri, 22 Jun 2018 06:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-3-git-send-email-michel.pollet@bp.renesas.com> <20180620154344.GA32205@rob-hp-laptop>
In-Reply-To: <20180620154344.GA32205@rob-hp-laptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 15:27:27 +0200
Message-ID: <CAMuHMdW5bfhPeHxdCeJEJrkWAXvxU4wSVvDErF2DhCQfvF1rUw@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 5:43 PM Rob Herring <robh@kernel.org> wrote:
> On Thu, Jun 14, 2018 at 11:56:31AM +0100, Michel Pollet wrote:
> > The Renesas R9A06G032 SYSCTRL node description.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  .../bindings/clock/renesas,r9a06g032-sysctrl.txt   | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
>
> One nit, otherwise:
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt

> > +Examples
> > +--------
> > +
> > +  - SYSCTRL node:
> > +
> > +     sysctrl: system-controller@4000c000 {
> > +             compatible = "renesas,r9a06g032-sysctrl";
> > +             reg = <0x4000c000 0x1000>;
> > +             status = "okay";
>
> Don't show status in examples.

Thanks, queuing in clk-renesas-for-v4.19 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
