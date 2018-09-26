Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1BFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7952152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R7YR8HS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7952152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeIZXzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:55:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59082 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeIZXzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:55:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QHekbn072548;
        Wed, 26 Sep 2018 12:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537983646;
        bh=ngdbI7DX/iwzB1KPssdiIGs0sV2ISbHyiPurKkE1wh4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R7YR8HS45PW5n7X9wdIGqI7aB4JxCGpfPKDZ+QNvfbZdaegj8hfir5lS6Yj3udgva
         jwUlsXfWbNbq1s7dhB61OzYt/2Ocq07e06CFqlDZ6CXYD2sRC8GUFoFt+Dw3SJa9Vq
         MNFcAEINkOP5NB64mT+5oYUZV6haOxZGxQp9Yx5E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QHekGk007360;
        Wed, 26 Sep 2018 12:40:46 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 12:40:47 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 12:40:46 -0500
Received: from [128.247.58.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QHek3b007990;
        Wed, 26 Sep 2018 12:40:46 -0500
Subject: Re: [PATCH 1/2] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180910201241.24092-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <519a93e7-5177-8144-129a-7a4cbb1a108d@ti.com>
Date:   Wed, 26 Sep 2018 12:40:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910201241.24092-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bump

On 09/10/2018 03:12 PM, Dan Murphy wrote:
> DT binding documentation for TI TCAN4x5x driver.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> new file mode 100644
> index 000000000000..3eea2f2bb8a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -0,0 +1,33 @@
> +Texas Instruments TCAN4x5x CAN Controller
> +================================================
> +
> +This file provides device node information for the TCAN4x5x interface contains.
> +
> +Required properties:
> +	- compatible: "ti,tcan4x5x"
> +	- reg: 0
> +	- #address-cells : 1
> +	- #size-cells : 0
> +	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
> +			     operate at should be less than or equal to 18 MHz.
> +	- data-ready-gpios: Interrupt GPIO for data and error reporting. 
> +	- wake-up-gpios: Wake up GPIO to wake up the TCAN device
> +
> +Optional properties:
> +	- clocks: Processor clock phandles (see clock bindings for details)
> +		  If no clock is defined then the default 40MHz freq is set.
> +	- reset-gpios: Hardwired output GPIO. If not defined then software
> +		       reset.
> +
> +Example:
> +tcan4x5x: tcan4x5x@0 {
> +		compatible = "ti,tcan4x5x";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		clocks = <&tclkin_ck>;
> +		spi-max-frequency = <10000000>;
> +		data-ready-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +		wake-up-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
> +	};
> 


-- 
------------------
Dan Murphy
