Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeBTSgo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:36:44 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33348 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBTSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:36:42 -0500
X-Google-Smtp-Source: AH8x225BVJUZzUEb4ymf8dSHqNWBbuvKDFPLNruXlj+cbHPkpTXGP7p1TduA51jRyxSU0SjwEXVcm4MsM8xLnRYvjRs=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-19-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-19-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 19:36:40 +0100
X-Google-Sender-Auth: Mq7fCqh0XA6qYJWqz-eiG-to-x8
Message-ID: <CAMuHMdWi9Gh=3vz=tgXzS+KDczwiVQUcPVXXf6TDPukw93C62g@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] pinctrl: sh-pfc: r8a77965: Add EtherAVB groups/functions
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
> Add EtherAVB groups and functions definitions for R-Car M3-N.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queueing in sh-pfc-for-v4.17.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
