Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751593AbeBYIo1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 03:44:27 -0500
Received: from hermes.aosc.io ([199.195.250.187]:50199 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeBYIoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 03:44:25 -0500
Date: Sun, 25 Feb 2018 16:43:52 +0800
In-Reply-To: <CAGRGNgWgkfax2TUSjK4397i678gXTTLh80r2HWwTB6u0GM0Cuw@mail.gmail.com>
References: <20180224214545.3740-1-jernej.skrabec@siol.net> <20180224214545.3740-15-jernej.skrabec@siol.net> <CAGRGNgWgkfax2TUSjK4397i678gXTTLh80r2HWwTB6u0GM0Cuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI output on H3 boards
To: linux-arm-kernel@lists.infradead.org,
        Julian Calaby <julian.calaby@gmail.com>, jernej.skrabec@siol.net
CC: Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, sboyd@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <E26547A5-F219-4310-B0E6-49AC3A700566@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月25日 GMT+08:00 下午4:11:34, Julian Calaby <julian.calaby@gmail.com> 写到:
>Hi Jernej,
>
>On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
><jernej.skrabec@siol.net> wrote:
>> Enable HDMI output on all boards which have HDMI connector.
>>
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> ---
>>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
>++++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 25
>++++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
>++++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           | 25
>++++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 25
>++++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
>++++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 24
>+++++++++++++++++++++
>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 25
>++++++++++++++++++++++
>>  8 files changed, 199 insertions(+)
>
>As I understand it, the H2+ is just a slightly trimmed down H3. In
>terms of HDMI support, the difference is that the H2+ can't output 4k.

H2+ can OUTPUT 4K. The BSP restricts it to DECODE 4K. (And mainline won't have such restriction)

>If this code is compatible with the H2+, could you please add the
>necessary bits and pieces to the h2-plus DTSs too?
>
>Thanks,
