Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F69C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A11205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A11205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeK2XaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:30:07 -0500
Received: from mx.socionext.com ([202.248.49.38]:7312 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbeK2XaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:30:06 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Nov 2018 21:24:53 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 592BA180BCB;
        Thu, 29 Nov 2018 21:24:53 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 29 Nov 2018 21:24:53 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C211940377;
        Thu, 29 Nov 2018 21:24:52 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A1DB9120455;
        Thu, 29 Nov 2018 21:24:52 +0900 (JST)
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline
 description
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
Message-ID: <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com>
Date:   Thu, 29 Nov 2018 21:24:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2018/11/28 11:01, Stephen Boyd wrote:
> Quoting Sugaya Taichi (2018-11-18 17:01:07)
>> Add DT bindings document for Milbeaut trampoline.
>>
>> Signed-off-by: Sugaya Taichi<sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/soc/socionext/socionext,m10v.txt     | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>> new file mode 100644
>> index 0000000..f5d906c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
>> @@ -0,0 +1,12 @@
>> +Socionext M10V SMP trampoline driver binding
>> +
>> +This is a driver to wait for sub-cores while boot process.
>> +
>> +- compatible: should be "socionext,smp-trampoline"
>> +- reg: should be <0x4C000100 0x100>
>> +
>> +EXAMPLE
>> +       trampoline: trampoline@0x4C000100 {
> Drop the 0x part of unit addresses.

Okay.


>> +               compatible = "socionext,smp-trampoline";
>> +               reg = <0x4C000100 0x100>;
> Looks like a software construct, which we wouldn't want to put into DT
> this way. DT doesn't describe drivers.
We would like to use this node only getting the address of the 
trampoline area
in which sub-cores wait.  (They have finished to go to this area in previous
bootloader process.)

So should we embed the constant value in source codes instead of getting 
from
DT because the address is constant at the moment? Or is there other 
approach?

Thanks
Sugaya Taichi

