Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBCGBE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 01:01:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54843 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeBCGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 01:00:54 -0500
X-Google-Smtp-Source: AH8x225lC8YkoNNeJ8qj4qvFIRWLQ472R4YrJYQAS7K8q5vPFwrS8Ep0ORzJNJ96HbC5VI/UWFr+CJaVF4LqBngCFXo=
MIME-Version: 1.0
In-Reply-To: <20180202180456.60378-2-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io> <20180202180456.60378-2-icenowy@aosc.io>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 3 Feb 2018 17:00:33 +1100
Message-ID: <CAGRGNgXy5ZUdCj34jG5kJ8yLZLbcZie5tkvYP08sFpMmAjwPNg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s
 compatible and add V3 one
To: icenowy@aosc.io
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Sat, Feb 3, 2018 at 5:04 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The V3s is just a differently packaged version of the V3 chip, which has
> a MAC with the same capability with H3. The V3s just doesn't wire out
> the external MII/RMII/RGMII bus. (V3 wired out it).
>
> Drop the compatible string of V3s in the dwmac-sun8i driver, and add a
> V3 compatible string, which has all capabilities.

Aren't compatible strings technically API, so don't we need to support
those that are out in the wild "forever"?

Therefore shouldn't we leave the v3s variant around for compatibility
with existing device trees?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
