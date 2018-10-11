Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31922C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E112B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UIAadGBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E112B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeJLCD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:03:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43210 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeJLCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:03:27 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9BIYs8i053033;
        Thu, 11 Oct 2018 13:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539282894;
        bh=eA23f+/TiJLQxO6V6AJ34OuH6jjtumRXVynnv0pGVJk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UIAadGBS2Jc7oG0/OQmPE26ZIZ8V5PadF3E6R2bDbFlc4Rg0VP7jXxzKDJuZzTQUN
         gZmwzum0kTaxEYXUQH0REm4RV7ZOg2J5IKr7Gv/gRHKJrwWnR8Z9xNiWfvxAvcMb1e
         IqxGjzKV7VBUJN2Wq05e63obwT4swlqm8p0rTTnw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BIYsIo022805;
        Thu, 11 Oct 2018 13:34:54 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 11
 Oct 2018 13:34:54 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 11 Oct 2018 13:34:54 -0500
Received: from [172.22.172.124] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9BIYsYp014596;
        Thu, 11 Oct 2018 13:34:54 -0500
Subject: Re: [PATCH v3 2/9] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <lee.jones@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-3-dmurphy@ti.com> <20181011182734.GA7973@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4fcb91c7-b2b2-798d-8a41-fa1b475086e0@ti.com>
Date:   Thu, 11 Oct 2018 13:34:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011182734.GA7973@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 10/11/2018 01:27 PM, Pavel Machek wrote:
> On Thu 2018-10-11 11:51:16, Dan Murphy wrote:
>> Remove support for the LM3697 LED device
>> from the ti-lmu.  The LM3697 will be supported
>> via a stand alone LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> NAK.

Thanks for the NAK.

This NAK was NAK'd by other maintainer in the V2 RFC patchset

https://lore.kernel.org/patchwork/patch/993171/

> 
> 								Pavel
> 								
>> index c885cf89b8ce..920f910be4e9 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>>    LM3632       Backlight and regulator
>>    LM3633       Backlight, LED and fault monitor
>>    LM3695       Backlight
>> -  LM3697       Backlight and fault monitor
>>  
>>  Required properties:
>>    - compatible: Should be one of:
>> @@ -18,11 +17,10 @@ Required properties:
>>                  "ti,lm3632"
>>                  "ti,lm3633"
>>                  "ti,lm3695"
>> -                "ti,lm3697"
>>    - reg: I2C slave address.
>>           0x11 for LM3632
>>           0x29 for LM3631
>> -         0x36 for LM3633, LM3697
>> +         0x36 for LM3633
>>           0x38 for LM3532
>>           0x63 for LM3695
>>  
>> @@ -38,7 +36,6 @@ Optional nodes:
>>      Required properties:
>>        - compatible: Should be one of:
>>                      "ti,lm3633-fault-monitor"
>> -                    "ti,lm3697-fault-monitor"
>>    - leds: LED properties for LM3633. Please refer to [2].
>>    - regulators: Regulator properties for LM3631 and LM3632.
>>                  Please refer to [3].
>> @@ -220,24 +217,3 @@ lm3695@63 {
>>  		};
>>  	};
>>  };
>> -
>> -lm3697@36 {
>> -	compatible = "ti,lm3697";
>> -	reg = <0x36>;
>> -
>> -	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>> -
>> -	backlight {
>> -		compatible = "ti,lm3697-backlight";
>> -
>> -		lcd {
>> -			led-sources = <0 1 2>;
>> -			ramp-up-msec = <200>;
>> -			ramp-down-msec = <200>;
>> -		};
>> -	};
>> -
>> -	fault-monitor {
>> -		compatible = "ti,lm3697-fault-monitor";
>> -	};
>> -};
> 


-- 
------------------
Dan Murphy
