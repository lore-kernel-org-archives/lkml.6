Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEBAC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904EB222EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405022AbfBOJjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:39:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60368 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404858AbfBOJjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:39:12 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1guZxb-0000J0-9F; Fri, 15 Feb 2019 10:39:07 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        tom@vamrs.com, dev@vamrs.com, linux-kernel@vger.kernel.org,
        mani@kernel.org, pbrobinson@gmail.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add on-board WiFi/BT support for Rock960 boards
Date:   Fri, 15 Feb 2019 10:39:06 +0100
Message-ID: <1797728.tnt5FPHN1h@diego>
In-Reply-To: <20190215045648.26380-1-manivannan.sadhasivam@linaro.org>
References: <20190215045648.26380-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Februar 2019, 05:56:48 CET schrieb Manivannan Sadhasivam:
> Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
> on AP6356S and Ficus based on AP6354 wireless modules.
> 
> Firmwares for the respective boards are available here:
> 
> http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
> http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


> +&sdio0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <50000000>;
> +	bus-width = <4>;
> +	cap-sdio-irq;
> +	cap-sd-highspeed;
> +	no-emmc;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	num-slots = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +	sd-uhs-sdr104;

I've dropped the no-emmc and num-slots properties and applied
the result for 5.1

Thanks
Heiko


