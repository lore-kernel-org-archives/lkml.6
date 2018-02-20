Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeBTPpv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:45:51 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33317 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeBTPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:45:49 -0500
X-Google-Smtp-Source: AG47ELuV2bnVWkeyjHqgJCPgb75KnjxKKOwvVMmV0o5T/i7/DCtfZRnNe1yXmyTypya7P4xMcxy9XBtzCjSpjUmKIcM=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-9-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-9-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 16:45:48 +0100
X-Google-Sender-Auth: 4dJqoS1sGXFeAbl5HniZBBX4a-A
Message-ID: <CAMuHMdVR6qCkBMYvnN5eqjiCgvtD1zW2gW0N=ZpAosYpp+Tj_g@mail.gmail.com>
Subject: Re: [PATCH v2 08/19] ARM64: dts: Add Renesas R8A77965 SoC support
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
> Basic support for the Gen 3 R-Car M3-N SoC.
>
> Based on original work from:
> Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Magnus Damm <damm+renesas@opensource.se>
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
