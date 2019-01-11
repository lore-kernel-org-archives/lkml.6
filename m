Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F076C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14F20656
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfAKIZi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:25:38 -0500
Received: from [223.203.96.18] ([223.203.96.18]:65181 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728295AbfAKIZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:25:38 -0500
X-ASG-Debug-ID: 1547195131-107606139f17e390001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id uJI7HTgM7NmpVMjI (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 11 Jan 2019 16:25:32 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 11 Jan 2019 16:25:24 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Fri, 11 Jan 2019 16:25:24 +0800
From:   "Liu, Xiaoting" <xiaoting.liu@hxt-semitech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: hwmon: add dps650ab documentation
Thread-Topic: [PATCH v3 2/4] dt-bindings: hwmon: add dps650ab documentation
X-ASG-Orig-Subj: Re: [PATCH v3 2/4] dt-bindings: hwmon: add dps650ab documentation
Thread-Index: AQHUpyB956RJj2bOg0KNjbfbMBgDFA==
Date:   Fri, 11 Jan 2019 08:25:23 +0000
Message-ID: <878e5a2d4495479688ff6df866b092e5@HXTBJIDCEMVIW02.hxtcorp.net>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <0527fcf7155ea12a2a1be680b3617691e6e26d72.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <20190110184624.GC9010@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.1.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1547195132
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1579
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4995 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65511
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/11 2:46, Guenter Roeck wrote:
> On Thu, Jan 10, 2019 at 10:24:33AM +0800, Xiaoting Liu wrote:
>> Bindings for Delta Electronics DPS-650-AB power supply.
>>
>> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> Waiting for DT maintainer Ack to apply. Note that you did not copy
> linux-hwmon@vger.kernel.org. As a result, it _may_ get lost since
> https://patchwork.kernel.org/project/linux-hwmon/list/ is my primary
> means to track hwmon patches, and it isn't there.
> If I don't the patch after the Ack, please resend and remember
> to include the hwmon mailing list.
>
> Thanks,
> Guenter

Thanks for your kindly reminder! I will loop linux-hwmon@vger.kernel.org

when I resend the patch.

Xiaoting

>> ---
>> v3:
>>   Change patch commit message.
>>   Add vendor delta to the compatible property.
>> ---
>> v2:
>>   Change the patch subject.
>> ---
>>  Documentation/devicetree/bindings/hwmon/dps650ab.txt | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
>> new file mode 100644
>> index 000000000000..32d89e4f4956
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
>> @@ -0,0 +1,11 @@
>> +Bindings for Delta Electronics DPS-650-AB power supply
>> +
>> +Required properties:
>> +- compatible : "delta,dps650ab"
>> +- reg        : I2C address, one of 0x58, 0x59.
>> +
>> +Example:
>> +	dps650ab@58 {
>> +		    compatible = "delta,dps650ab";
>> +		    reg = <0x58>;
>> +	};
>> -- 
>> 1.8.3.1
>>

