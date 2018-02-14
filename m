Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030678AbeBNOGY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:06:24 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42259 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030432AbeBNOGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:06:22 -0500
X-Google-Smtp-Source: AH8x227pyEAO7JJ8udtvfHKVdd5oO84c1BtT0pYpNRIisg1GHZKBhQzjO1G5ju2FdG5KGSBSU/LTWkeROmK/aKXs38o=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-14-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-14-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 15:06:21 +0100
X-Google-Sender-Auth: DZOYCSzcM4FW20SqS_vsCj-LHi4
Message-ID: <CAMuHMdXyVeo3FEmYrtDvvJT=VwaOb=kA6obTohjn9nkgJ1_eEA@mail.gmail.com>
Subject: Re: [PATCH 13/15] Documentation: devicetree: ravb: Add r8a77965
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

Subject prefix should be "dt-bindings: net: ravb:"

On Tue, Feb 13, 2018 at 10:46 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add documentation for r8a77965 compatible string to renesas ravb device
> tree bindings documentation.
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
