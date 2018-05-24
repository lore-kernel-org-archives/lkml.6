Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034143AbeEXRJc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:09:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:61100 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034127AbeEXRJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:09:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="43655546"
Subject: Re: [v4 07/11] dt-bindings: hwmon: Add documents for PECI hwmon
 client drivers
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
References: <20180521195905.27983-1-jae.hyun.yoo@linux.intel.com>
 <20180522164230.GA11707@rob-hp-laptop>
 <a05b44a2-ecc8-b028-4308-47d88523a6f1@linux.intel.com>
 <CAL_JsqJ8rjRzaqasjbdq-jkYfWxdo72YnmKAVNxDwo6wtyv1xg@mail.gmail.com>
 <51752610-d2c1-7fbc-101e-e99346fa29e4@linux.intel.com>
 <CAL_JsqK9ap=p67HDb_aka809nvpzL3K9VOdbMKJbf3EMR8D2XQ@mail.gmail.com>
 <22bd0e23-69ad-5858-656e-16c77007913c@linux.intel.com>
 <8b56c103-fdab-fc98-f4d8-9bf435a9b59b@linux.intel.com>
 <CAL_JsqK0HRi1meN=Y8jxRHrvrBwH_bZj3WVcYwy9MS0ZBJt0gw@mail.gmail.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <b8b393f7-c23c-0b20-289c-8fd07bd759dc@linux.intel.com>
