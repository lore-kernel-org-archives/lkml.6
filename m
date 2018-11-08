Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892DFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF7020827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF7020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKIDwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:52:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49338 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeKIDwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:52:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8IFTwW048674;
        Thu, 8 Nov 2018 12:15:29 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8IFTZb092189
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 12:15:29 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 12:15:28 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 12:15:28 -0600
Received: from [172.22.151.38] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8IFSFI004967;
        Thu, 8 Nov 2018 12:15:28 -0600
Subject: Re: [PATCH 13/24] dt-bindings: lm36010: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-14-git-send-email-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <78afad2e-6b0f-eb2e-fac4-47249b05c540@ti.com>
Date:   Thu, 8 Nov 2018 12:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541542052-10081-14-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---

Acked-by: Dan Murphy <dmurphy@ti.com>

>  Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> index a88b2c4..aaffc68 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
> @@ -22,9 +22,14 @@ Required properties for flash LED child nodes:
>  	- led-max-microamp : Range from 2.4mA - 376mA
>  
>  Optional child properties:
> -	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- function : see Documentation/devicetree/bindings/leds/common.txt
> +	- color : see Documentation/devicetree/bindings/leds/common.txt
> +	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
>  
>  Example:
> +
> +#include <dt-bindings/leds/functions.h>
> +
>  led-controller@64 {
>  	compatible = "ti,lm36010";
>  	#address-cells = <1>;
> @@ -33,7 +38,8 @@ led-controller@64 {
>  
>  	led@0 {
>  		reg = <1>;
> -		label = "white:torch";
> +		function = LED_FUNCTION_TORCH;
> +		color = "white";
>  		led-max-microamp = <376000>;
>  		flash-max-microamp = <1500000>;
>  		flash-max-timeout-us = <1600000>;
> 


-- 
------------------
Dan Murphy
