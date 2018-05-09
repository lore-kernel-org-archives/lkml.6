Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqmtqvljCCSxcz+Dzlc37WZHCwHOLNcHomZEVqgMpquG3mGpU7dxGlwOTUdyG+G23qIo0Kq
ARC-Seal: i=1; a=rsa-sha256; t=1525856497; cv=none;
        d=google.com; s=arc-20160816;
        b=PL2UbldNHpj6Fj/BfmUrupiaCnWJas4lbypj3dxW/ug8h2n1eUfHopBdVklSem7Wvc
         oDIPyQYY8jZgvMmyZ8HtiUPlIvk96t7Pm8KczGQZo8/Aig5KnX0I4JVki2/aFHY5EEPW
         K/z+XcBNcNs8QJn7hZ9Xlpjho1K2SNxLD+jeXlWt+K4m6T6QyzZf2K+oCacSRSkGAhbr
         7mioAxJRt06GfTw3uMU8je7OoHq15zOVZPZAVKP7n4pgYr1l+69vmaayUL1izce8TwwW
         aXHBGfIutqi6pag9XeBVnlQf12IFat8gLM3UgLaXH6rGB8UOIClyKswYXfqg+Qnbbpoc
         Etng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=sN+z04IObj8zzmf4DABDSDufUQI1QudsGSuq5JkfmRQ=;
        b=UOdPrt3ZPVnhi+VPC8cAvN+fRrlApfkg+wXmN/8uc5boSpZnOrEZ+MQjxN0TmXI3ZP
         wJ59JxLSJexdYlZnPavFJ9WXDlMkNA5mfHekhDWq6orbJg6sVw+O64uJEqvB+eQ597az
         4+kx9V3A2uuDuakV/xuCyxrqsu1GWU7Ym5ak8HvhsdSvKPz11GnXGncvXghRmKnoQsjv
         Kwpu7sNvOCQ8Rj/OZ9wThNVhA6nYk0HN6VEslJt6xGMqEZXUPKWN1d2ikPlPhD99Bxgk
         V+adKZNDBuq5B1F6HqP3XTfuC90nh/5oUjBGPoEbdUipTd45YJk8RosAqZ0mm1VymWS3
         p5kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=if/mGQ/4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SX0nQYvC;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=if/mGQ/4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=SX0nQYvC;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4435E60386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 22/24] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-23-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <a33018c1-1ee8-da44-ae93-459abe12b049@codeaurora.org>
Date: Wed, 9 May 2018 02:01:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-23-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263637622824757?=
X-GMAIL-MSGID: =?utf-8?q?1599976502748273188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/sound/qcom,apq8096.txt     | 109 +++++++++++++++++++++
>   1 file changed, 109 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
