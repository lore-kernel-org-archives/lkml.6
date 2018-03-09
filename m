Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCIILA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:11:00 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:42881 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeCIIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:10:58 -0500
X-Google-Smtp-Source: AG47ELv8wliBEmKG7fPPsljhomeInQumTYvdUjWIhLBQ6Bj1ykQQ/DHTdKo+SWX05HMf650F30vGr1i6KQsgGLPSREw=
MIME-Version: 1.0
In-Reply-To: <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org> <1520522643-11756-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Mar 2018 09:10:55 +0100
X-Google-Sender-Auth: oSKTccSzg2iarOPLzdxcCW57Wso
Message-ID: <CAMuHMdVQqp7YcoQ6eN5pSznZB4zn7ztv1WFfkcQOzP_3DhG_Vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: Document THC63LVD1024
 LVDS decoder
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Thu, Mar 8, 2018 at 4:24 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Document Thine THC63LVD1024 LVDS decoder.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
> @@ -0,0 +1,59 @@
> +THine Electronics THC63LVD1024 LVDS receiver

Thine

> +--------------------------------------------
> +
> +The THC63LVD1024 is an LVDS receiver designed to convert multiple LVDS streams
> +to digital CMOS/TTL parallel data.
> +
> +Required properties:
> +- compatible: Shall be one of the following:
> +  "thine,thc63lvd1024",
> +  "lvds-decoder"

What's the purpose of the second compatible value?
When should it be used?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
