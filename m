Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524585549; cv=none;
        d=google.com; s=arc-20160816;
        b=wCxvsEcvMu9GUqTIe13hhns6+t/UV87zMNGaIHqvz4mHP+vC7BUl36qkExHFTUV2VX
         mAnXGZD6XHzi50CTp353JKPuoihXgCOwQsyA/lZrCVzzBCXVyP/25UjX8xLbIG9iRCiZ
         Pypzu59LDk6fx6qUVYR3Ur1+r8ehDWyLi/Vm3tTOgd3/3uhmCnsXG4K1DNrOVQpj/kyn
         Ezq6ZOdBj5eUCE0zvlCQrK5pz6nWghgLuQRoT6YQjjl1qrfei/iIy8QWs8lg3hd58O6y
         Fu+MLcSwzqbEAFLKroS0xohexXtCijFz28CYtf+XxO1q1q8dwxm1NreTs/EEbcCz+cKy
         8o8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=otzdeQ7T4gObbqgBO6TfIwRtW9txuXIdejz9O2pUrlU=;
        b=OX7PPejiVlozkv8dZAcpZ/yYPQQnBmjZ/9PIahk1R3lcFe/260N1Q8MwMMy9QW/Zv4
         bma2eDnhlSqUuNFsy85v+olHInzGkSwO2gOnHaApCvrdeypreClJb5O3G/IuN+E7Tkmz
         LeUadL5/6fQoWuScAFZ5OvMz+mJyjKlr0P3xJVEktfaFHQEp8N9eEnwY5FDxEYEEbXrF
         u9pvCi4+33QEECCOPf3PFwvHwIOCMLslxNTZCi/tp7HRH+m5rWXraPqqgCvXdm9u1T2r
         bSeBQVC+XbOKUoPSJJ+fWPGRMVxDjSVKBjRL4rV5L0g+cldh/4RZPA9e9XWL0qcUaupc
         VdtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f4UzCVV8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=f4UzCVV8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/+FIlwc5jIxInAPNiHA2prw5C+xrroPBkYm412bZYkE0nwD6xyfVJyXYdNjEdhfHxRjU4Hdg==
Subject: Re: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
 plai@codeaurora.org, bgoswami@codeaurora.org, tiwai@suse.com,
 perex@perex.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
 <20180424155739.GC22073@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0cb15e17-7169-cfee-c444-d14743797ed3@linaro.org>
Date: Tue, 24 Apr 2018 16:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180424155739.GC22073@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098775422985978?=
X-GMAIL-MSGID: =?utf-8?q?1598643817371627017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 16:57, Mark Brown wrote:
> On Tue, Apr 24, 2018 at 10:52:26AM -0500, Rob Herring wrote:
>> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla@linaro.org wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
>>> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
>>> bus driver. This bus is used for communicating with DSP which provides
>>> audio and various other services to cpu.
> 
>> This should probably go under bindings/sound/ as it is at least mostly
>> sound related.
> 
> AIUI the same interface is used for other DSP functionality - they're
> upstreaming audio stuff right now but I believe there should be more to
> come.
> 
That's correct, this is not just for audio, APR is used for other dsp 
services too.

--srini
