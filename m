Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeBVJ0u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:26:50 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36232 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbeBVJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:26:45 -0500
X-Google-Smtp-Source: AH8x226lfeq7bg2XPBHWeZsJ6Zi/N2zyRbtLUBdzpAasrFOK0B8fnqSVJlu0L2p+4+8yeJaW70bfgOjoFCAzh3mko74=
MIME-Version: 1.0
In-Reply-To: <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com> <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2018 10:26:44 +0100
X-Google-Sender-Auth: v8oTiXGljeXZzsL7BEzMLF-Ll4w
Message-ID: <CAMuHMdVy9=e5eZZTdV6E=apvHxL3n5Qqob2JE+FsON3RG-JWWg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] i2c: demux: Use changeset helpers for clarity
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Feb 22, 2018 at 1:05 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>
> The changeset helpers are easier to use, use them instead of
> using the static property.
>
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> ["okay" -> "ok"]

Why? ePAPR says "okay", "disabled", "fail", or "fail-sss".

Sorry for missing this in the previous round.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
