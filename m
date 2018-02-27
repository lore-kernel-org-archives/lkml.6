Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeB0Kfe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:35:34 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46035 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeB0Kfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:35:32 -0500
X-Google-Smtp-Source: AH8x226WNXDrgovtbP7V7bc9pggQlw6QLweIDBM8LcmRQHcf24ZZLfJi+94DkI7S2WSNsikhVOLTsFcZ02BRkTWAHeI=
MIME-Version: 1.0
In-Reply-To: <20180227070735.ml3mc4nr4vpge57u@flea>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <2676311.2IEVhXnSIE@jernej-laptop> <4AA78C45-E139-417E-BE89-FE0BFBC409B0@aosc.io>
 <2342395.9m6rrqTry7@jernej-laptop> <CAGRGNgU8-uJuns7mAzS-gc81qvVAkS9JS2Tm13p2Qp7dMDCNkg@mail.gmail.com>
 <20180227070735.ml3mc4nr4vpge57u@flea>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 27 Feb 2018 21:35:09 +1100
Message-ID: <CAGRGNgU0_zxejYfTzk5qeNhp5saCtTLy4Ra+oG97anhJwL+qOA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: jernej.skrabec@siol.net, linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RAZd0t027027

Hi Maxime,

On Tue, Feb 27, 2018 at 6:07 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Feb 27, 2018 at 01:29:27PM +1100, Julian Calaby wrote:
>> Hi Jernej,
>>
>> On Tue, Feb 27, 2018 at 3:27 AM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>> > Hi,
>> >
>> > Dne ponedeljek, 26. februar 2018 ob 17:21:05 CET je Icenowy Zheng napisal(a):
>> >> 于 2018年2月27日 GMT+08:00 上午12:16:44, "Jernej Škrabec"
>> > <jernej.skrabec@siol.net> 写到:
>> >> >Hi Julian,
>> >> >
>> >> >Dne nedelja, 25. februar 2018 ob 09:11:34 CET je Julian Calaby
>> >> >
>> >> >napisal(a):
>> >> >> Hi Jernej,
>> >> >>
>> >> >> On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
>> >> >
>> >> ><jernej.skrabec@siol.net>
>> >> >
>> >> >wrote:
>> >> >> > Enable HDMI output on all boards which have HDMI connector.
>> >> >> >
>> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >> >> > ---
>> >> >> >
>> >> >> >  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
>> >> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
>> >> >> >
>> >> >> >   | 25 ++++++++++++++++++++++
>> >> >> >
>> >> >> >  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
>> >> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
>> >> >> >
>> >> >> >   | 25 ++++++++++++++++++++++
>> >> >
>> >> >arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
>> >> >
>> >> >> >         | 25 ++++++++++++++++++++++
>> >> >> >
>> >> >> >  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
>> >> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
>> >> >> >
>> >> >> >   | 24 +++++++++++++++++++++
>> >> >
>> >> >arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
>> >> >
>> >> >> >        | 25 ++++++++++++++++++++++ 8 files changed, 199
>> >> >
>> >> >insertions(+)
>> >> >
>> >> >> As I understand it, the H2+ is just a slightly trimmed down H3. In
>> >> >> terms of HDMI support, the difference is that the H2+ can't output
>> >> >
>> >> >4k.
>> >> >
>> >> >> If this code is compatible with the H2+, could you please add the
>> >> >> necessary bits and pieces to the h2-plus DTSs too?
>> >> >
>> >> >There are only 3 H2+ boards in kernel and none of them has HDMI
>> >> >connector, so
>> >>
>> >> BPi M2 Zero has miniHDMI connector.
>> >
>> > Ah, sorry, I missed that one. Since I don't have it (or any other board with
>> > H2+) I'm not really comfortable including such patch. If anyone will test it,
>> > I can include it in next revision.
>>
>> I have one of those (this is why I'm interested in this patchset) so
>> I'm willing to test, however I can't guarantee I'll get to it quickly.
>
> Then I guess the best way forward will be to keep the current patch as
> is, and you'll send a patch whenever you have the time to test it.

Fair enough, I'll do that then. =)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
