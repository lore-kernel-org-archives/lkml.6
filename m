Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeEUVpb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:45:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60150 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932262AbeEUVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:45:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E5FB60AF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=girishm@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <20180503233849.GF13402@sirena.org.uk>
 <0c26e96c-85ad-c2a2-9abd-33096d76008b@codeaurora.org>
 <20180517072114.GS20254@sirena.org.uk>
From: "Mahadevan, Girish" <girishm@codeaurora.org>
Message-ID: <9e8c271f-6373-b0e3-ba74-8a776b09c1e1@codeaurora.org>
Date: Mon, 21 May 2018 15:45:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517072114.GS20254@sirena.org.uk>
Content-Type: multipart/mixed;
 boundary="------------4AA82E00345D0522ED52B860"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4AA82E00345D0522ED52B860
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Mark,

On 5/17/2018 1:21 AM, Mark Brown wrote:
> On Mon, May 07, 2018 at 02:29:45PM -0600, Mahadevan, Girish wrote:
>> On 5/3/2018 5:38 PM, Mark Brown wrote:
> 
>>> This is a DT based driver but there is no binding documentation.
>>> Binding documentation is required for any new DT stuff.
> 
>> The DT documentation for the SPI driver was done as part of this patch series
>> https://patchwork.kernel.org/patch/10318125/ 
> 
> I can't follow the link as I'm working offline but since I've no record
> of having seen a copy of any bindings for review and I'm fairly sure I'd
> have remembered any bindings without code I'm very disappointed -
> bindings should be being reviewed by the relevant maintainers just like
> code.
> 	
> Fortunately as far as I can tell whereever you sent that to it doesn't
> seem to have been applied but that makes it even more disappointing that
> they're not being sent.
> 

https://patchwork.kernel.org/patch/10318125/
[
Add device tree binding support for the QCOM GENI SE driver.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
]

is a patch train for Generic Interface (GENI) based Qualcomm Universal
Peripheral (QUP) wrapper. The wrapper can contain one or more mini cores
that can be used to implement different serial protocols (I2C/SPI/UART).
We'd submitted the DT bindings for that wrapper core and for UART/I2C
drivers which were part of that patch train; but there was a comment to
add the SPI binding document even without the SPI driver (attaching that
email thread).
I can resubmit the SPI binding documentation as part of this patch series.

Best Regards
Girish

> ...
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora
Forum, a Linux Foundation Collaborative Project.

--------------4AA82E00345D0522ED52B860
Content-Type: text/plain; charset=UTF-8;
 name="Fwd Re [PATCH v3 1_4] dt-bindings soc qcom Add device tree binding for
 GENI SE.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="Fwd  Re  [PATCH v3 1_4] dt-bindings  soc  qcom  Add device t";
 filename*1="ree binding for GENI SE.txt"


Subject:
Fwd: Re: [PATCH v3 1/4] dt-bindings: soc: qcom: Add device tree binding for GENI SE
From:
Karthik Ramasubramanian <kramasub@codeaurora.org>
Date:
5/21/2018 10:44 AM
To:
"Mahadevan, Girish" <girishm@codeaurora.org>




-------- Forwarded Message --------
Subject: Re: [PATCH v3 1/4] dt-bindings: soc: qcom: Add device tree
binding for GENI SE
Date: Tue, 6 Mar 2018 10:13:09 -0700
From: Karthik Ramasubramanian <kramasub@codeaurora.org>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Andy Gross
<andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Mark
Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Greg
Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
linux-arm-msm <linux-arm-msm@vger.kernel.org>,
devicetree@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
evgreen@chromium.org, acourbot@chromium.org, Sagar Dharia
<sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>



On 3/6/2018 6:22 AM, Rob Herring wrote:
> > On Mon, Mar 5, 2018 at 6:55 PM, Karthik Ramasubramanian
> > <kramasub@codeaurora.org> wrote:
>> >>
>> >>
>> >> On 3/5/2018 4:58 PM, Rob Herring wrote:
>>> >>>
>>> >>> On Tue, Feb 27, 2018 at 06:38:06PM -0700, Karthikeyan Ramasubramanian
>>> >>> wrote:
>>>> >>>>
>>>> >>>> Add device tree binding support for the QCOM GENI SE driver.
>>>> >>>>
>>>> >>>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>>>> >>>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>>>> >>>> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
>>>> >>>> ---
>>>> >>>>    .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  | 89
>>>> >>>> ++++++++++++++++++++++
>>>> >>>>    1 file changed, 89 insertions(+)
>>>> >>>>    create mode 100644
>>>> >>>> Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> >>>>
>>>> >>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> >>>> b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> >>>> new file mode 100644
>>>> >>>> index 0000000..fe6a0c0
>>>> >>>> --- /dev/null
>>>> >>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> >>>> @@ -0,0 +1,89 @@
>>>> >>>> +Qualcomm Technologies, Inc. GENI Serial Engine QUP Wrapper Controller
>>>> >>>> +
>>>> >>>> +Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP)
>>>> >>>> wrapper
>>>> >>>> +is a programmable module for supporting a wide range of serial
>>>> >>>> interfaces
>>>> >>>> +like UART, SPI, I2C, I3C, etc. A single QUP module can provide upto 8
>>>> >>>> Serial
>>>> >>>> +Interfaces, using its internal Serial Engines. The GENI Serial Engine
>>>> >>>> QUP
>>>> >>>> +Wrapper controller is modeled as a node with zero or more child nodes
>>>> >>>> each
>>>> >>>> +representing a serial engine.
>>>> >>>> +
>>>> >>>> +Required properties:
>>>> >>>> +- compatible:          Must be "qcom,geni-se-qup".
>>>> >>>> +- reg:                 Must contain QUP register address and length.
>>>> >>>> +- clock-names:         Must contain "m-ahb" and "s-ahb".
>>>> >>>> +- clocks:              AHB clocks needed by the device.
>>>> >>>> +
>>>> >>>> +Required properties if child node exists:
>>>> >>>> +- #address-cells:      Must be <1> for Serial Engine Address
>>>> >>>> +- #size-cells:                 Must be <1> for Serial Engine Address
>>>> >>>> Size
>>>> >>>> +- ranges:              Must be present
>>>> >>>> +
>>>> >>>> +Properties for children:
>>>> >>>> +
>>>> >>>> +A GENI based QUP wrapper controller node can contain 0 or more child
>>>> >>>> nodes
>>>> >>>> +representing serial devices.  These serial devices can be a QCOM UART,
>>>> >>>> I2C
>>>> >>>> +controller, spi controller, or some combination of aforementioned
>>>> >>>> devices.
>>> >>>
>>> >>>
>>> >>> s/spi/SPI/
>>> >>>
>>> >>> Where's the SPI binding?
>> >>
>> >> Since the patch series introduces UART and I2C drivers, I added the bindings
>> >> only for them. I thought about adding the SPI binding when the SPI
>> >> controller driver is introduced. Please let me know if you want me to add
>> >> the bindings for SPI in this patch series itself.
> > 
> > There's no requirement to have the driver and I prefer bindings be as
> > complete as possible.
Ok, I will add the bindings for SPI controller in the next posting.
> > 
> > Rob
> > 
Regards,
Karthik.
-- Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project


--------------4AA82E00345D0522ED52B860--
