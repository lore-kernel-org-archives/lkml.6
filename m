Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669EAC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EB92086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfASRi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:38:27 -0500
Received: from mail.ltec.ch ([95.143.48.181]:34064 "EHLO mail.ltec.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbfASRi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:38:27 -0500
Received: from 77-58-140-110.dclient.hispeed.ch ([77.58.140.110] helo=[172.27.111.35])
        by mail.ltec.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <fb@ltec.ch>)
        id 1gkuZZ-0000IH-SC; Sat, 19 Jan 2019 18:38:21 +0100
Subject: Re: [PATCH: linux-next] ARM: dts: am33xx: Remove unnecessary
 properties
To:     Felix Brack <fb@ltec.ch>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     tony@atomide.com, bcousson@baylibre.com, mpfj@newflow.co.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
References: <20181218143931.4151-1-fb@ltec.ch>
From:   Felix Brack <fb@ltec.ch>
Organization: LTEC AG
Message-ID: <31a68b35-8b78-8fee-3dd9-5beb3c386247@ltec.ch>
Date:   Sat, 19 Jan 2019 18:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218143931.4151-1-fb@ltec.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,
On 18.12.18 15:39, Felix Brack wrote:
> Remove the unnecessary properties #address-cells and #size-cells
> of node pinmux as there are no child-nodes with property reg.
> 
> Signed-off-by: Felix Brack <fb@ltec.ch>
> ---
>   arch/arm/boot/dts/am33xx-l4.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
> index 7b818d9d2eab..e957370f8aec 100644
> --- a/arch/arm/boot/dts/am33xx-l4.dtsi
> +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
> @@ -288,8 +288,6 @@
>   				am33xx_pinmux: pinmux@800 {
>   					compatible = "pinctrl-single";
>   					reg = <0x800 0x238>;
> -					#address-cells = <1>;
> -					#size-cells = <0>;
>   					#pinctrl-cells = <1>;
>   					pinctrl-single,register-width = <32>;
>   					pinctrl-single,function-mask = <0x7f>;
> 

Just a gentle ping. BTW: the patch applies not just to linux-next 
correctly but now also to linux.

regards Felix
