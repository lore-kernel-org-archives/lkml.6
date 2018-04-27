Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524856620; cv=none;
        d=google.com; s=arc-20160816;
        b=hVkDDOaNPGT7FPrUQSCn+yzErBAEBJ3/Hn4RvuaP5m6qA7slmv0XLwKEOlwg4YZGHY
         afGBMq/0blVAqRzP4vWjY7h4WutPTUAl7r7jdqsFnCGvPNQS9Z4htjEWkW15mlbIAF1M
         p6Ic5Uw29qSogZATSXYK5LFxTfC5R7jYlKLWrA0krS5iCEaHW90OcDFYPuttJGrTW26/
         Mklr2yydGryiVZ4+o2GPyLz1uE1lYqe6By0ACy+0juOp0CpAqvfZ4/AzIouPhzw5HcWm
         yP61AkrrVWiXG8KBlieh3/P2q2DLF84N6PG0ulp4PgYDD6lfowBptlojO82e9kOvjFUj
         9BOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=KJVxt9RqcdJvy6k0oLFd9t0zth/m+Po+PI5bQJWhzSI=;
        b=B05GADFrI89UDHDN4nUSBT4DPVKLrsnJn1tw4GsVXLwzvJrbSw6W/ItTODYDLkNL+a
         djnGelwRqxVRvunYDnHe+KreLihc6fK1P9dfO4sSzx/hxnvqmQMs1o3KA7FzV24ggOiM
         +R/c6MrgDgEQu8uEr26goXeX2FF7w2cCARBL13pHgmyw8S/mpSpE7jEhpIDrfMtenBmr
         oOLV4QgwW4lwoKanco/wp0akouCy9DY6I2ZZfRxYyg6AurRKd/DAmi/4Tmma9dZaRUrw
         MwBow3xS6SrwZ16WhzFDhVW8kmJN+oUTCbHxPVWtIBOD0uCoY74c+/c7VCl8a12zoymi
         LF2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ksehrvmw;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ksehrvmw;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZro3mpsSH7iPGkfEQgVj70d5ajToHdQnt/zRfJmz2F10NvfuKezcY5Xty10L7t8r5Ke3yc/3g==
Subject: Re: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
To: Rob Herring <robh@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
 <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
 <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
 <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <16204d76-c3f9-a185-6e1d-34d86dc40688@linaro.org>
Date: Fri, 27 Apr 2018 20:16:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801759184316258?=
X-GMAIL-MSGID: =?utf-8?q?1598928055462037034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 27/04/18 19:32, Rob Herring wrote:
>>>> +
>>>> += AFE DAIs (Digial Audio Interface)
>>>> +"dais" subnode of the AFE node represents dai specific configuration
>>>> +
>>>> +- #sound-dai-cells
>>>> +       Usage: required
>>>> +       Value type: <u32>
>>>> +       Definition: Must be 1
>>>> +
>>>> +- reg
>>>
>>> It's not clear here these are in a grandchild node.
>>>
>> Every afe port/dai has some board specifics, to allow that we need dai
>> specific child nodes.
> Yes, but what I mean is #sound-dai-cells is a property of the dais
> node, but reg and qcom,sd-lines are properties of child nodes under
> the dais node. It is evident in the example, but not without the
> example. >
> Also, anywhere with reg needs #address-cells and #size-cells in the parent node.
>
Yep, #address-cells and #size-cells are missing, Will add them along 
with some notes.

thanks,
srini




> Rob
