Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbeE2Gss (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:48:48 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34928 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeE2Gsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:48:46 -0400
X-Google-Smtp-Source: ADUXVKLfBVGNzE67smH4PxdQjRABcxedlrbzYiWaK9nwQSfL5O2pcJ/S+0FrJMngrvfgp29c1wQP8p8nJ46hP5trGTI=
MIME-Version: 1.0
In-Reply-To: <8736yb5jez.wl%kuninori.morimoto.gx@renesas.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
 <20180427165722.19445-11-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdW6HeWMwRDcn6PLnwzgxvYz-h=jx=1qvYEK9okwqY0itg@mail.gmail.com> <8736yb5jez.wl%kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 May 2018 08:48:43 +0200
X-Google-Sender-Auth: kcNBHqfAhSy1_bjbdSIMhka9di0
Message-ID: <CAMuHMdWPFOjT9qk0Z4+-nSTumjhN_Q6Ntwh3__CgBCobquX8Rg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] arm64: dts: r8a77965-salvator-x: Enable DU
 external clocks and HDMI
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Simon Horman <horms@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Will Deacon <will.deacon@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Tue, May 29, 2018 at 3:44 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > +&hdmi0_con {
>> > +       remote-endpoint = <&rcar_dw_hdmi0_out>;
>> > +};
>>
>> I think the hdmi0 and hdmi0_con parts can be moved to salvator-common.dtsi.
>> Can we do that now (with stubs?), or does this have to wait until r8a77965 has
>> received HDMI sound support?
>
> HDMI sound doesn't use hdmi0_con.
> You can do it now, thanks

Thanks, so hdmi0_con can be moved now.

But HDMI sound does use hdmi0/ports/port@2. right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
