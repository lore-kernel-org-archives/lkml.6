Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbeBCHWJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:22:09 -0500
Received: from hermes.aosc.io ([199.195.250.187]:44812 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeBCHWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:22:03 -0500
Date: Sat, 03 Feb 2018 15:21:42 +0800
In-Reply-To: <CAGRGNgXy5ZUdCj34jG5kJ8yLZLbcZie5tkvYP08sFpMmAjwPNg@mail.gmail.com>
References: <20180202180456.60378-1-icenowy@aosc.io> <20180202180456.60378-2-icenowy@aosc.io> <CAGRGNgXy5ZUdCj34jG5kJ8yLZLbcZie5tkvYP08sFpMmAjwPNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and add V3 one
To: linux-arm-kernel@lists.infradead.org,
        Julian Calaby <julian.calaby@gmail.com>
CC: devicetree <devicetree@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <10F6ADAB-1E1E-4C14-8809-9471ABABBB8A@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月3日 GMT+08:00 下午2:00:33, Julian Calaby <julian.calaby@gmail.com> 写到:
>Hi Icenowy,
>
>On Sat, Feb 3, 2018 at 5:04 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> The V3s is just a differently packaged version of the V3 chip, which
>has
>> a MAC with the same capability with H3. The V3s just doesn't wire out
>> the external MII/RMII/RGMII bus. (V3 wired out it).
>>
>> Drop the compatible string of V3s in the dwmac-sun8i driver, and add
>a
>> V3 compatible string, which has all capabilities.
>
>Aren't compatible strings technically API, so don't we need to support
>those that are out in the wild "forever"?
>
>Therefore shouldn't we leave the v3s variant around for compatibility
>with existing device trees?

You can run grep at arch/arm/boot/dts, this compatible
string is not used at all.

>
>Thanks,
