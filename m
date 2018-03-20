Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCTGH7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:07:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50970 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751269AbeCTGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:07:56 -0400
X-UUID: b6b4201d53734789b1c996bce842dda7-20180320
Message-ID: <1521526068.13313.8.camel@mtksdaap41>
Subject: Re: [PATCH v2 0/5] update Mediatek MT2712 clock and scpsys support
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>
CC: Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date: Tue, 20 Mar 2018 14:07:48 +0800
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-12 at 15:03 +0800, Weiyi Lu wrote:
> This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
> Basically, all changes are for the ECO design change of MT2712.
> 
> changes since v1:
> - Avoid renumbering clocks. Append new clocks at the bottom of each own subsystem.
> 
Hi Matthias & Stephen,

Sorry to bother. Just saw patch 1/2 are already pushed to v4.16-next-soc
and patch 3/5 are applied onto clk-next. What about the patch 4(arm64:
dts: add clock device nodes of MT2712). Does there any problem remain or
it cause some problems? Many thanks.
> Weiyi Lu (5):
>   dt-bindings: soc: update MT2712 power dt-bindings
>   soc: mediatek: update power domain data of MT2712
>   dt-bindings: clock: add clocks for MT2712
>   arm64: dts: add clock device nodes of MT2712
>   clk: mediatek: update clock driver of MT2712
> 
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 +++++++++++++
>  drivers/clk/mediatek/clk-mt2712.c         | 69 ++++++++++++++++++++++++-------
>  drivers/soc/mediatek/mtk-scpsys.c         | 42 ++++++++++++++++++-
>  include/dt-bindings/clock/mt2712-clk.h    | 12 +++++-
>  include/dt-bindings/power/mt2712-power.h  |  3 ++
>  5 files changed, 136 insertions(+), 18 deletions(-)
> 
