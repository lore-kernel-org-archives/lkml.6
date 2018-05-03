Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrgKeHR6U9sWCImLTucb1FLhkms1QyoDK+2NGAZChLERjXDS4mJYwA55Xednt/nMOOIzcYd
ARC-Seal: i=1; a=rsa-sha256; t=1525391117; cv=none;
        d=google.com; s=arc-20160816;
        b=Jh6nxs5zLWIiGRiQoObOD5wKW6/kiRvjio5jp3bOF7jgFajIW9n4TG7rNV4j5qsO9p
         kAR7xSkJ68Pd9EkXWODWLtmwvwPPzqYZSaCQ+mAzLaEq5kBJ9bDIgVugmCP7NEzarBg3
         9jaox6j+ok74Yl6rrl7682vpvC5uHG+HGVSK8XbIE69uW+NXCgfOviOqWRpbRiS+xynd
         2N7/h32rYB3HJJfhL2IU80sahh3uR9H67eSy57oD7ApbYR9c0zhj4CR9L+ezLc1CiF69
         OeIOu7J5SIGi09uVVKbgGr0t9X9UaaAgp9FrAe/k949A5CeaPB1agIYGt9L69kiychBS
         secw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=P9NCS9/wni19xE7bQ5eJG1GQoPsOWkRyasS+YZg6NAo=;
        b=uyAnrbosIflctcUWEMWvpSEE/r1GOnEVj0r8gbmvLWl0dVyn6LazzDcvYRNAk7zfF2
         YO08uEaHeakfAUtpJ/Gi9fmaljOiS0koa9VFwdn7WsPaNtJBMv/G73f9nQtSTgvxDzy5
         KXDPZfhxR805uFfqhT3exTkG6EfGnMITbwglOcOWk62O4TJtDHXj43plJ8XwzWRdqBOc
         0of8o+dnp6Vp416uYc5jShrXpN/4EyIYjAqP2CXKtH6m/IncIEH7YdQBNtH0q0JJhRkx
         ERsagRwbAJGDeSvCUyckqCzTggq5FUgBXCdih/OxzlFAfakmuDbnZh8AHZ2CggGuEppO
         Dqgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GZwWXvB0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GZwWXvB0;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GZwWXvB0;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GZwWXvB0;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E9EF601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-4-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <88da0352-d5f9-8c02-9dbf-ec4667d66271@codeaurora.org>
Date: Thu, 3 May 2018 16:45:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263609248976088?=
X-GMAIL-MSGID: =?utf-8?q?1599488516069543705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/1/2018 5:07 AM, Srinivas Kandagatla wrote:
> This patch add DT bindings for Q6CORE DSP module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
> new file mode 100644
> index 000000000000..bd14e9a93490
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
> @@ -0,0 +1,21 @@
> +Qualcomm ADSP Core service binding
> +
> +Q6CORE is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
Correct "coommon" to "common". Otherwise looks good.
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