Date: Thu, 24 May 2018 10:09:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK0HRi1meN=Y8jxRHrvrBwH_bZj3WVcYwy9MS0ZBJt0gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/2018 6:47 AM, Rob Herring wrote:
> On Wed, May 23, 2018 at 4:56 PM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> On 5/23/2018 1:03 PM, Jae Hyun Yoo wrote:
>>>
>>> On 5/23/2018 12:33 PM, Rob Herring wrote:
>>>>
>>>> On Wed, May 23, 2018 at 11:37 AM, Jae Hyun Yoo
>>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>>
>>>>> On 5/23/2018 8:11 AM, Rob Herring wrote:
>>>>>>
>>>>>>
>>>>>> On Tue, May 22, 2018 at 12:18 PM, Jae Hyun Yoo
>>>>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 5/22/2018 9:42 AM, Rob Herring wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Mon, May 21, 2018 at 12:59:05PM -0700, Jae Hyun Yoo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This commit adds dt-bindings documents for PECI hwmon client
>>>>>>>>> drivers.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>>>>>>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>>>>>>>>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>>>>>>>>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>>>>>>>>> Cc: Andrew Jeffery <andrew@aj.id.au>
>>>>>>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>>>>>>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>>>>>>>>> Cc: Joel Stanley <joel@jms.id.au>
>>>>>>>>> ---
>>>>>>>>>      .../bindings/hwmon/peci-cputemp.txt           | 23
>>>>>>>>> ++++++++++++++++++
>>>>>>>>>      .../bindings/hwmon/peci-dimmtemp.txt          | 24
>>>>>>>>> +++++++++++++++++++
>>>>>>>>>      2 files changed, 47 insertions(+)
>>>>>>>>>      create mode 100644
>>>>>>>>> Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>>>>>>>>>      create mode 100644
>>>>>>>>> Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>>>>>>>>> b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..2f59aee12d9e
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>>>>>>>>> @@ -0,0 +1,23 @@
>>>>>>>>> +Bindings for Intel PECI (Platform Environment Control Interface)
>>>>>>>>> cputemp
>>>>>>>>> driver.
>>>>>>>>> +
>>>>>>>>> +Required properties:
>>>>>>>>> +- compatible : Should be "intel,peci-cputemp".
>>>>>>>>> +- reg        : Should contain address of a client CPU. Address
>>>>>>>>> range
>>>>>>>>> of
>>>>>>>>> CPU
>>>>>>>>> +              clients is starting from 0x30 based on PECI
>>>>>>>>> specification.
>>>>>>>>> +
>>>>>>>>> +Example:
>>>>>>>>> +       peci-bus@0 {
>>>>>>>>> +               #address-cells = <1>;
>>>>>>>>> +               #size-cells = <0>;
>>>>>>>>> +               < more properties >
>>>>>>>>> +
>>>>>>>>> +               peci-cputemp@30 {
>>>>>>>>> +                       compatible = "intel,peci-cputemp";
>>>>>>>>> +                       reg = <0x30>;
>>>>>>>>> +               };
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>> +               peci-dimmtemp@30 {
>>>>>>>>> +                       compatible = "intel,peci-dimmtemp";
>>>>>>>>> +                       reg = <0x30>;
>>>>>>>>> +               };
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> As I said in the prior version, 2 nodes at the same address is wrong.
>>>>>>>>
>>>>>>>> Rob
>>>>>>>>
>>>>>>>
>>>>>>> In PECI bus, there is one and only bus host (adapter) and multiple
>>>>>>> clients on a PECI bus, and PECI spec doesn't allow multiple
>>>>>>> originators
>>>>>>> so only the host device can originate message.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Yes, I get that. A single host still has to address slave devices.
>>>>>>
>>>>>>> In this implementation,
>>>>>>> all message transactions on a bus from client driver modules and user
>>>>>>> space will be serialized well in the PECI core bus driver so bus
>>>>>>> occupation and traffic arbitration will be managed well in the PECI
>>>>>>> core
>>>>>>> bus driver even in case of a bus has 2 client drivers at the same
>>>>>>> address. I'm sure that this implementation doesn't make that kind of
>>>>>>> problem to OS.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Multiple clients to a single device is common, but that is a software
>>>>>> problem and doesn't belong in DT.
>>>>>>
>>>>>> I don't think there is a single other case in the kernel where
>>>>>> multiple drivers can bind to the same device at a given bus address.
>>>>>> That is why we have things like MFD. Though in this case, why can't
>>>>>> one hwmon driver register multiple hwmon devices (cpu and dimm temps)?
>>>>>>
>>>>>
>>>>> It was implemented as a single driver until v2 but dimm temps need
>>>>> delayed creation unlikely the cpu temps on hwmon subsystem because of
>>>>> memory training behavior of remote x86 cpus. Since hwmon doesn't allow
>>>>> incremental creation, I had to divide it into two, cputemp and dimmtemp,
>>>>> so that cputemp can be registered immediately when the remote x86 cpu
>>>>> turns on and dimmtemp can be registered by delayed creation. It is the
>>>>> reason why I had to make the two hwmon driver modules that sharing a
>>>>> single device address.
>>>>
>>>>
>>>> That all sounds like kernel problems to me. Stop designing your DT
>>>> binding around what the kernel can or can't *currently* support.
>>>>
>>>>> Additionally, PECI isn't limited for temperature
>>>>> monitoring feature but it can be used for other functions such as
>>>>> platform management, cpu interface tuning and diagnostics and failure
>>>>> analysis, so in case of adding a new driver for the functions, we should
>>>>> add an another DT node which is sharing the same cpu address.
>>>>
>>>>
>>>> No, the driver should add support for those additional functions.
>>>> Perhaps you will need to use MFD.
>>>>
>>>
>>> Do you mean that the device address sharing is acceptable if I make
>>> these nodes under "simple-mfd"?
>>>
>>> Thanks,
>>>
>>> -Jae
>>
>>
>> Hi Rob,
>>
>> I'm planning to change the whole PECI node like below:
>>
>> peci: peci@1e78b000 {
>>          compatible = "simple-bus";
>>          #address-cells = <1>;
>>          #size-cells = <1>;
>>          ranges = <0x0 0x1e78b000 0x60>;
>>
>>          peci0: peci-bus@0 {
>>                  compatible = "aspeed,ast2500-peci";
>>                  reg = <0x0 0x60>;
>>                  #address-cells = <1>;
>>                  #size-cells = <0>;
>>                  interrupts = <15>;
>>                  clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
>>                  resets = <&syscon ASPEED_RESET_PECI>;
>>                  clock-frequency = <24000000>;
>>                  msg-timing = <1>;
>>                  addr-timing = <1>;
>>                  rd-sampling-point = <8>;
>>                  cmd-timeout-ms = <1000>;
>>                  status = "disabled";
>>
>>                  peci-client@30 {
>>                          compatible = "simple-mfd", "syscon";
> 
> These compatibles alone is not correct. There should be a specific
> compatible for the device.
> 
> Also, I don't think "syscon" even makes sense in this case.
> 

Got it. I'll change it like:

compatible = "intel,peci-client", "simple-mfd";

so that drivers could be instantiated altogether if the drivers use the
"intel,peci-client" compatible string.

>>                          reg = <0x30>;
>>
>>                          cputemp: cputemp {
>>                                  compatible = "intel,peci-cputemp";
>>                          };
> 
> There is no point in this node being in DT. It doesn't define any
> resources. All it does is provide you a convenient way to bind your
> driver, but that is not the purpose of DT. Put a specific compatible
> in the parent and its driver can instantiate whatever child devices it
> wants.
> 

My intention is making each driver can be selectively instantiated by
this node and it could use its parent reg resource which is in
simple-mfd node. If the selective instantiation is not needed, drivers
could use "intel,peci-client". Please correct me if it is still
unacceptable.

Thanks,

-Jae
