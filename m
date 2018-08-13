Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF06C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC062177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mxN8Gy8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC062177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeHMWBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:01:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43018 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeHMWBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:01:20 -0400
Received: from [192.168.0.67] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D3DA1CE;
        Mon, 13 Aug 2018 21:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534187865;
        bh=LdO0ghtQwqk+uKUc23GhRiVnO7po8gNB4WrPKORXCHM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mxN8Gy8iq7PTImEKHWIE+vsa4XjClMsMg1YE5QV9LC2aopIaE2Suf25fJF88sXkWh
         GimJh86iuFloBDu/CXo/YfKoG3JNO7SbzjhpTuW95LfiZbbp89mH6CRU8eqbu6BieQ
         7qYyx3Emu5sBgVGZzyvBlbzJAOacYm74dNa/5Q/8=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH v3] dt-bindings: media: adv748x: Document re-mappable
 addresses
To:     Rob Herring <robh@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180809192944.7371-1-kieran.bingham@ideasonboard.com>
 <20180813174544.GA11379@rob-hp-laptop>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <dedade62-91ed-2c92-dac7-fe4a8f9d9452@ideasonboard.com>
Date:   Mon, 13 Aug 2018 20:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813174544.GA11379@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 13/08/18 18:45, Rob Herring wrote:
> On Thu, Aug 09, 2018 at 08:29:44PM +0100, Kieran Bingham wrote:
>> The ADV748x supports configurable slave addresses for its I2C pages.
>> Document the page names, and provide an example for setting each of the
>> pages explicitly.
> 
> It would be good to say why you need this. 

In fact - I should probably have added a fixes tag here, which would
have added more context:

Fixes: 67537fe960e5 ("media: i2c: adv748x: Add support for
i2c_new_secondary_device")

Should I repost with this fixes tag?
Or can it be collected with the RB tag?


> The only use I can think of 
> is if there are other devices on the bus and you need to make sure the 
> addresses don't conflict.

Yes, precisely. This driver has 'slave pages' which are created and
mapped by the driver. The device has default addresses which are used by
the driver - but it's very easy for these to conflict with other devices
on the same I2C bus.

Because the mappings are simply a software construct, we have a means to
specify the desired mappings through DT at the board level - which
allows the boards to ensure that conflicts do not appear.


> Arguably, that information could be figured out without this in DT.

How so ?

Scanning the bus is error prone, and dependant upon driver state (and
presence), and we have no means currently of requesting 'free/unused'
addresses from the I2C core framework.

> Regardless,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you.

--
Regards

Kieran



> 
>>
>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> ---
>> v2:
>>  - Fix commit message
>>  - Extend documentation for the "required property" reg:
>>
>> v3
>>  - Fix missing comment from Laurent.
>>  - correct the reg descrption
>> ---
>>  .../devicetree/bindings/media/i2c/adv748x.txt    | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
>> index 21ffb5ed8183..25a02496f4ba 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
>> +++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
>> @@ -10,7 +10,11 @@ Required Properties:
>>      - "adi,adv7481" for the ADV7481
>>      - "adi,adv7482" for the ADV7482
>>  
>> -  - reg: I2C slave address
>> +  - reg: I2C slave addresses
>> +    The ADV748x has up to twelve 256-byte maps that can be accessed via the
>> +    main I2C ports. Each map has it own I2C address and acts as a standard
>> +    slave device on the I2C bus. The main address is mandatory, others are
>> +    optional and remain at default values if not specified.
>>  
>>  Optional Properties:
>>  
>> @@ -18,6 +22,11 @@ Optional Properties:
>>  		     "intrq3". All interrupts are optional. The "intrq3" interrupt
>>  		     is only available on the adv7481
>>    - interrupts: Specify the interrupt lines for the ADV748x
>> +  - reg-names : Names of maps with programmable addresses.
>> +		It shall contain all maps needing a non-default address.
>> +		Possible map names are:
>> +		  "main", "dpll", "cp", "hdmi", "edid", "repeater",
>> +		  "infoframe", "cbus", "cec", "sdp", "txa", "txb"
>>  
>>  The device node must contain one 'port' child node per device input and output
>>  port, in accordance with the video interface bindings defined in
>> @@ -47,7 +56,10 @@ Example:
>>  
>>  	video-receiver@70 {
>>  		compatible = "adi,adv7482";
>> -		reg = <0x70>;
>> +		reg = <0x70 0x71 0x72 0x73 0x74 0x75
>> +		       0x60 0x61 0x62 0x63 0x64 0x65>;
>> +		reg-names = "main", "dpll", "cp", "hdmi", "edid", "repeater",
>> +			    "infoframe", "cbus", "cec", "sdp", "txa", "txb";
>>  
>>  		#address-cells = <1>;
>>  		#size-cells = <0>;
>> -- 
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards
--
Kieran
