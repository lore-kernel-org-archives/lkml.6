Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeCEITB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 03:19:01 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44078 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932923AbeCEIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 03:18:58 -0500
X-Google-Smtp-Source: AG47ELvDSJKbrvNmukzIv8yGFEN2MYL347B1vVRI6tw6CncPEO2Rz0oftcx4ROhY1qqP+n/1plGJLlNDfm3lWzVrbRA=
MIME-Version: 1.0
In-Reply-To: <1520227965-4471-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1520227965-4471-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Mar 2018 09:18:57 +0100
X-Google-Sender-Auth: AN_VV6dzuC_fjOTcC7mtUaWgCF4
Message-ID: <CAMuHMdVyEXs940YzGyVuMXYomxUbng_8DSKabODpsBsBDgcs_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: rcar-gen3-usb2: Add support for r8a77965
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 6:32 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds support for r8a77965 (R-Car M3-N). This SoC has
> dedicated pins.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
