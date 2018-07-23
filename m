Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0922620779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0922620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbeGWFeU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:34:20 -0400
Received: from mout.perfora.net ([74.208.4.196]:37335 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387778AbeGWFeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:34:19 -0400
Received: from [10.10.1.111] ([89.217.215.226]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MBUbw-1fpkIC0vDS-00AYVl;
 Mon, 23 Jul 2018 06:34:39 +0200
Date:   Mon, 23 Jul 2018 06:34:31 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180723025747.ykxeqogyfn6wskvo@vireshk-i7>
References: <20180720075356.26156-1-marcel@ziswiler.com> <20180723025747.ykxeqogyfn6wskvo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] ARM: dts: spear: fix stmpe811 interrupt properties
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>
From:   Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <883F78E9-45F8-4AA7-9702-330027ADD741@ziswiler.com>
X-Provags-ID: V03:K1:+z9xE9V8rcNU5zew9Wgsov4NTvfEY1Ck/h494pKzoSXsjAva8I7
 hCFvQdp98HAsmmtYO1ivqQg7zlzyzFkKLZ7bwtZXnFlZs334t3rOrrxIpO3x1hFJLMcEPXr
 59hO4IjTHh7R2GVnDueqkRzOJJ/ySn7usq7Z8Hh7EBKcN0zxnF3vZfExThHWESBm4O9KgXN
 91JEFOXq1TdV18geGd3cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PwGvf7mo4zw=:JCAkfxnCbNkcpZmZBLIZkE
 tgEeaCl+wrSJYwQ42lnuXowdoKjW9jjSLDZEefUqf8wyrbtXKlPJX+EgcGYj30IUwxNV/lQIz
 vbGAaZ7PjE+F/OYVztmF8ZBF2/y5Cid6si0bhu2HOe3S9ukcHswM/V8dWwrlWHd5Ri2Cv23Gd
 8uA3jxA3d4yFVmV5weSm7L3VfGvtrYhp7l+m0yfB0TLEogYZLpve4vup4OqFC4219lJ5bLIK2
 gAqJtsVmh/Dcm0clq3wHP/rrsRLT0LBEn37wg2Y8m4B8I0qZS4M5px+NMcmXOXaogKpUhfHvU
 M3hoBK6CeOepn9SWKQMbYJnMxO86hVkgrIpjsdRF/k0zmpbL7xgTxzcs/wZxYT6n1wL/ZA+5Z
 lfUVjh1tPrlDu6Rzb6dzjCUt0Z8JudaK5XoXC3GzIyA06wLyeB8V8cSxpkIAVkhhWz4IGApsR
 iaegIOJP9Sy2LsSwKs506OaPgrPQXMibxSv/sdHR/Lp0SP1Z87wYJDbkOAEfr0iabRrhWSe8E
 2PkjC61CD5iNIF1QjyD6jwPw+RTodpnzMtycxZG/7+u1mqr0Tn3cMFxmzQQEkgR0v9R9zE+ds
 goWTYJBVu0J6/MorOK7V3xpeJDLiY704RF9qdAmnmh5GxGHpcu0OuMHAb5qPm9RZPf/0E0eag
 GfpCDQqDZHr0GXs084zwBbs38lqM4QqopyIL/u1tDYdy1sRE6p2f0MkyBOAjsB9iCxdf5IIz7
 7033Wy89ArRPQWDi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 23, 2018 4:57:47 AM GMT+02:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>On 20-07-18, 09:53, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> The property "irq-over-gpio" simply does not exist (this is nowadays
>> actually auto detected) and the property "irq-gpios" is actually
>called
>> "irq-gpios".
>
>  "irq-gpio" ?

Yes, of course. Too many s' (;-p).

>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> ---
>> 
>>  arch/arm/boot/dts/spear320-hmi.dts | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/spear320-hmi.dts
>b/arch/arm/boot/dts/spear320-hmi.dts
>> index 0d0da1f65f0e..d2d1fe944407 100644
>> --- a/arch/arm/boot/dts/spear320-hmi.dts
>> +++ b/arch/arm/boot/dts/spear320-hmi.dts
>> @@ -241,8 +241,7 @@
>>  					#address-cells = <1>;
>>  					#size-cells = <0>;
>>  					reg = <0x41>;
>> -					irq-over-gpio;
>> -					irq-gpios = <&gpiopinctrl 29 0x4>;
>> +					irq-gpio = <&gpiopinctrl 29 0x4>;
>>  					id = <0>;
>>  					blocks = <0x5>;
>>  					irq-trigger = <0x1>;
