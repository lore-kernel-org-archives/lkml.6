Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+vqz1JQ/jipjjJs2nQSCk+W8xCnHqf7zAsUavt8d7f2DU4XwqXAYWVwSnNhb5NI2NO+bIY
ARC-Seal: i=1; a=rsa-sha256; t=1523919978; cv=none;
        d=google.com; s=arc-20160816;
        b=lRUMn3qgu/d8maGU6b96/OcLLIusdO9c6lf2SYni8DPnCPLZbc8p/ldr1USqu5Lvwo
         rZhpYIVYggs+5ps4d6Not+FV5FfmxrXKEIc+RmpPB0ohjc7IOxX4O97BtO21e+VhoBSA
         FvTGc6ilZ+eEG3LSvDI3oyA51WeDeLWyzDIcGngx6WNTXKmwerNP7lqeQnbMu0jq+v0Z
         n3hHOxUDti3O1kpDs551XeQuvE4+1+89ALREE/JRygubYRfHFGPGjyETIehZNoD+xlPx
         PHgwBCAm9zP0a0tSEbc4/G/ryTWT/G/diQ42VW7ecXyQHCtbxuWV9ll1XSYyVgfeXsEl
         JQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bSZInII5+jtaGm9BEld7VahNdnyfoO94C7jgt8/C0Yw=;
        b=PoljMdpG1t1vfUvjKUrT4YTwISPaulN3/VyQ01YcaqmDVn4B/Pjg53ggECdF+u2Uua
         wVURSb2PpFAdRUV6cVhDNmvo2bPyPrFmczfUvNQ5IvKHI33Ib8fgoCw5SFdW3noDyLgw
         B1HTokvvPyPEqiF621aCy3vmJb5I5j1C3vn1Ew290oCwjXuK2xkzjEuREiZ/OPTBpO7U
         CrQltxdZU3QUcfExdsKsrP7TdZo+vZlpSxDlY6E5efzXiEGMXq+lBo+KZ0hfnt5JK5z6
         OV1wn77MqZi8/q3Ft46roB/g3qzRZO+FcEBD/Zu/8MLoTWI+UO3vnbyydR6aSMp+TEWC
         xmfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,461,1517904000";
   d="scan'208";a="192001291"
Subject: Re: [PATCH v3 01/10] Documentations: dt-bindings: Add documents of
 generic PECI bus, adapter and client drivers
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
 Vernon Mauery <vernon.mauery@linux.intel.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-2-jae.hyun.yoo@linux.intel.com>
 <20180416175936.4vcse73mrnyk242m@rob-hp-laptop>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <2ce14097-e003-d59a-a05c-1cee55cb0929@linux.intel.com>
Date: Mon, 16 Apr 2018 16:06:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416175936.4vcse73mrnyk242m@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385124256903080?=
X-GMAIL-MSGID: =?utf-8?q?1597945915243738020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

Thanks for sharing your time. Please see my answers inline.

On 4/16/2018 10:59 AM, Rob Herring wrote:
> On Tue, Apr 10, 2018 at 11:32:03AM -0700, Jae Hyun Yoo wrote:
>> This commit adds documents of generic PECI bus, adapter and client drivers.
> 
> "dt-bindings: ..." for the subject prefix please.
>

Sure, I'll change the subject.

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
>>   .../devicetree/bindings/peci/peci-adapter.txt      | 23 ++++++++++++++++++++
>>   .../devicetree/bindings/peci/peci-bus.txt          | 15 +++++++++++++
>>   .../devicetree/bindings/peci/peci-client.txt       | 25 ++++++++++++++++++++++
> 
> This should be all one document.
> 

Okay. I'll combine them into one document.

>>   3 files changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-adapter.txt
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-bus.txt
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-client.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-adapter.txt b/Documentation/devicetree/bindings/peci/peci-adapter.txt
>> new file mode 100644
>> index 000000000000..9221374f6b11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-adapter.txt
>> @@ -0,0 +1,23 @@
>> +Generic device tree configuration for PECI adapters.
>> +
>> +Required properties:
>> +- compatible     : Should contain hardware specific definition strings that can
>> +		   match an adapter driver implementation.
>> +- reg            : Should contain PECI controller registers location and length.
> 
> No need for these 2 here.
> 

Will drop these 2.

>> +- #address-cells : Should be <1>.
>> +- #size-cells    : Should be <0>.
> 
> Some details on the addressing for PECI would be good.
> 

It is for the PECI client address. Will add details.

>> +
>> +Example:
>> +	peci: peci@10000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x10000000 0x1000>;
>> +
> 
> This part of the example is not relevant. Just start with the adapter
> node.
> 

Will remove that part. Thanks!

>> +		peci0: peci-bus@0 {
>> +			compatible = "soc,soc-peci";
>> +			reg = <0x0 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> diff --git a/Documentation/devicetree/bindings/peci/peci-bus.txt b/Documentation/devicetree/bindings/peci/peci-bus.txt
>> new file mode 100644
>> index 000000000000..90bcc791ccb0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-bus.txt
>> @@ -0,0 +1,15 @@
>> +Generic device tree configuration for PECI buses.
>> +
>> +Required properties:
>> +- compatible     : Should be "simple-bus".
> 
> I don't understand what this has to do with PECI? "simple-bus" already
> has a defined meaning.
> 

Maybe I'm wrong but I intended to show this node is an umbrella node of 
a PECI bus subsystem. What should I use then?

>> +- #address-cells : Should be <1>.
>> +- #size-cells    : Should be <1>.
>> +- ranges         : Should contain PECI controller registers ranges.
>> +
>> +Example:
>> +	peci: peci@10000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x10000000 0x1000>;
>> +	};
>> diff --git a/Documentation/devicetree/bindings/peci/peci-client.txt b/Documentation/devicetree/bindings/peci/peci-client.txt
>> new file mode 100644
>> index 000000000000..8e2bfd8532f6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-client.txt
>> @@ -0,0 +1,25 @@
>> +Generic device tree configuration for PECI clients.
>> +
>> +Required properties:
>> +- compatible : Should contain target device specific definition strings that can
>> +	       match a client driver implementation.
> 
> Bindings are for h/w, not client drivers.
> 
> How are PECI devices defined?
> 

Got it. I'll correct the description. PECI client device is Intel CPU 
which is connected through a PECI bus.

>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients is starting from 0x30 based on PECI specification.
>> +	       <0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
> 
> 8 devices should be enough for anyone...
> 
> Where is PECI_OFFSET_MAX defined?
> 

PECI_OFFSET_MAX is defined in include/linux/peci.h based on the maximum 
CPU numbers of the current IA generation. I'll remove the unnecessary 
details. A setting out of range would be handled accordingly in kernel.

>> +
>> +Example:
>> +	peci-bus@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		< more properties >
>> +
>> +		function@cpu0 {
> 
> Not a valid node name. "function@30" is what it probably should be. For
> a new bus you can define unit-address format you like, but it must be
> based on the contents of reg. However, it doesn't look like you should
> create anything special here.
> 

Got it. I'll fix these node name like function@30 and function@31.

Thanks a lot for your comments!

-Jae

>> +			compatible = "device,function";
>> +			reg = <0x30>;
>> +		};
>> +
>> +		function@cpu1 {
>> +			compatible = "device,function";
>> +			reg = <0x31>;
>> +		};
>> +	};
>> -- 
>> 2.16.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
