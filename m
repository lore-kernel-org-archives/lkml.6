Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312EAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B9208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30B9208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeKTQG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 11:06:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52680 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 11:06:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK5dTS9001639;
        Mon, 19 Nov 2018 23:39:29 -0600
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK5dTcK092117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 23:39:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 23:39:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 23:39:29 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK5dRa9004328;
        Mon, 19 Nov 2018 23:39:28 -0600
Subject: Re: [PATCH] MAINTAINERS: Add Kishon as maintainer of PHY bindings
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20181018133105.3720-1-robh@kernel.org>
 <CAL_JsqJn2EOGJaM9saoYYnbZ+GrEMQWgp_1kSq6W9HX1GnGVWw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5b1104bc-7542-124c-2f93-27af10e36178@ti.com>
Date:   Tue, 20 Nov 2018 11:09:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJn2EOGJaM9saoYYnbZ+GrEMQWgp_1kSq6W9HX1GnGVWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 17/11/18 1:50 AM, Rob Herring wrote:
> On Thu, Oct 18, 2018 at 8:31 AM Rob Herring <robh@kernel.org> wrote:
>>
>> DT bindings normally go in via subsystem maintainers, so add PHY
>> bindings under generic PHY framework.
>>
>> Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Ping? Kishon, any objection?

It's queued [1].

Thanks
Kishon

[1] -> 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/MAINTAINERS?id=5c7412b139f189e18842d62951f6857e4937ce73
> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9ad052aeac39..b01e77ae79c4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6132,6 +6132,7 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
>>   S:     Supported
>>   F:     drivers/phy/
>>   F:     include/linux/phy/
>> +F:     Documentation/devicetree/bindings/phy/
>>
>>   GENERIC PINCTRL I2C DEMULTIPLEXER DRIVER
>>   M:     Wolfram Sang <wsa+renesas@sang-engineering.com>
>> --
>> 2.17.1
>>
