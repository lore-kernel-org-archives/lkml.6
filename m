Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeBWJXr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:23:47 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33357 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBWJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:23:45 -0500
X-Google-Smtp-Source: AG47ELvaxXsdhNfIe12dKlhhLE4PYYSqnltAVQ7pvxhATJKgq9md48wMwAa3pe2haxar5Bn9EWGb3ZQWZrUSHurCSro=
MIME-Version: 1.0
In-Reply-To: <1519326370-15805-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org> <1519326370-15805-4-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 10:23:43 +0100
X-Google-Sender-Auth: 6yeM_F3iKkK_4OUlc_nOib7bQ48
Message-ID: <CAMuHMdVikGW4ZHbidVeSeBSPSDDk+1gcop_5TFsHakx9F_g_Kg@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: renesas: r8a77965: Remove stale reg property
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Remove "reg" property from cache-controller-0 device node as it does not
> have any unit address.
>
> This silences the following DTC compiler warning:
> Warning (unit_address_vs_reg): Node /cpus/cache-controller-0 has a reg
> or ranges property, but no unit name
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
