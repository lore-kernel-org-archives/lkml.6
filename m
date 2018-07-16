Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306C72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306C72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeGPKAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:00:40 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:25256 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeGPKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:00:40 -0400
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="13606723"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jul 2018 02:34:07 -0700
Received: from [10.145.4.138] (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Mon, 16 Jul 2018
 02:34:06 -0700
Subject: Re: [PATCH] ARM: dts: at91: fix typo for PIN_PB22
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531326337-15504-1-git-send-email-claudiu.beznea@microchip.com>
 <20180712063021.h7t424iksdulj74a@M43218.corp.atmel.com>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <f5cdc41d-8c6e-0f7f-9fbe-2b4057008720@microchip.com>
Date:   Mon, 16 Jul 2018 12:34:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712063021.h7t424iksdulj74a@M43218.corp.atmel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ludovic,

On 12.07.2018 09:30, Ludovic Desroches wrote:
> Hi Claudiu,
> 
> On Wed, Jul 11, 2018 at 07:25:37PM +0300, Claudiu Beznea wrote:
>> Fix typo for PIN_PB22 on TD function.
> 
> In fact, this typo is present in several places in this file. It could
> be worth fixing all those occurences in a single patch.

Sure, I will look over all those occurrences.

Thank you,
Claudiu

> 
> Regards
> 
> Ludovic
> 
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  arch/arm/boot/dts/sama5d2-pinfunc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
>> index e57191fb83de..ac61491c9d7f 100644
>> --- a/arch/arm/boot/dts/sama5d2-pinfunc.h
>> +++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
>> @@ -375,7 +375,7 @@
>>  #define PIN_PB22__GPIO			PINMUX_PIN(PIN_PB22, 0, 0)
>>  #define PIN_PB22__LCDDAT11		PINMUX_PIN(PIN_PB22, 1, 1)
>>  #define PIN_PB22__A11			PINMUX_PIN(PIN_PB22, 2, 1)
>> -#define PIN_PB22__TDO			PINMUX_PIN(PIN_PB22, 3, 1)
>> +#define PIN_PB22__TD0			PINMUX_PIN(PIN_PB22, 3, 1)
>>  #define PIN_PB22__TIOA2			PINMUX_PIN(PIN_PB22, 4, 2)
>>  #define PIN_PB22__FLEXCOM3_IO1		PINMUX_PIN(PIN_PB22, 5, 3)
>>  #define PIN_PB22__GMDC			PINMUX_PIN(PIN_PB22, 6, 3)
>> -- 
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
