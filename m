Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeCVMtT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:49:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45795 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeCVMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:49:16 -0400
X-Google-Smtp-Source: AG47ELs6bljaezG7fm9aHzmGmH8Fo/11j+1H/BE566m5fi+x5zUixELVescoq7xJykws7BxAuiRIboJUyYgm5A+gg2E=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-6-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-6-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:49:15 +0100
X-Google-Sender-Auth: 1YFVAZrFdyD3WVQe8Rrf4_NrGoY
Message-ID: <CAMuHMdXL+UcjvbG9R=es4rLnOG7RO5H3CM1E0doToaiTR95Vmw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] arm: rzn1: Add the RZ/N1 arch to the shmobile Kconfig
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
> Add the RZ/N1 Family (Part #R9A06G0xx) ARCH config to the rest of
> the Renesas SoC collection.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Subject should be "arm: shmobile: ..."

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
