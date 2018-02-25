Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeBYIL6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 03:11:58 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39464 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeBYIL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 03:11:56 -0500
X-Google-Smtp-Source: AG47ELuhuSE1JwE0s3sjs34gEzxEdkxsfEtuPXDv0tEHWsBU1K6Susnu/6NpGiktSVg5sEuRfbeS/zLvB/UsUNtBWcs=
MIME-Version: 1.0
In-Reply-To: <20180224214545.3740-15-jernej.skrabec@siol.net>
References: <20180224214545.3740-1-jernej.skrabec@siol.net> <20180224214545.3740-15-jernej.skrabec@siol.net>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 25 Feb 2018 19:11:34 +1100
Message-ID: <CAGRGNgWgkfax2TUSjK4397i678gXTTLh80r2HWwTB6u0GM0Cuw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
To: jernej.skrabec@siol.net
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Enable HDMI output on all boards which have HDMI connector.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 25 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           | 25 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 25 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25 ++++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 24 +++++++++++++++++++++
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 25 ++++++++++++++++++++++
>  8 files changed, 199 insertions(+)

As I understand it, the H2+ is just a slightly trimmed down H3. In
terms of HDMI support, the difference is that the H2+ can't output 4k.
If this code is compatible with the H2+, could you please add the
necessary bits and pieces to the h2-plus DTSs too?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
