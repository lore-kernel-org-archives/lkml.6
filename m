Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/y9J8L5dbpkvWtwSvO93+zJKIgZGSzf3143AQwZz0oZUY/JtgiCoRh1rDzDtI+on5Yfu/g
ARC-Seal: i=1; a=rsa-sha256; t=1523920371; cv=none;
        d=google.com; s=arc-20160816;
        b=ZaUy3VeXWatTgsgf0iS9ch3ZfeC348606cmLkWXYU991+FVVYs579YU/yVRoLcnUEl
         fh7otPYa5S+qwzsw0nxJiAYXwugu6sM/GWRPBYpTEqqjWtG+AP8vw7AZxfdElBPDv8PW
         NRHrbrdqt6YF1Bu6qOpkJyyeikPU6hKurZ2Sjc3hpRDzSTYkQIWA+BfDei1BbSBtrwXi
         zIFAIjDGgzduHdYybjU+qdhjTcwt829WZNyWOjcQMDXDZZ2+0bG/xS6la3J8BClLfWun
         fLuk4C8gu5LJts15q6mOXkZcB2RH/cCjpfMO9kV1O4GE+K/e/ITOXfJHJDoGQ22STUk2
         34ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=y7p/9jj8upN1EoA/npN30T47H44TlLbbzIav+Vna/+A=;
        b=OL2WF/r0wnGo5QGyHCQlfRPdKbz7agxE5STUi4i94dcCwmcM7pFVycDEk/VKb0rK3N
         JklD90LfRApzAyfDneHzMCv1PDuDVEBvCmXjoKRzcKDLMGAjHFxsl2l0vNZ1qdEuzzE/
         L7Te0BYil+rYLu2QbQywkGkD/ROYwC7M0p7XAevocEaCIZXPkco1T6op2bCQhIJoMymw
         i54g/swzTWBMGEgPsq4K/yXgrRCSb0lxsHZghUHXOGk/ae+TBVaH7viff1jeg7UIBO/8
         zud2gKIucrOXrQOvqqltiV8+7+TcNvSJ4HWD2maA93LStMEP3pBhrIN6+bCmirwq3Y/L
         k2+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="192002221"
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
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
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
 <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <53ff5b2b-eba8-8311-64a9-abd4bc72226d@linux.intel.com>
Date: Mon, 16 Apr 2018 16:12:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1597946327546266670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/16/2018 11:10 AM, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
>> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
>> AST24xx/25xx SoCs.
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
>>   .../devicetree/bindings/peci/peci-aspeed.txt       | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> new file mode 100644
>> index 000000000000..4598bb8c20fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> @@ -0,0 +1,60 @@
>> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
>> +
>> +Required properties:
>> +- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
>> +		      - aspeed,ast2400-peci: Aspeed AST2400 family PECI
>> +					     controller
>> +		      - aspeed,ast2500-peci: Aspeed AST2500 family PECI
>> +					     controller
>> +- reg               : Should contain PECI controller registers location and
>> +		      length.
>> +- #address-cells    : Should be <1>.
>> +- #size-cells       : Should be <0>.
>> +- interrupts        : Should contain PECI controller interrupt.
>> +- clocks            : Should contain clock source for PECI controller.
>> +		      Should reference clkin.
>> +- clock_frequency   : Should contain the operation frequency of PECI controller
>> +		      in units of Hz.
>> +		      187500 ~ 24000000
> 
> This is the frequency of the bus or used to derive it? It would be
> better to specify the bus frequency instead and have the driver
> calculate its internal freq. And then use "bus-frequency" instead.
> 

I agree with you. Actually, it is being used for operation frequency 
setting of PECI controller module in SoC so it's different from the 
meaning of "bus-frequency". I'll change it to "operation-frequency".

>> +
>> +Optional properties:
>> +- msg-timing-nego   : Message timing negotiation period. This value will
>> +		      determine the period of message timing negotiation to be
>> +		      issued by PECI controller. The unit of the programmed
>> +		      value is four times of PECI clock period.
>> +		      0 ~ 255 (default: 1)
>> +- addr-timing-nego  : Address timing negotiation period. This value will
>> +		      determine the period of address timing negotiation to be
>> +		      issued by PECI controller. The unit of the programmed
>> +		      value is four times of PECI clock period.
>> +		      0 ~ 255 (default: 1)
>> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
>> +		      time will be divided into 16 time frames. This value will
>> +		      determine the time frame in which the controller will
>> +		      sample PECI signal for data read back. Usually in the
>> +		      middle of a bit time is the best.
>> +		      0 ~ 15 (default: 8)
>> +- cmd_timeout_ms    : Command timeout in units of ms.
>> +		      1 ~ 60000 (default: 1000)
> 
> s/_/-/
> 

Will fix it.

> 
> All these either need vendor prefixes or should be standard properties
> for PECI adapters. I think probably the latter case. If so, the first
> 2 should probably be in units of clocks (not 4 clocks). And they should
> then be documented in the common PECI binding doc.
> 

So far I've checked that these are ASPEED PECI controller specific 
properties so it should be listed in here.

>> +
>> +Example:
>> +	peci: peci@1e78b000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x1e78b000 0x60>;
> 
> No need to show this part in examples.
> 

Got it. Will drop the part.

>> +
>> +		peci0: peci-bus@0 {
>> +			compatible = "aspeed,ast2500-peci";
>> +			reg = <0x0 0x60>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			interrupts = <15>;
>> +			clocks = <&clk_clkin>;
>> +			clock-frequency = <24000000>;
>> +			msg-timing-nego = <1>;
>> +			addr-timing-nego = <1>;
>> +			rd-sampling-point = <8>;
>> +			cmd-timeout-ms = <1000>;
>> +		};
>> +	};
>> -- 
>> 2.16.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
