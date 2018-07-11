Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE2C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE2C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeGKINY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:13:24 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:16072 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeGKINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:13:24 -0400
Received: from [10.28.16.194] (10.28.16.194) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 11 Jul
 2018 16:10:18 +0800
Subject: Re: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A
 SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <robh@kernel.org>
CC:     <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
        <qianggui.song@amlogic.com>, <devicetree@vger.kernel.org>,
        <sboyd@kernel.org>, <khilman@baylibre.com>,
        <mturquette@baylibre.com>, <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>, <bo.yang@amlogic.com>,
        <qiufang.dai@amlogic.com>, <linux-arm-kernel@lists.infradead.org>,
        <carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
        <sunny.luo@amlogic.com>, <linux-clk@vger.kernel.org>,
        <xingyu.chen@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBJp1xzo-CNW1HU-Odhrug31yQ7c3khB+XwvsNXp5-gTA@mail.gmail.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <024e6d89-b60d-ba85-4d62-c3358e2cab6c@amlogic.com>
Date:   Wed, 11 Jul 2018 16:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBJp1xzo-CNW1HU-Odhrug31yQ7c3khB+XwvsNXp5-gTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.16.194]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/10 5:57, Martin Blumenstingl wrote:
> adding Rob Herring so it doesn't get lost on the devicetree mailing list
> 
> On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
>>
>> Add new binding for Meson-G12A SoC Everything-Else part
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> index e950599..0833006 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> @@ -9,6 +9,7 @@ Required Properties:
>>                  "amlogic,gxbb-clkc" for GXBB SoC,
>>                  "amlogic,gxl-clkc" for GXL and GXM SoC,
>>                  "amlogic,axg-clkc" for AXG SoC.
>> +               "amlogic,g12a-clkc" for G12A SoC.
> should this be "amlogic,meson-g12a-clkc" instead?
> that would make it consistent with virtually all other bindings which
> use the schema "amlogic,meson<chip>-<ip-block>" (where chip is 8, 8b,
> 8m2, -gxbb, -gxl, ...)
> 
> see also: $ grep -R "amlogic," Documentation/devicetree/bindings/
> 
Which type should we choose,have a discussion?
.compatible = "amlogic,g12a-clkc or
.compatible = "amlogic,meson-g12a-clkc
>>
>>   - #clock-cells: should be 1.
>>
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> .
> 
