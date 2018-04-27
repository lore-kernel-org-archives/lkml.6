Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759249AbeD0UK6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:10:58 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35990 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759166AbeD0UKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:10:55 -0400
X-Google-Smtp-Source: AB8JxZq+jtaxRGk7oICT1lssPK9QxO+zXhxPrRUrs9JMubVlzj6xmel3TezfF3V8F/IUHVTYa9USlA==
Date: Fri, 27 Apr 2018 15:10:54 -0500
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: sboyd@codeaurora.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        mark.rutland@arm.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: mediatek: add g3dsys bindings
Message-ID: <20180427201054.fghwgp4l4yvfs6n6@rob-hp-laptop>
References: <cover.1524816502.git.sean.wang@mediatek.com>
 <665c38d5803573aa9a01471253f406301b1123a1.1524816502.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665c38d5803573aa9a01471253f406301b1123a1.1524816502.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 04:14:43PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add bindings to g3dsys providing necessary clock and reset control to
> Mali-450.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,g3dsys.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,g3dsys.txt

Reviewed-by: Rob Herring <robh@kernel.org>
