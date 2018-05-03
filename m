Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZotaH+ORwvDI/OT9z0SDs1q25ePdynJkucQZi26SQnm2N0iRZAT+aQGyZT+anSXzusOWsbT
ARC-Seal: i=1; a=rsa-sha256; t=1525391772; cv=none;
        d=google.com; s=arc-20160816;
        b=ax+E5XiYmJC8tcqfBwxumOoNHikvghJH5I5RfzeXyRrX/mL/jzO4gdG9CNxQ2qdhYO
         YMz+zikBUvXGEehv/En0ksWkSGk6lMd5NySfd5GLkGK50ey+UT7889tyZzZvs5/pYm29
         O2DSBAKcHuYkKQWz3L3S+/JCDjpfGtZOHYQPycfPBlXBBAybf07dT8534c8fvygG/Hd/
         LsJUYEhcLm5aq6Qkq8PLxABgiPV1/40SO6naJFB1e0Ama8RYWuevkhwGA7EsQSOdvose
         WMNw2Rb/K33AYm2kFB7R60Lb/5fMjt666IvdWw1Y7JNyWxSxrB8PsFRkG1CZho0ta221
         lxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=95VngU6AEPg+OEfr0VokOgC53Rzu1NKnMMoaA5BVd6g=;
        b=KPLcdwTO+CERBtkeQmHSkYAzwySR/zjVc/7AsrGDjiDF2uumRA+uZtTYMEQUS6MB1M
         Cffl+EXOv7Auuvcz28wnGx2iU2hbu6Xwc0jXJHH1JH54L7UH5NQ/zieoFW8F3LS8zKM/
         ty5ONYoixhxhI7Er1FoxFBz+oldO+462AXrsE3fHB9PTEEc6EDpLK42g144+xJE4SCQG
         bzjhOUhWKkHpS+xLAbgZ0kxGI4q3yGdefb6HPIwcrqUs5myRumz89Nn6PQfjTyBOnYRS
         rQr8ItcBZhKTWsQZSJMPyxeYxyXpUYGmK/6jj7JL1EzNxtnEFn7mO1CvMC37ZBwVYYjo
         pwbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nb8NH7sA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nrt9u+Av;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nb8NH7sA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nrt9u+Av;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8407602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 06/24] ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-7-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <55933898-0472-ab5b-b7bb-56aea7ffc9c8@codeaurora.org>
Date: Thu, 3 May 2018 16:56:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263613605397312?=
X-GMAIL-MSGID: =?utf-8?q?1599489203873807032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch add DT bindings for ASM (Audio Stream Manager) DSP module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
>   include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
>   2 files changed, 55 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>   create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
