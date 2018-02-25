Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbeBYJG5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 04:06:57 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36956 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeBYJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 04:06:53 -0500
X-Google-Smtp-Source: AH8x224gkmUMZ8YuakI+4d2gD2xiCpjKSM2xQK0wwLnVtsyPrPKwLDdIs8fkofXMPMzhsh9cAgsDcmWgysnbhoRxE/o=
MIME-Version: 1.0
In-Reply-To: <E26547A5-F219-4310-B0E6-49AC3A700566@aosc.io>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-15-jernej.skrabec@siol.net> <CAGRGNgWgkfax2TUSjK4397i678gXTTLh80r2HWwTB6u0GM0Cuw@mail.gmail.com>
 <E26547A5-F219-4310-B0E6-49AC3A700566@aosc.io>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 25 Feb 2018 20:06:32 +1100
Message-ID: <CAGRGNgXosix84T3i4y0_ct4eiDSq9ef-dfo3soU54Or42bjxbQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
To: Icenowy Zheng <icenowy@aosc.io>
Cc: "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        jernej.skrabec@siol.net, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, sboyd@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1P971o7030251

Hi Icenowy,

On Sun, Feb 25, 2018 at 7:43 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 于 2018年2月25日 GMT+08:00 下午4:11:34, Julian Calaby <julian.calaby@gmail.com> 写到:
>>Hi Jernej,
>>
>>On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
>><jernej.skrabec@siol.net> wrote:
>>> Enable HDMI output on all boards which have HDMI connector.
>>>
>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>> ---
>>>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 24
>>+++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 25
>>++++++++++++++++++++++
>>>  8 files changed, 199 insertions(+)
>>
>>As I understand it, the H2+ is just a slightly trimmed down H3. In
>>terms of HDMI support, the difference is that the H2+ can't output 4k.
>
> H2+ can OUTPUT 4K. The BSP restricts it to DECODE 4K. (And mainline won't have such restriction)

Interesting!

I'm getting my data from here: http://linux-sunxi.org/H3#Variants

So essentially what you're saying is that the H2+ is just a H3 with
less pins? (I'm assuming the "lack of gigabit mac" is effectively it
not having the required pins, i.e. GPIO bank D)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
