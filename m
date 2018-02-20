Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBTSqv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:46:51 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36361 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeBTSqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:46:49 -0500
X-Google-Smtp-Source: AH8x226kDAe2A2JiGmbaBUgEFOqF9EouVqTSS34L6VW8kBYccfYFwturcUwAypfgiN/7FhQa+bRjLtnn3s30g4IssGg=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 19:46:47 +0100
X-Google-Sender-Auth: SiPYfrPfzezxVP3MFkM8FtFIm0I
Message-ID: <CAMuHMdVL1-PDa7V4AnB4mu0Qmqs19P_Te+wjxOGYKhanKpVnbw@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] clk: renesas: cpg-mssr: Add support for R-Car M3-N
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

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Initial support for R-Car M3-N (r8a77965), including core and module
> clocks.
>
> Based on Table 8.2d of "R-Car Series, 3rd Generation User's Manual:
> Hardware (Rev. 0.80, Oct 31, 2017)".
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued in clk-renesas-for-v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
