Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAE7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745622087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfAHI5a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:57:30 -0500
Received: from [38.106.11.25] ([38.106.11.25]:47488 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbfAHI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:57:30 -0500
X-ASG-Debug-ID: 1546937844-107606139f152750001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id LzL2Zu51YUH14gAn (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 08 Jan 2019 16:57:24 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 16:57:19 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Tue, 8 Jan 2019 16:57:19 +0800
From:   "Liu, Xiaoting" <xiaoting.liu@hxt-semitech.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon: add dps650ab documentation
Thread-Topic: [PATCH v2 2/4] dt-bindings: hwmon: add dps650ab documentation
X-ASG-Orig-Subj: Re: [PATCH v2 2/4] dt-bindings: hwmon: add dps650ab documentation
Thread-Index: AQHUpnWQzQeKH0TYK0OcFgV3qTYMfw==
Date:   Tue, 8 Jan 2019 08:57:19 +0000
Message-ID: <6d28f64bd2f441d09819d66b55537e0b@HXTBJIDCEMVIW02.hxtcorp.net>
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <0087d2d9c7cd7f38761f76c80d1c37cb2cea6ef2.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <568735a3-1de2-3880-5fe1-7be38a55f33f@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.1.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1546937844
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1391
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4824 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65314
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/7 21:58, Guenter Roeck wrote:
> On 1/7/19 3:00 AM, Xiaoting Liu wrote:
>> Bindings for DPS650AB power, voltage, temperature, and fan monitering.
>>
>> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
>> ---
>> v2:
>>    Change the patch subject.
>> ---
>>   Documentation/devicetree/bindings/hwmon/dps650ab.txt | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
>> new file mode 100644
>> index 000000000000..6bbbff89f6d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
>> @@ -0,0 +1,11 @@
>> +Bindings for DPS650AB power, voltage, temperature, and fan monitering
>> +
> Assuming this is the Delta Electronics DPS-650-AB power supply, I think
> you should mention that here.
I will update commit message as mentioned.
>
>> +Required properties:
>> +- compatible : "dps650ab"
> Again, assuming this is the Delta Electronics power supply, this should
> probably be something like "delta,dps650ab".

OK, I will add delta to compatible property.

Thanks,

Xiaoting

>
> Thanks,
> Guenter
>
>> +- reg       : I2C address, one of 0x58, 0x59.
>> +
>> +Example:
>> +       dps650ab@58 {
>> +                   compatible = "dps650ab";
>> +                   reg = <0x58>;
>> +       };
>> --
>> 1.8.3.1
>>
>>
>>
>>

