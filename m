Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF69C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60682086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60682086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeIJWRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:17:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45136 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeIJWRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:17:43 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fzPtK-0004bM-L9; Mon, 10 Sep 2018 19:22:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: arm: rockchip: Add binding for Rock960 board
Date:   Mon, 10 Sep 2018 19:22:26 +0200
Message-ID: <1606406.b630GQBvc1@phil>
In-Reply-To: <20180910151356.25946-3-manivannan.sadhasivam@linaro.org>
References: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org> <20180910151356.25946-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. September 2018, 17:13:54 CEST schrieb Manivannan Sadhasivam:
> Add devicetree binding for Rock960 board from Vamrs Limited.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index acfd3c773dd0..aaad9e2ff9a3 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "vamrs,ficus", "rockchip,rk3399";
>  
> +- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> +    Required root node properties:
> +      - compatible = "vamrs,rk3399-rock960", "rockchip,rk3399";

hmm, are there more boards labeled rock960 from Vamrs?
Because I'm trying to determine what makes "vamrs,rock960" unsuitable.


Heiko


