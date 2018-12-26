Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F00C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE72218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLZBt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:49:28 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62301 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbeLZBt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:49:27 -0500
X-UUID: 3429959f33894c7ca4ab7be24e13a629-20181226
X-UUID: 3429959f33894c7ca4ab7be24e13a629-20181226
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1886481757; Wed, 26 Dec 2018 09:49:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Dec 2018 09:49:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Dec 2018 09:49:13 +0800
Message-ID: <1545788953.14496.6.camel@mtksdaap41>
Subject: Re: [PATCH 01/18] drm/mediatek: update dt-bindings for mt8183
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 26 Dec 2018 09:49:13 +0800
In-Reply-To: <1545638931-24938-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

I would like you to add 'dt-bindings' in title.

On Mon, 2018-12-24 at 16:08 +0800, Yongqiang Niu wrote:
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 8469de5..1c66f39 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -28,9 +28,12 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>  Required properties (all function blocks):
>  - compatible: "mediatek,<chip>-disp-<function>", one of
>  	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
> +	"mediatek,<chip>-disp-ovl-2l"   - overlay (2 layers, blending, csc)

Other '-' is aliened, so do this one.

>  	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
>  	"mediatek,<chip>-disp-wdma"  - write DMA
> +	"mediatek,<chip>-disp-ccorr" - color correction
>  	"mediatek,<chip>-disp-color" - color processor
> +	"mediatek,<chip>-disp-dither" - dither

Ditto.

>  	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
>  	"mediatek,<chip>-disp-gamma" - gamma correction
>  	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
> @@ -40,7 +43,7 @@ Required properties (all function blocks):
>  	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
>  	"mediatek,<chip>-disp-mutex" - display mutex
>  	"mediatek,<chip>-disp-od"    - overdrive
> -  the supported chips are mt2701, mt2712 and mt8173.
> +  the supported chips are mt2701, mt2712, mt8173 and mt8183.
>  - reg: Physical base address and length of the function block register space
>  - interrupts: The interrupt signal from the function block (required, except for
>    merge and split function blocks).
> @@ -71,6 +74,12 @@ mmsys: clock-controller@14000000 {
>  	#clock-cells = <1>;
>  };
>  
> +display_components: dispsys@14000000 {
> +		compatible = "mediatek,mt8183-display";

"mediatek,mt8183-display" is undefined. I think this should be
"mediatek,mt8183-mmsys" and you have met the same problem in [1]. You
may depend on that series to develop your patches.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-November/015860.html

Regards,
CK

> +		reg = <0 0x14000000 0 0x1000>;
> +		power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +};
> +
>  ovl0: ovl@1400c000 {
>  	compatible = "mediatek,mt8173-disp-ovl";
>  	reg = <0 0x1400c000 0 0x1000>;


