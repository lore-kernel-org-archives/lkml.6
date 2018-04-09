Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx48bXdQtsm2SHp+OhBjQLqDlhV6XglsE2uph52pSPv0x1M6FjwUF1z9+UNbhdJfx64vzRXxu
ARC-Seal: i=1; a=rsa-sha256; t=1523280100; cv=none;
        d=google.com; s=arc-20160816;
        b=lFWqt1fSEdv2HnyTxx1th9h9JQBwRxrI1IxqOPiAMfEOV2ln1wt52dFgOU4C5gU+hs
         UOhCrFQ4BLmahMinJr/yYoNrxDOaG4Okve0MfnYE2hy/ZZz3CZhnuxakt7AsJ9clX8RP
         WUpg3pHgQBi26Zx75h4hUfsSVKeaJssLPdPRjvTUZD5h6p8gYD2iRXro8S/SwPhGmRIR
         SmsTw9TciyHd1isPXpW51ExiqNc62K6pGNs+Mv7lDrQcu7LKqb5vuXEfadxX0csb2JZF
         SuOnZeZKAsnYgazP3Bz4QJTynkiFE9LnT29aqGxuPXmV156edEyDCnGxJqJMjxTFTEna
         h5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=mXZL5cw0VmGIlJds6KyvKj3Mvi6557jKhWcnIO2zj4g=;
        b=A03R2cKvAHkkPsg6lVT8O2pPPm4PIiNDU4Nd/gvkOwxv8J9dJpETb2YFMhQTDQrHOl
         O5Ga7flol9yNaMR5GGSg/KApEXVT2pKr1UuBAIx+CeK7a3aEP21RMGfbdFzLzbrwa/l3
         qsm7FGnt0ZGY5MkslZHCdLvBCDAD9SlO//T0sAcMuUyz77JbgCtYoSQW1RFOdsx1kwND
         toMQR8H72AlEbID/gJjjTFqJVd9KcwD3QvXMEDgzt9AupR+MyxsRRjZHblsihvkKmNQ9
         w0YKeuUahLqJJwgsUsxa+vK6O1suHAdfV+MNwYkWJ/nnnx3ok14rgkgE1Bf7KxUH7Jew
         +tjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830C42183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com> <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
 <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
From: Rob Herring <robh@kernel.org>
Date: Mon, 9 Apr 2018 08:21:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
Message-ID: <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree bindings
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Rajkumar Rampelli <rrajk@nvidia.com>, Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>, Alex Elder <elder@linaro.org>,
	"heiko@sntech.de" <heiko@sntech.de>, Krzysztof Kozlowski <krzk@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>,
	linux-tegra@vger.kernel.org, Linux HWMON List <linux-hwmon@vger.kernel.org>,
	linux-doc@vger.kernel.org,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1597274954204032224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 12:38 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> Rob,

Please don't top post to lists.

> this binding is for a specific IP block (for measuring/aggregating input
> pulses) on the Tegra186 SoC, so I don't think it fits into any generic
> binding.

What is it hooked up to to measure? You only mention "fan" five times
in the doc.

You have #pwm-cells too, so this block has PWM output as well? If not,
then where's the PWM for the fan control because there is no point in
having fan tach without some control mechanism.

There's only so many ways to control fans and types of fans, so yes,
the interface of control and feedback lines between a fan and its
controller should absolutely be generic.

Rob

>
> Thanks,
> Mikko
>
>
> On 03/27/2018 05:52 PM, Rob Herring wrote:
>>
>> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>>>
>>> Supply Device tree binding documentation for the NVIDIA
>>> Tegra186 SoC's Tachometer Controller
>>>
>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>> ---
>>>
>>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>>      Renamed dt property values of clock-names and reset-names to
>>> "tachometer"
>>>      from "tach"
>>
>>
>> Read my prior comments on v1.
>>
>> Rob
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
