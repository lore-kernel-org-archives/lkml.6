Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeBZQVr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:21:47 -0500
Received: from hermes.aosc.io ([199.195.250.187]:33711 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeBZQVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:21:45 -0500
Date: Tue, 27 Feb 2018 00:21:05 +0800
In-Reply-To: <2676311.2IEVhXnSIE@jernej-laptop>
References: <20180224214545.3740-1-jernej.skrabec@siol.net> <20180224214545.3740-15-jernej.skrabec@siol.net> <CAGRGNgWgkfax2TUSjK4397i678gXTTLh80r2HWwTB6u0GM0Cuw@mail.gmail.com> <2676311.2IEVhXnSIE@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI output on H3 boards
To: jernej.skrabec@siol.net,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Julian Calaby <julian.calaby@gmail.com>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <4AA78C45-E139-417E-BE89-FE0BFBC409B0@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月27日 GMT+08:00 上午12:16:44, "Jernej Škrabec" <jernej.skrabec@siol.net> 写到:
>Hi Julian,
>
>Dne nedelja, 25. februar 2018 ob 09:11:34 CET je Julian Calaby
>napisal(a):
>> Hi Jernej,
>> 
>> On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
><jernej.skrabec@siol.net> 
>wrote:
>> > Enable HDMI output on all boards which have HDMI connector.
>> > 
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > ---
>> > 
>> >  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
>> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-beelink-x2.dts  
>     
>> >   | 25 ++++++++++++++++++++++
>> >  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
>> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts   
>     
>> >   | 25 ++++++++++++++++++++++
>arch/arm/boot/dts/sun8i-h3-orangepi-2.dts  
>> >         | 25 ++++++++++++++++++++++
>> >  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
>> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>     
>> >   | 24 +++++++++++++++++++++
>arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts  
>> >        | 25 ++++++++++++++++++++++ 8 files changed, 199
>insertions(+)
>> 
>> As I understand it, the H2+ is just a slightly trimmed down H3. In
>> terms of HDMI support, the difference is that the H2+ can't output
>4k.
>> If this code is compatible with the H2+, could you please add the
>> necessary bits and pieces to the h2-plus DTSs too?
>
>There are only 3 H2+ boards in kernel and none of them has HDMI
>connector, so 

BPi M2 Zero has miniHDMI connector.

>there's nothing to do actually. But if such board is added to kernel,
>it would 
>be trivially add proper nodes, since all H2+ boards include H3 DTSI.
>
>Best regards,
>Jernej
