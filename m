Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeDSDuR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:50:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25233 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752077AbeDSDuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:50:15 -0400
X-UUID: db59ae21cdfb428a89bfabe8b51ad79b-20180419
Message-ID: <1524109802.12959.10.camel@mtkswgap22>
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: mediatek: add g3dsys bindings
From: Sean Wang <sean.wang@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: <airlied@linux.ie>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Thu, 19 Apr 2018 11:50:02 +0800
In-Reply-To: <152410791532.46528.10083030894445315558@swboyd.mtv.corp.google.com>
References: <cover.1524044917.git.sean.wang@mediatek.com>
         <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
         <152410791532.46528.10083030894445315558@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-18 at 20:18 -0700, Stephen Boyd wrote:
> Quoting sean.wang@mediatek.com (2018-04-18 03:24:54)
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add bindings to g3dsys providing necessary clock and reset control to
> > Mali-450.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++
> 
> Why isn't this under bindings/clock/ ?
> 

Tons of bindings for clock controller have been present at
binding/arm/mediatek. g3dsys just have a follow-up to them.

It's worth another patch moving them all from bindings/arm/mediatek/ to
bindings/clock/mediatek.

what's your opinion for either doing it prior to g3dsys binding being
added or doing it in the future ?

> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
