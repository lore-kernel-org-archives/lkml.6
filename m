Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753936AbeBSUb4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:31:56 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37944 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753877AbeBSUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:31:53 -0500
X-Google-Smtp-Source: AH8x227/2S+uI+hx6sWzVoUVPJQgNkLQ3P+a01lPQ95q/mQNjhYi28AOKvukAEWry8Gt6omoKo/NVQ==
Date: Mon, 19 Feb 2018 14:31:52 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add MediaTek High-Speed
 DMA controller bindings
Message-ID: <20180219203152.xujjsolbe24ec66q@rob-hp-laptop>
References: <cover.1518857746.git.sean.wang@mediatek.com>
 <94e4a39e05a30f2ca3fafb61d19777f41fa49645.1518857747.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e4a39e05a30f2ca3fafb61d19777f41fa49645.1518857747.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 03:08:29AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Document the devicetree bindings for MediaTek High-Speed DMA controller
> which could be found on MT7623 SoC or other similar Mediatek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk-hsdma.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

Reviewed-by: Rob Herring <robh@kernel.org>
