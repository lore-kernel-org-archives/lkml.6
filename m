Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeDXOkT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:40:19 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38219 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeDXOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:40:11 -0400
X-Google-Smtp-Source: AIpwx4/DGK8HUrOwCuYpMlSVI75KQih1UBw7o107pzjd+s/S4T7S/7+wjDCcrqtux/Vdl6c9rPYgbQ==
Date: Tue, 24 Apr 2018 09:40:09 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] clk: mediatek: add g3dsys support for MT2701 and
 MT7623
Message-ID: <20180424144009.b66sxo3okjvsr4yc@rob-hp-laptop>
References: <cover.1524044917.git.sean.wang@mediatek.com>
 <96dc02879c10388c2efa08b1cf33b77f938908ee.1524044917.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96dc02879c10388c2efa08b1cf33b77f938908ee.1524044917.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 06:24:55PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add clock driver support for g3dsys on MT2701 and MT7623, which is
> providing essential clock gate and reset controller to Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig              |  6 ++
>  drivers/clk/mediatek/Makefile             |  1 +
>  drivers/clk/mediatek/clk-mt2701-g3d.c     | 95 +++++++++++++++++++++++++++++++

>  include/dt-bindings/clock/mt2701-clk.h    |  4 ++
>  include/dt-bindings/reset/mt2701-resets.h |  3 +

These below in the binding patch.

>  5 files changed, 109 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt2701-g3d.c
