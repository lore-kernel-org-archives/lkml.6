Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+8AtxrWxlVbY0JdI2jIS4soYwDZnqNhK+CaW5WeWhaIt3bATPbC9yjqYXTzypTnAmDaQ86
ARC-Seal: i=1; a=rsa-sha256; t=1523920950; cv=none;
        d=google.com; s=arc-20160816;
        b=EUuc/k/xqqrAmS/iJFWkxfa7NETza5Pd0+EPfEP52iPKveb4v1Dp7cBeJPbMaTX46p
         riy67G4TjaG2KvUY64ukC8FqXgRCT4HRM5juF/u+HWlgwl1ac6XSjPpqG6RVs/mzMRSj
         HFywrXb64tq0P7SPRuKcXYplTWYgK2yA23icbfzLLCxVyDo1PsaxZ8/ZdMO5CWqi8Rv1
         opLDanAAF/9qpDreHYjHrN88ESGZE3Ru+1cPjgRujyYgFni3rB5o1lXCYV3YtFaQ8YdK
         aYaDsWxjITDw9SyPA+cn+HXE84hUR6Trcz07EbKiFs2ri5EQxBggoQ13AL+c1/SNS4iN
         zSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=jdaYpymz1zOnjJQpfNc05acWyMznpv2Qllk3s3YrM2I=;
        b=gdI+Y3Koo5RZgJbNHP2hCELAiYwimMhjxDzgTOZrjvioRnOobyM++8a4d7K428d3mG
         yjkahxa27QoaruZzA7WqCKlF1mflPqh8uiAmTinGreJ8VcemkNJ8k1quDi30+GTRVUJM
         F1vde/3uwNeaIOn7KiUN1rAoPGZLl1t+Vz+UcFwFv4tpm09OfqhboKuGcB8b3KQWIq/e
         QogA8Tq12PVr8Y/dkendXKQxh4KzghhTXoZ5uIcs928ZhZJEOB/SRM4uxyatqj9VNZql
         oz+YH5/QVBpwfBgPCqTg6ofDzBjmL1RtpQh84uPwZtcaQhvWCFzAW4wnOzdvQsmUSBiv
         FPOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="192003509"
Subject: Re: [PATCH v3 07/10] Documentation: dt-bindings: Add documents for
 PECI hwmon client drivers
To: Rob Herring <robh@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Haiyue Wang
 <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-8-jae.hyun.yoo@linux.intel.com>
 <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <aee4e04c-885f-b1d8-9e85-9e741551342f@linux.intel.com>
Date: Mon, 16 Apr 2018 16:22:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416181423.t4vf7sugv6z3aw5h@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385139320717723?=
X-GMAIL-MSGID: =?utf-8?q?1597946934611222109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 11:14 AM, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 11:32:09AM -0700, Jae Hyun Yoo wrote:
>> This commit adds dt-bindings documents for PECI cputemp and dimmtemp client
>> drivers.
> 
> "dt-bindings: hwmon: ..." for the subject.
> 

I'll change the subject.

>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Julia Cartwright <juliac@eso.teric.us>
>> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> Cc: Milton Miller II <miltonm@us.ibm.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
>> Cc: Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>
>> ---
>>   .../devicetree/bindings/hwmon/peci-cputemp.txt     | 24 +++++++++++++++++++++
>>   .../devicetree/bindings/hwmon/peci-dimmtemp.txt    | 25 ++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>> new file mode 100644
>> index 000000000000..d5530ef9cfd2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>> @@ -0,0 +1,24 @@
>> +Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
>> +
>> +Required properties:
>> +- compatible : Should be "intel,peci-cputemp".
>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients is starting from 0x30 based on PECI specification.
>> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
> 
> Again, where is PECI_OFFSET_MAX defined? It can't depend on something in
> the kernel.
> 

I'll remove the unnecessary description.

>> +
>> +Example:
>> +	peci-bus@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		< more properties >
>> +
>> +		peci-cputemp@cpu0 {
>> +			compatible = "intel,peci-cputemp";
>> +			reg = <0x30>;
>> +		};
>> +
>> +		peci-cputemp@cpu1 {
>> +			compatible = "intel,peci-cputemp";
>> +			reg = <0x31>;
>> +		};
>> +	};
>> diff --git a/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
>> new file mode 100644
>> index 000000000000..56e5deb61e5c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
>> @@ -0,0 +1,25 @@
>> +Bindings for Intel PECI (Platform Environment Control Interface) dimmtemp
>> +driver.
>> +
>> +Required properties:
>> +- compatible : Should be "intel,peci-dimmtemp".
>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients is starting from 0x30 based on PECI specification.
>> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
>> +
>> +Example:
>> +	peci-bus@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		< more properties >
>> +
>> +		peci-dimmtemp@cpu0 {
> 
> unit-address is wrong.
> 

Will fix it using the reg value.

> It is a different bus from cputemp? Otherwise, you have conflicting
> addresses. If that's the case, probably should make it clear by showing
> different host adapters for each example.
> 

It could be the same bus with cputemp. Also, client address sharing is 
possible by PECI core if the functionality is different. I mean, cputemp 
and dimmtemp targeting the same client is possible case like this.
peci-cputemp@30
peci-dimmtemp@30

>> +			compatible = "intel,peci-dimmtemp";
>> +			reg = <0x30>;
>> +		};
>> +
>> +		peci-dimmtemp@cpu1 {
>> +			compatible = "intel,peci-dimmtemp";
>> +			reg = <0x31>;
>> +		};
>> +	};
>> -- 
>> 2.16.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
