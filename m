Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AH8x22572iRShLJ1ohakhY9rMcOquyW+K66U2CoXdQw7OkIrq6IQ1q5CygyUtO4O/A/1+WPGIUFy
ARC-Seal: i=1; a=rsa-sha256; t=1517497918; cv=none;
        d=google.com; s=arc-20160816;
        b=hCKEaMClS5ef8iIWHf/L257mRw700xm3A3x2UVN9utJ0ojmu7dF0n6bmdO6An/by1y
         CSJSmtUntTpFl+0tGPPupzpga1v2DW30jrTJL5AROaCSC8OOiDrTP+RvUOGYzYXdxiqu
         Xh9huNP7sGZ3pXc+1AMj81zFOxR09ch/j7gZJKOqADp98F1qyKzQC2I859O4OsAUbYAZ
         fCnetKgeFPrCqwWsQdj4Nk3dcp+jw+Yne0E6xH2Kyan6S6ONIPXmXGoEOMcYqLLtjmzM
         mmamlTpJFXCc0ohlAKK+DWb55ct2cQG1loOS88ALtMA9JxbMrXqNbnehuYnUToDFICYi
         B4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=tfMek8CgqTs2jGNtEsMQ6PRyQR6dBSZc2WkqgwFPUKI=;
        b=oxsAIdmRI3FHYt0TAEh0v+P8yG7pNy5JX/6gfe4UIebxkgQm4p0nVJKB4XaFo2zQCD
         DDDdw5HJttEqBLUrtylqfoXUmnJwVpBjHPOu8zNybKB1jsPbWAiH613QHsbDD9XRlskK
         SSaKYGxv4yBhKZbrqptVvk2MGTnkOY/ECdAdQ1v2C+09J3/3P0kFI3nEeNgRiehwXSDq
         iCuflSO6whuXScEQbFMM9iNh1R/R+A6MTF10/3Jec82ZbVHhRA5m3aYXshrC/2lmtW1Z
         eVcWhi46WtUb0PWBrVS2HXPvwAtV3xA2p/l/4oL4N8ZtL2Mm5Ro+oJ4pU2QQWqX90VJY
         NMBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0EF217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <DM2PR0201MB07674CED433B7273AEFC50D2B8FB0@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com> <20180130170818.tz4hoqvyekrl7uio@rob-hp-laptop>
 <DM2PR0201MB07674CED433B7273AEFC50D2B8FB0@DM2PR0201MB0767.namprd02.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Feb 2018 09:11:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMfUyi06jMZOyQX956HjBvyHbKHEcBGt+GTZrj3Da5DA@mail.gmail.com>
Message-ID: <CAL_JsqJMfUyi06jMZOyQX956HjBvyHbKHEcBGt+GTZrj3Da5DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP firmware
To: Jolly Shah <JOLLYS@xilinx.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajan Vaja <RAJANV@xilinx.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517943929452186?=
X-GMAIL-MSGID: =?utf-8?q?1591211896841626068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 12:03 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> Hi Rob,
> Thanks for the review,
>
>> -----Original Message-----
>> From: Rob Herring [mailto:robh@kernel.org]
>> Sent: Tuesday, January 30, 2018 9:08 AM
>> To: Jolly Shah <JOLLYS@xilinx.com>
>> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
>> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
>> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
>> dmitry.torokhov@gmail.com; michal.simek@xilinx.com;
>> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
>> <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>
>> Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
>> firmware
>>
>> On Wed, Jan 24, 2018 at 03:21:11PM -0800, Jolly Shah wrote:
>> > Add documentation to describe Xilinx ZynqMP firmware driver bindings.
>> > Firmware driver provides an interface to firmware APIs. Interface APIs
>> > can be used by any driver to communicate to PMUFW (Platform Management
>> > Unit).
>> >
>> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
>> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
>> > ---
>> >  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16
>> ++++++++++++++++
>> >  1 file changed, 16 insertions(+)
>> >  create mode 100644
>> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware
>> > .txt
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
>> > re.txt
>> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
>> > re.txt
>> > new file mode 100644
>> > index 0000000..a7aaf56
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
>> > +++ rmware.txt
>> > @@ -0,0 +1,16 @@
>> > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
>> > +
>> > +The zynqmp-firmware node describes the interface to platform firmware.
>>
>> Please define this a is child of /firmware.
>>
> I dint get you. It is already under firmware/xilinx.

Put it under a "firmware" node in DT. See other firmware bindings for examples.

Rob
