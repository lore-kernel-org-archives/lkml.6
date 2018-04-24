Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeDXPnd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:43:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55216 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750868AbeDXPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:43:29 -0400
X-UUID: 8c3025185e4843fd91c0f697ab3acd20-20180424
Message-ID: <1524584602.12322.16.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/4] clk: mediatek: add g3dsys support for MT2701 and
 MT7623
From: Sean Wang <sean.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>
CC: <mturquette@baylibre.com>, <sboyd@kernel.org>, <airlied@linux.ie>,
        <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Tue, 24 Apr 2018 23:43:22 +0800
In-Reply-To: <20180424144009.b66sxo3okjvsr4yc@rob-hp-laptop>
References: <cover.1524044917.git.sean.wang@mediatek.com>
         <96dc02879c10388c2efa08b1cf33b77f938908ee.1524044917.git.sean.wang@mediatek.com>
         <20180424144009.b66sxo3okjvsr4yc@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 09:40 -0500, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 06:24:55PM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add clock driver support for g3dsys on MT2701 and MT7623, which is
> > providing essential clock gate and reset controller to Mali-450.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/clk/mediatek/Kconfig              |  6 ++
> >  drivers/clk/mediatek/Makefile             |  1 +
> >  drivers/clk/mediatek/clk-mt2701-g3d.c     | 95 +++++++++++++++++++++++++++++++
> 
> >  include/dt-bindings/clock/mt2701-clk.h    |  4 ++
> >  include/dt-bindings/reset/mt2701-resets.h |  3 +
> 
> These below in the binding patch.
> 

Thanks, I will split them out in the next version.

> >  5 files changed, 109 insertions(+)
> >  create mode 100644 drivers/clk/mediatek/clk-mt2701-g3d.c
