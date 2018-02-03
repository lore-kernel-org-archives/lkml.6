Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBCHXn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:23:43 -0500
Received: from hermes.aosc.io ([199.195.250.187]:44893 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeBCHXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:23:36 -0500
Date: Sat, 03 Feb 2018 15:23:28 +0800
In-Reply-To: <20180202221301.judzaafcu67h4c2v@flea.lan>
References: <20180202180456.60378-1-icenowy@aosc.io> <20180202180456.60378-2-icenowy@aosc.io> <20180202221301.judzaafcu67h4c2v@flea.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and add V3 one
To: Maxime Ripard <maxime.ripard@bootlin.com>
CC: Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <73B89FC1-9A58-4B08-80C0-971E1254CFD9@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月3日 GMT+08:00 上午6:13:01, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Sat, Feb 03, 2018 at 02:04:54AM +0800, Icenowy Zheng wrote:
>> The V3s is just a differently packaged version of the V3 chip, which
>has
>> a MAC with the same capability with H3. The V3s just doesn't wire out
>> the external MII/RMII/RGMII bus. (V3 wired out it).
>> 
>> Drop the compatible string of V3s in the dwmac-sun8i driver, and add
>a
>> V3 compatible string, which has all capabilities.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
>This breaks the DT ABI, so NAK.

I have asked this at IRC.

The V3s compatible string is never used in any mainline
kernel, even not in any RC version.

>
>Maxime
