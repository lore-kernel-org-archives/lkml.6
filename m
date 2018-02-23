Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeBWJYJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:24:09 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41217 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeBWJYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:24:07 -0500
X-Google-Smtp-Source: AG47ELvQpjml4E442WMna4VokjXkrNCtG/8+mv7aC3KNJekRKI/P58vZD/X5tiqANS0gC+35V54pA0kG9jJQLwnIl5s=
MIME-Version: 1.0
In-Reply-To: <1519326370-15805-5-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org> <1519326370-15805-5-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 10:24:06 +0100
X-Google-Sender-Auth: DjkCrKeLUHCzUwdaYoRbbG5t1wg
Message-ID: <CAMuHMdXOe-h_7USVH_eRQp2pgOqB8hfBxCN+b9oZgEYr2KMsBw@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: renesas: r8a77965: Add #phy-cells property
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "#phy-cells" property to "usb-phy@e65ee000" device node.
>
> This silences the following DTC compiler warning:
> Warning (phys_property): Missing property '#phy-cells' in node
> /soc/usb-phy@e65ee000 or bad phandle (referred from
> /soc/usb@ee020000:phys[0])
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
