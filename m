Return-Path: <cyndis@kapsi.fi>
X-Google-Smtp-Source: AIpwx4/5ZD2phKocOHZdSDWAoivO2vr0ZR7hwP58aMl7JxvSSmRi6czz5Tj8gZIpryyD+itOF6oj
ARC-Seal: i=1; a=rsa-sha256; t=1523252346; cv=none;
        d=google.com; s=arc-20160816;
        b=g7scsJyqPpj9AGGxuM+3QYodcdEqSUaEug/QPDdR0GVO0206Yzh2am8K2uI8GJxBk1
         Soh3+9raga/AwuN0+RibV9DsconPehPJR7EIQdqMXGBCIq1zcilntpeX38kmZT5cH7Sr
         2rQ4Lj8K9e0zF9kGizkM+k3bDYDrz0JCszqZVfYiNYfOx/QZNVNsspbtVVGJLaCyIWYL
         2x9u2VTQ070+17S9bKzgqSvOI5ml9MPmG5HExZapKgK3AZDF5doRq/at1493D6zP5lRf
         lbu9Y4as+56hz7EmkP+W33H1BCWlGm6wcStKKyP7lyLHiivQ9NVt/uSvnPA4aX0uUzbJ
         0Jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=8yhTcKZPGB1uk/tNL5TX+IRjD7LVZSJZVEF3A/bHi3A=;
        b=ALD3BXPgZ4lAAkUWT/rDb8/EceCWvAG5VviL5jQZZodH/Vsx3CLEZ8qZ8wDBUoC7lS
         ZGiTjveZl76fxq4xQaTiY53RTyXo59GyximU+pUtJhRgjbT6BwYuGorpDhwvVQ1YeM6+
         t6Tizr51Y4JJ8CGN6sWF1C52qHwp2V9zzHfOx4DuvWXTgB9sD4qgxnf51WHb2b/PvMVT
         7wXJAqkpJ1+h/E+bvNunPTSUwPGH7gBgJ2+7viblNbknvNYyhMTg05juOgH17mv09A8T
         OyJBjo5h6w3fwyYK7m1yZrMkDkKfNd0Sm7PdZqb426Eny4jv3v7rF6R2X7NurglBOccu
         PXKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kapsi.fi header.s=20161220 header.b=u67iKMU2;
       spf=pass (google.com: domain of cyndis@kapsi.fi designates 2001:67c:1be8::25 as permitted sender) smtp.mailfrom=cyndis@kapsi.fi
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kapsi.fi header.s=20161220 header.b=u67iKMU2;
       spf=pass (google.com: domain of cyndis@kapsi.fi designates 2001:67c:1be8::25 as permitted sender) smtp.mailfrom=cyndis@kapsi.fi
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
To: Rob Herring <robh@kernel.org>, Rajkumar Rampelli <rrajk@nvidia.com>
Cc: mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
 jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
 catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com,
 mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org,
 andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org,
 heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
Date: Mon, 9 Apr 2018 08:38:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.250.162.250
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520871004470026?=
X-GMAIL-MSGID: =?utf-8?q?1597245851984006036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rob,

this binding is for a specific IP block (for measuring/aggregating input 
pulses) on the Tegra186 SoC, so I don't think it fits into any generic 
binding.

Thanks,
Mikko

On 03/27/2018 05:52 PM, Rob Herring wrote:
> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>> Supply Device tree binding documentation for the NVIDIA
>> Tegra186 SoC's Tachometer Controller
>>
>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>> ---
>>
>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>      Renamed dt property values of clock-names and reset-names to "tachometer"
>>      from "tach"
> 
> Read my prior comments on v1.
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
