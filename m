Return-Path: <cyndis@kapsi.fi>
X-Google-Smtp-Source: AIpwx486rx+tkm0i2pD3/wTEBnZGc5iCWG79HWuBTg/6N2CnnBjvMWLAjqq8ZWgSqGIPT7UvBCPX
ARC-Seal: i=1; a=rsa-sha256; t=1523284659; cv=none;
        d=google.com; s=arc-20160816;
        b=Lpd9BpQNwIZg0qLFCtEMiyg9/I6X2Fj9VR6Cp5lbFORSB8p7u3C2NKJaEDsd61ps4Q
         DYiJSk3m4SFNanYOeICVxgp5XrG8CehH4SpDEvTdZU625fKi+YAmK/GblUEqiwVlrmG6
         mN8z5dRvHpUoD3ddnRbkE22ogxsxBz7CdXFsJN9hDwHF1ntnxNN2+rXi3iKJx3xT0L3d
         SY4vwDu3PUrdgFJj8GZZkRAovVuuVGn1DHtfEft6Q0q07itpU5OJfpbHWnLbJqS4sYFY
         MSakWGxssThw9QIw1DxOToRWY9YjETFiqi4sgJcrJH8zng68r9R4L0SCrxsoRCUL30Wz
         /Txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=NMaxRHY8mimO2b5+A9G07u8SAaX7jgBFb7MWx26KDfM=;
        b=H/3yvp3SQdsA+RrSohBpuypR/7UiJxrGye8qNXGo05220JFVvdHktVS3WFe4vU1Scx
         BpGLngnvJYoxUp2Jt+mUakmIjZY3YlOy8hae0giMVNQ6cMSIV5poSNYOksp1NmudR3n3
         NWEGcL8UKI/qFYeufcBGQZE6kZmEydj4TJC7HuyT580KSdi3v/g3GEpgulG/HJgwFSUe
         AMyRewpbutP9M4hzZcJG6DynIMocfAF+CGIbsUW+Gy/a+VWrGA/r6vU3ge5VqZi5GU6K
         WcloUofRGaighEszTENi9H48NPPO1AFBV0U+G7OA0oZwPjwrf0tGpIvQGezRtFMUjrQT
         r+/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kapsi.fi header.s=20161220 header.b=xXvSGQZe;
       spf=pass (google.com: domain of cyndis@kapsi.fi designates 2001:67c:1be8::25 as permitted sender) smtp.mailfrom=cyndis@kapsi.fi
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kapsi.fi header.s=20161220 header.b=xXvSGQZe;
       spf=pass (google.com: domain of cyndis@kapsi.fi designates 2001:67c:1be8::25 as permitted sender) smtp.mailfrom=cyndis@kapsi.fi
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
To: Rob Herring <robh@kernel.org>
Cc: Rajkumar Rampelli <rrajk@nvidia.com>, Mark Rutland
 <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Manikanta Maddireddy <mmaddireddy@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Timur Tabi <timur@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
 Wei Xu <xuwei5@hisilicon.com>, Alex Elder <elder@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux PWM List <linux-pwm@vger.kernel.org>, linux-tegra@vger.kernel.org,
 Linux HWMON List <linux-hwmon@vger.kernel.org>, linux-doc@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Laxman Dewangan <ldewangan@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
 <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
 <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <615d6771-00c3-a4a7-a99f-ec4f6e667c8f@kapsi.fi>
Date: Mon, 9 Apr 2018 17:37:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.250.162.250
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1597279735392695233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/09/2018 04:21 PM, Rob Herring wrote:
> On Mon, Apr 9, 2018 at 12:38 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>> Rob,
> 
> Please don't top post to lists.
> 
>> this binding is for a specific IP block (for measuring/aggregating input
>> pulses) on the Tegra186 SoC, so I don't think it fits into any generic
>> binding.
> 
> What is it hooked up to to measure? You only mention "fan" five times
> in the doc.

In practice, fans.

> 
> You have #pwm-cells too, so this block has PWM output as well? If not,
> then where's the PWM for the fan control because there is no point in
> having fan tach without some control mechanism.

It doesn't provide a PWM output. The (Linux) PWM framework provides 
functionality in both directions - control and capture. But if the 
device tree #pwm-cells/pwms properties are only for control, we may need 
to introduce a new #capture-pwm-cells/capture-pwms or similar.

The idea is that the generic fan node can then specify two pwms, one for 
control and one for capture, to enable e.g. closed-loop control (I'm not 
personally familiar with the usecase for this but I could imagine 
something like that). The control PWM can be something completely 
different, maybe not a PWM in the first place (e.g. some fixed voltage).

> 
> There's only so many ways to control fans and types of fans, so yes,
> the interface of control and feedback lines between a fan and its
> controller should absolutely be generic.

I'm not quite getting what you mean by this. Clearly we need a custom 
compatibility string for the tachometer as it's a different hardware 
block with different programming than others. Or are you complaining 
about the nvidia,pulse-per-rev/capture-window-len properties?

Thanks,
Mikko

> 
> Rob
> 
>>
>> Thanks,
>> Mikko
>>
>>
>> On 03/27/2018 05:52 PM, Rob Herring wrote:
>>>
>>> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>>>>
>>>> Supply Device tree binding documentation for the NVIDIA
>>>> Tegra186 SoC's Tachometer Controller
>>>>
>>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>>> ---
>>>>
>>>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>>>       Renamed dt property values of clock-names and reset-names to
>>>> "tachometer"
>>>>       from "tach"
>>>
>>>
>>> Read my prior comments on v1.
>>>
>>> Rob
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
