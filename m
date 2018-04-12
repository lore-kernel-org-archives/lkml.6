Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx48lRs4UdGTuz7Tq2967D1K7lmwrLAYwZXlt6SS60XTDdUU1zVXp0E9sIHxvW+l/wuowLydm
ARC-Seal: i=1; a=rsa-sha256; t=1523499085; cv=none;
        d=google.com; s=arc-20160816;
        b=YCVWELsTHq9WEs2Kq2PhuqGhTuNoYke6DMeuMIjTA2vztvn+B7g0w8o+jPQjC7Vsx7
         DDkiFeIhUMoUUugTiD1CgGQEBX+Kfm4xJUs+DZgEaOhyDr8KQFsX07oaqybzvo8I3c7o
         24w6xL/o8o1G4Ah3SN3ZdKtITJP/NQr1089asOaV5LOrjOjEshU8EV+FohQFcWXEDnBZ
         tF21dsDm3VphWo9O5zgGjpT8d/2QHlsh3Z/FNQSrQYZeW8bJBS/hxS58Vfb9l/KViEDa
         tePKBn9+7Ojr9Zvue2CW4dgTan2Y+PvwLdhEw/csv+BJSGWm95fQAYfxpoKPZBUZTpL7
         fofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RCyTibAiNEbMderCZGDX4vswyAYaAwCdh7DY8Y4TKdw=;
        b=skGq7WYbcdV2Fam+A3mqQu3tjTrfw4zutJaGRmFLqSIifVZxubMY1Y3VeFP9gfWuEz
         sY7vPIvBHLn/FVWhwokQsWhd4ZUssGROMYWI9f0igNCofaJziyUPLm9WeMyOf8un7QQO
         HeFtNdqM5MPJIYMKl0h4nCLEKbI42Ij/XTYGW4VeC78/uV3CYrzsqk+u8QTF7oOl3n9X
         IsOX+XGTqMWR2z5oDVmzMG41Gtmh+DBG7tnIDhW82y5G68Z3+uDA30y4dR6HaOwvtCok
         6W9q7mp8UPOYnMnFFEFtokCdg3xJJrxc5dxBeBRyRRU6lwHiO6G8gUqIKFH+OTJAMnwc
         6G2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,439,1517904000";
   d="scan'208";a="36571536"
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
 linux-aspeed@lists.ozlabs.org, Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Haiyue Wang
 <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, Linux ARM
 <linux-arm-kernel@lists.infradead.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
 <CACPK8XcfrheC+UDB7mLPkgPRCuk8f+P830NG+cy2v6F_PJvUTw@mail.gmail.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <2c5f7636-169c-f58f-1c45-2e9950be72f3@linux.intel.com>
Date: Wed, 11 Apr 2018 19:11:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XcfrheC+UDB7mLPkgPRCuk8f+P830NG+cy2v6F_PJvUTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1597504576885448832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Joel,

On 4/11/2018 4:52 AM, Joel Stanley wrote:
> On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
> 
> We try to capitalise ASPEED.
> 

Got it. Will capitalize all Aspeed words.

>> AST24xx/25xx SoCs.
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
>> +                     - aspeed,ast2400-peci: Aspeed AST2400 family PECI
>> +                                            controller
>> +                     - aspeed,ast2500-peci: Aspeed AST2500 family PECI
>> +                                            controller
>> +- reg               : Should contain PECI controller registers location and
>> +                     length.
>> +- #address-cells    : Should be <1>.
>> +- #size-cells       : Should be <0>.
>> +- interrupts        : Should contain PECI controller interrupt.
>> +- clocks            : Should contain clock source for PECI controller.
>> +                     Should reference clkin.
> 
> Are you sure that this is driven by clkin? Most peripherals on the
> Aspeed are attached to the apb, so should reference that clock.
> 

According to the datasheet, PECI controller module is attached to apb 
but its clock source is the 24MHz external clock.

>> +- clock_frequency   : Should contain the operation frequency of PECI controller
>> +                     in units of Hz.
>> +                     187500 ~ 24000000
> 
> Can you explain why you need both the parent clock and this frequency
> to be specified?
> 

Based on this setting, driver code makes clock divisor value to set 
operation clock of PECI controller which is adjustable.

>> +
>> +Optional properties:
>> +- msg-timing-nego   : Message timing negotiation period. This value will
> 
> Perhaps msg-timing-period? Or just msg-timing?
> 

Will use msg-timing instead.

>> +                     determine the period of message timing negotiation to be
>> +                     issued by PECI controller. The unit of the programmed
>> +                     value is four times of PECI clock period.
>> +                     0 ~ 255 (default: 1)
>> +- addr-timing-nego  : Address timing negotiation period. This value will
>> +                     determine the period of address timing negotiation to be
>> +                     issued by PECI controller. The unit of the programmed
>> +                     value is four times of PECI clock period.
>> +                     0 ~ 255 (default: 1)
>> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
>> +                     time will be divided into 16 time frames. This value will
>> +                     determine the time frame in which the controller will
>> +                     sample PECI signal for data read back. Usually in the
>> +                     middle of a bit time is the best.
>> +                     0 ~ 15 (default: 8)
>> +- cmd_timeout_ms    : Command timeout in units of ms.
>> +                     1 ~ 60000 (default: 1000)
>> +
>> +Example:
>> +       peci: peci@1e78b000 {
>> +               compatible = "simple-bus";
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges = <0x0 0x1e78b000 0x60>;
>> +
>> +               peci0: peci-bus@0 {
>> +                       compatible = "aspeed,ast2500-peci";
>> +                       reg = <0x0 0x60>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       interrupts = <15>;
>> +                       clocks = <&clk_clkin>;
>> +                       clock-frequency = <24000000>;
>> +                       msg-timing-nego = <1>;
>> +                       addr-timing-nego = <1>;
>> +                       rd-sampling-point = <8>;
>> +                       cmd-timeout-ms = <1000>;
>> +               };
>> +       };
>> --
>> 2.16.2
>>
