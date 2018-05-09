Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZp72dh8l3VQZywNQNZUpDFjJecJeGm9dId295NJP4DOQ0P+iyVfNxFx1Z7G9ZIDPT8k1izg
ARC-Seal: i=1; a=rsa-sha256; t=1525857377; cv=none;
        d=google.com; s=arc-20160816;
        b=y1FTyYA5wA5Et9pdfTNJ+U5rEiVUdP17fBOno7O/JeI2R3+bWTMoLJDxRLSXFHB6XO
         Zw8lLIeBeouqy+iHuCosiYSswkInHTMKhIXZrWWbuw7p0qPYPSN93MSmDjJJnRjuPUKc
         8lg3x5SCTisslDREEb2/jvRryaFGIT4OvSxMTprsdlH31WpCqWbsR7wxrc16jJyOA+Ui
         YXnvfQGhaBuZJQDGWVtfJ36vvxfaba57tOSkaR35bv9AU4yj4c3qnkyIHL6EXsplwn5U
         jkzu5zYJkNqU26MVjqya2qkdmCrdZ7GX9jdJ9/gAyc9jvG+WniVJWCYxypW5c+Y+hf8G
         HI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/zVdNAZorZgUdks/G/9JoKZwXKYBdalwTs49i/tKxxM=;
        b=F6rtB/GdCa0oB6CyGK6QieT+BnTMYlSpZ/HV4xCucE1YXa/LQtFHC0GnhjJYSy/o3L
         GubKxGOW4fpm4ijNuKVA22tFjrcQgiKDXWs77Wli2/W+8Bv+QEcy57O7dj9FtnNIQP3x
         Y63EJe0bo5oJWITUvTWOHfUWB9t+UD3gNZpJP1yWeJPzWBpWVwPnlsMbC8HMbJLnvy3s
         2uDNFhSDiVr0dVVowZU4Z4YnCnK/7YcncWkeuO4VOoCyuT/Xxgfq98INjtRYG8x0lTV/
         68IWt5kdlWaWMeVb92As2vxF4hbTYtADqGMZDLUQm+rWj9xlcbF8aiBK7iKNula35T+P
         cTfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Zc/W6Y/4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J74g+TPj;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Zc/W6Y/4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=J74g+TPj;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 814EB606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 24/24] MAINTAINERS: Add myself as co-maintainer of qcom
 audio
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-25-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <97fcf766-3834-3306-9a7f-b3fe476d89b4@codeaurora.org>
Date: Wed, 9 May 2018 02:16:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-25-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263640035546137?=
X-GMAIL-MSGID: =?utf-8?q?1599977425857308358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> Add myself as co-maintainer of qcom audio drivers
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4340b783ab80..527e2658cfe4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11531,6 +11531,7 @@ F:	drivers/crypto/qat/
>   QCOM AUDIO (ASoC) DRIVERS
>   M:	Patrick Lai <plai@codeaurora.org>
>   M:	Banajit Goswami <bgoswami@codeaurora.org>
> +M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>   S:	Supported
>   F:	sound/soc/qcom/
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
