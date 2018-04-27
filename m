Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AB8JxZrddmUlUk6JqYRFglaamm/c/dRGZw+6tMxR7W6H5R6gpT6o1lRPn4P5/4237ZT1rYnNm15h
ARC-Seal: i=1; a=rsa-sha256; t=1524853955; cv=none;
        d=google.com; s=arc-20160816;
        b=AuyZkfD7xRMKuvSRX/91D9P0NlsiDa64VD7PcSV3v5FNahKj/hRuGzsZ+I7C0c+51H
         /uy+lW/3CxGLtx2zSm33znSCqeuHOEAeaT8UEW1qMz9PlzHmuWEbtMGxowaclOZMgVfb
         VccrBnUbrkgnVkIUuMiifc9Ea0UV3n/o54H6slwtmxb4J2H7oHtMSH+SThC0Fnm9CKw3
         7yy5RQSPYuEZRy7aeMc9Hf8eShyDdQCAllkbZ/Qu8fLZ7etpdTfFCCpDZGn7ubdFHNRe
         WR1tjt5VMDYfK7DyyHDHjQnrZ64W5mW0+Eso2vG/Cw950MegF/yVHLrA9+Ikk+lyfKqJ
         65kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=QXMdKTvikWk9QCZKlmadfecoUDFeSomQfNFsY5a+9UI=;
        b=hV8iAi0tz/6PE6jzEOSd4AsUh2Z5RBzDtjrgD6DjWXBam5r+9nyc/xqKdWfzukrgQS
         J7a3RhmvLbatRgK12KD9BzgqOnVgqZAG6ATrcVMV7NVOa6jglknM1gI5wldWfYdh0SvI
         xFI71SUPV/7A03DJCo9cTwcSCmpEjY+8zFcUT3D42zaqUV/Xm4LEWERd03dib+IaGsJ1
         +jKJqa1ARVtHtXiujEeGPkmgFf7rGNXu7IeCy2kVknlLBgj15mWZri6vyAkU1QavPZQg
         lApxursZFLg3TZOBg9a+bjPLxff4MyutEcs/O2Jjr7t05zLgK+wuoCmP0ow1VLZsL8Cp
         X+zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DE721909
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org> <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
 <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 27 Apr 2018 13:32:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
Message-ID: <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
Subject: Re: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
	Banajit Goswami <bgoswami@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801759184316258?=
X-GMAIL-MSGID: =?utf-8?q?1598925261751529521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 9:58 AM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Thanks for the review.
>
>
> On 27/04/18 15:13, Rob Herring wrote:
>>
>> On Thu, Apr 26, 2018 at 10:45:46AM +0100, srinivas.kandagatla@linaro.org
>> wrote:
>>>
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> This patch add DT bindings for AFE (Audio Frontend) DSP module.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>>> ---
>>>   .../devicetree/bindings/sound/qcom,q6afe.txt       | 88
>>> ++++++++++++++++++++++
>>>   include/dt-bindings/sound/qcom,q6afe.h             | 31 ++++++++
>>>   2 files changed, 119 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>>>   create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>>> b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>>> new file mode 100644
>>> index 000000000000..05208a63dd3c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>>> @@ -0,0 +1,88 @@
>>> +Qualcomm Audio Front End (Q6AFE) binding
>>> +
>>> +AFE is one of the APR audio service on Q6DSP
>>> +Please refer to qcom,apr.txt for details of the common apr service
>>> bindings
>>> +used by all apr services.
>>> +
>>> +- but must contain the following property:
>>> +
>>> +- compatible:
>>> +       Usage: required
>>> +       Value type: <stringlist>
>>> +       Definition: must be "qcom,q6afe-v<MAJOR-NUMBER>.<MINOR-NUMBER>"
>>> +                 Or "qcom,q6afe" where the version number can be queried
>>> +                 from DSP.
>>> +                 example "qcom,q6afe"
>>
>>
>> reg too.
>
>
> I did not want to repeat what is already mandated for apr children in
> qcom,apr.txt
> So skipped repeating reg property in here.

Okay.

>>> +
>>> += AFE DAIs (Digial Audio Interface)
>>> +"dais" subnode of the AFE node represents dai specific configuration
>>> +
>>> +- #sound-dai-cells
>>> +       Usage: required
>>> +       Value type: <u32>
>>> +       Definition: Must be 1
>>> +
>>> +- reg
>>
>>
>> It's not clear here these are in a grandchild node.
>>
> Every afe port/dai has some board specifics, to allow that we need dai
> specific child nodes.

Yes, but what I mean is #sound-dai-cells is a property of the dais
node, but reg and qcom,sd-lines are properties of child nodes under
the dais node. It is evident in the example, but not without the
example.

Also, anywhere with reg needs #address-cells and #size-cells in the parent node.

Rob
