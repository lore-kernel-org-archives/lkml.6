Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeCVMv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:51:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39243 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeCVMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:51:24 -0400
X-Google-Smtp-Source: AG47ELvxV25jWVvVHJR4hXPPE2dQc66cyotK8EHO/rc1NkNwu3aJHHE9x4HJWpdESIEEYRLApPvZiG+2lCQwJKH+C3U=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-9-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-9-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:51:22 +0100
X-Google-Sender-Auth: CY0Vel2CL69sRSgcGMuluIDRotI
Message-ID: <CAMuHMdUjtZnZpVE11-5ECsGs-zuNzwaPR_n+KL3_5tWtq2i+8A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] DT: arm: Add the RZN1D-DB Board to Renesas
 Makefile target
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the newly added board to the Renesas built target
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
