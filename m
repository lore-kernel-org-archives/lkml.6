Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeDSRZo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbeDSRZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:25:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA0B217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Sean Wang <sean.wang@mediatek.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1524109802.12959.10.camel@mtkswgap22>
Cc: airlied@linux.ie, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <4b5d243d33433f83874359794b796d4228574714.1524044917.git.sean.wang@mediatek.com>
 <152410791532.46528.10083030894445315558@swboyd.mtv.corp.google.com>
 <1524109802.12959.10.camel@mtkswgap22>
Message-ID: <152415874117.46528.7501317526173019067@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: mediatek: add g3dsys bindings
Date: Thu, 19 Apr 2018 10:25:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Wang (2018-04-18 20:50:02)
> On Wed, 2018-04-18 at 20:18 -0700, Stephen Boyd wrote:
> > Quoting sean.wang@mediatek.com (2018-04-18 03:24:54)
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > Add bindings to g3dsys providing necessary clock and reset control to
> > > Mali-450.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > ---
> > >  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++
> > 
> > Why isn't this under bindings/clock/ ?
> > 
> 
> Tons of bindings for clock controller have been present at
> binding/arm/mediatek. g3dsys just have a follow-up to them.
> 
> It's worth another patch moving them all from bindings/arm/mediatek/ to
> bindings/clock/mediatek.
> 
> what's your opinion for either doing it prior to g3dsys binding being
> added or doing it in the future ?
> 

Doing it at a later time is fine. Just wondering why they're all getting
dumped into the arm/ directory.
