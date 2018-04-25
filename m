Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbeDYAdR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 20:33:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45071 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDYAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 20:33:14 -0400
X-Google-Smtp-Source: AIpwx4+3+3rG07iQJU1FDeHZsz2QI/LlZdJz2F6b9vHxqAd6NKm3BIy3lM2F3jXm4+dEB16l+J18Iw==
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20180418222905.10414-1-robh@kernel.org>
 <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e7b7a2ce-9c5e-693b-34fc-db7a20e7b01b@gmail.com>
Date: Tue, 24 Apr 2018 17:33:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/18 18:28, Rob Herring wrote:
> On Fri, Apr 20, 2018 at 4:00 PM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Hi Rob,
>>
>> Thanks for the example.  It was a good starting tutorial of sorts for me
>> to understand the format a bit.
>>
>>
>> On 04/18/18 15:29, Rob Herring wrote:
>>> The current DT binding documentation format of freeform text is painful
>>> to write, review, validate and maintain.
>>>
>>> This is just an example of what a binding in the schema format looks
>>> like. It's using jsonschema vocabulary in a YAML encoded document. Using
>>> jsonschema gives us access to existing tooling. A YAML encoding gives us
>>> something easy to edit.
>>>
>>> This example is just the tip of the iceberg, but it the part most
>>> developers writing bindings will interact with. Backing all this up
>>> are meta-schema (to validate the binding schemas), some DT core schema,
>>> YAML encoded DT output with dtc, and a small number of python scripts to
>>> run validation. The gory details including how to run end-to-end
>>> validation can be found here:
>>>
>>> https://www.spinics.net/lists/devicetree-spec/msg00649.html
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> Cc list,
>>> You all review and/or write lots of binding documents. I'd like some feedback
>>> on the format.
>>>
>>> Thanks,
>>> Rob
>>>
>>>  .../devicetree/bindings/example-schema.yaml        | 149 +++++++++++++++++++++
>>>  1 file changed, 149 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/example-schema.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
>>> new file mode 100644
>>> index 000000000000..fe0a3bd1668e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/example-schema.yaml
>>
>> I'm guessing by the path name that this is in the Linux kernel source tree.
> 
> Yes, well, my kernel tree. Most of the work still lives here:
> 
> https://github.com/robherring/yaml-bindings/
> 
>>> @@ -0,0 +1,149 @@
>>> +# SPDX-License-Identifier: BSD-2-Clause
>>
>> If in the Linux kernel source tree, then allow gpl-v2 as a possible license.
> 
> Why? BSD is compatible. The license of the above repo is all BSD.

I said __if__ in the Linux kernel source tree.  As my other comments
indicated, I wasn't sure if this was intended to end up in the Linux
kernel source tree.  __If__ in the Linux kernel source tree then it
would be dual licensed, correct?  And thus the tag would reflect that?


> Of course there's all the existing docs which default to GPLv2 and
> we'll probably have to maintain that.
> 

< snip >
