Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524672977; cv=none;
        d=google.com; s=arc-20160816;
        b=hiTbCdI5ewj04b6KWhOws8aP7QnD4I8uADotVvIBQzn/YY+hMtdddAPUWyn71D7iz6
         6GgHtOA84agD7B8G/J+KUA6PDiJV9gHgclzv7ESioRJXxikCAZ9x2MkV/CX7HLh8o9Lp
         aXIOnDYrpWr7sZj/BX9fvJFl2RPGh4jheYAs4dRr+2Nyyrh4LZtdWHmZ4qb0Eft1prvx
         T1Ffh6PjhDbIbcT0NuFCWnzRf3wXdfB1fvRX8Zi+zcjRBtslLLoKKuCt1pVXvQdLKwVt
         l9fOvPxQ0PV+mRuVjlRkjBJT5fvpykZq2eNEab0qSvpq6KUgMeb3LMh92mm+0jF6ftYd
         biSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=uiRup6Hjm66EM7Hel9nsdq305gDP8C+T2NKFtRGWhco=;
        b=VW+d4Q+igyLevp4CAcJDRPY1RJ27OPyPojofU1/zhGlK2+INg2wsbiigaSIyKp9iM7
         JzDSduhUDdwwPxskiCTcF0tzkVA4KulINHDpRE5NHHpNqBvQNX6Bd9/TRDC1G4XPHgz6
         2b4h6Y6gVIvQBVi1prDedUd9QYBR18FYe4gbwy1FywetcY2pj+DffqYSfNy0akWcQR5o
         /AfFMaD0gQM9kB+CfykafmDirC9U0t7nxZR+OnitQA42Sn1xjKzXYfw7JU5mQy3ntOmL
         oyiUJ8xIZhaKaXV7eJzt8hWf1xYW96bewjR7uBt9AP8Lhnov2mg1z8uwfWCvWkj2X/+T
         qgkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=No8NyMKM;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=No8NyMKM;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49emnrPFej5JmS3fjtDK7wAknMvAC5ZNsGv8qxRUbYmF1VBjxxLnq2iR3NTZcC2XMAauDmGDQ==
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
To: Rob Herring <robh@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
 <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d243f265-a567-e8c5-56b0-ebffe5104a55@linaro.org>
Date: Wed, 25 Apr 2018 17:16:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098804369863616?=
X-GMAIL-MSGID: =?utf-8?q?1598735491448151720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 25/04/18 16:04, Rob Herring wrote:
>> I can list the values for the HDMI playback use-case, but the list would
>> grow as we start adding wcd9335 codec support.
> If you don't have the values, then how does one validate a DT is correct?
> 
I can list all the sources and sinks wired on the board in next version.

> Honestly, a single property like this seems insufficient to describe
> audio routing.

This is how all the audio drivers do routing in DT, non DT is also 
pretty much inline with this.


--srini
> 
>>>> +
