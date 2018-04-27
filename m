Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeD0ULS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:11:18 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34644 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758703AbeD0ULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:11:16 -0400
X-Google-Smtp-Source: AB8JxZq/S9RqW/r2sXz4YF3VDb2Isb8PS8UJT7SVeVI0U2kJH65CTtaKaeBRjVTT4Ye0yjflmsuKSQ==
Date: Fri, 27 Apr 2018 15:11:14 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        mark.rutland@arm.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: clock: mediatek: add entry for
 Mali-450 node to refer
Message-ID: <20180427201114.wmr2sz2m2took5xz@rob-hp-laptop>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 04:14:44PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a required clock referenced by Mali-450 on MT7623
> or MT2701 SoC.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  include/dt-bindings/clock/mt2701-clk.h | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
