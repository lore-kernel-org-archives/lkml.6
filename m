Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZq8n9RV9IasHn1e3elo1DkwWdIGrYp223zW6rr1J0J5hhMaW4Ay/IxcmNzOTUA7wmYnuuW3
ARC-Seal: i=1; a=rsa-sha256; t=1525391450; cv=none;
        d=google.com; s=arc-20160816;
        b=YUiCRW2NY5OWn9TR7GO3XosUzZ2R2mt8TX/w853+p2HdA4hkwm1++pAY7e2Ta9Fwyo
         s4Z2MbSefaPSHzcWlkOL+Fxh5Wf85/ZZ2tH5cfR7n5v3Tx2D+OLmnxD2D6OfX7jYWLsc
         cSxaf57ALT+dbNgt7OtGLa4JQxKBrz/G5T5KMAjqBkqKf5BylhXijWEk6eFu+LaF2vqY
         ff6jAT00CQv75vjrCHmXBCf6wDUmiY4E3OE+N3AtmUnKL4NwW2FCJ3z7gW/aMcrX9YhX
         8f+YYhrEja7/FyBJVDepgfFXIRTVM/w3jisqiIUzmu6gy0PzaztLeGJW9PD72HhbUWhI
         M7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=E09oDTa3aeaZMEtPa12/xqctDLmwNzeyIouS47rK/3w=;
        b=iY04JcruIOFkkOvLRChJUrrM9qBUMpkTwuARUkzoRhYp2KQ7biJ6F0RTYLrkvAx+uz
         Oly6Xwh4J6Q+4AVlph6RZDhhHtiTSFYW41VrR9Iiwuf/BaKzpFVMTyJkkUpzLojx91eD
         lVjGthi0CmcqGv1m8DXLqLk1Ii4MnCmAO8FtJMHm5GvOEaYhtYZx5Nwpavd6nrspqP/p
         VV/dOHHMDTPmXR1ns5exZcKkuHY+t6yLN0RI/zQWJ6Od24nireU0vvlWK8bT5thsyjSw
         7z54FcfvU7ySdDGs/ysIG4H7VXzVqzoRHVyFPo2zzjZK7zLUoxgIIaqqlXWLs/T3AepD
         gTUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DysU/35l;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FlCHGAGp;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DysU/35l;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FlCHGAGp;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C16860310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <f84b5c02-69d4-9ad0-2624-49ca98595d27@codeaurora.org>
Date: Thu, 3 May 2018 16:50:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263610947296611?=
X-GMAIL-MSGID: =?utf-8?q?1599488865583362054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6afe.txt       | 104 +++++++++++++++++++++
>   include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
>   2 files changed, 135 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>   create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
