Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeBTPoN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:44:13 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44343 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeBTPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:44:10 -0500
X-Google-Smtp-Source: AH8x226FofK8ffjjDoONuQo3uRLBhXoQYgDUUj/usz0H4U8vkCJN6Sj6EazoaRZvvoj9ZWpuOOW/dTNeaenVV0wgxjs=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-5-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-5-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 16:44:09 +0100
X-Google-Sender-Auth: vsOLU21oA12YWb80TbmaDrEHZZE
Message-ID: <CAMuHMdWJXwnNd-f9mnnWeFtBC97rO5RFc4JwEQCNhibsGVxCWw@mail.gmail.com>
Subject: Re: [PATCH v2 04/19] soc: renesas: rcar-sysc: Add R-Car M3-N support
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
> Add support for R-Car M3-N (R8A77965) power areas.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

We'll sort out the remaining issues later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
