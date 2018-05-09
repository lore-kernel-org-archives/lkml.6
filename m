Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZodEOGpWhgKsgfZrm4ODcayoogj2hM0rMhIpH15QZHMm98CAGzzMu2TlzzYQ03tWEhV93gI
ARC-Seal: i=1; a=rsa-sha256; t=1525855199; cv=none;
        d=google.com; s=arc-20160816;
        b=j3dOcWHnjxioJJ7q+hSyQROrUavmnu9dNejMIlBXDelrmujMLSgpUcWRjKCEtBkox+
         ECB03q7OzmjDKpRo5mx4VUb29EH8isNX+ZmmJZJehiY41VYoRTW+Sv60sxG8rlulthdc
         lcee4ixVKhhZm/1BNQley7B4xpk9NqaaUY8s0F98usrMyNb0tSaPxsIIEdee483kMqrP
         OqBfLCt2tKo+bsodzMra0eYzw2VEHY5pi5Av98Gb7gwzX8swxdTT2UpMUIbf2SAIuLc4
         tNAJsP0OgIpmiDdWzJCYNwN+3oZbly/V8RF4FtOTPS9K2DLGoPfd+XXAX/bGgwDhwN6E
         rLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=GmUjB+O99DCfyjV0vyvH7JjJA50ilMpzmqZfZ/k1jC8=;
        b=BbbsrFGXcACLuHhYkfYnWuB8UN6kqIi9Pu7MRsceULxjg+KDI5/V0Pz3vVFzGpiNA8
         yaQrj8Ol0hhsfcISDp2PLpr/xbgCMga4/HxkTG04cpp8G3rME44zGOjiEPOOKJVNH8X0
         +EzWCxTB0uOuOae+G8I+0xKzqBi7MKmnC0iBqXtRDu74Fq34yU8CcTJvYhzp5Q/KfBQ6
         z0cQAdyKcgTMLsMyzCDwEnBXRNr+0Mqhgw4l8f1pWQS4IlFYY7CPhlb8TCkhCLhZrqlB
         Mqg6RWGrFky2/eEDBDkNPovpDFsXdSkrE3kqwn0vW5aakt8m3eKAQn5Qq5lP4RECXO4W
         m3yw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=k9UXajL8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W3EJjn5C;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=k9UXajL8;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=W3EJjn5C;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEEA06044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 18/24] ASoC: qdsp6: q6routing: Add support to all
 SLIMBus Mixers
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-19-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <b40ae86f-de73-3432-131b-4efc4cee656a@codeaurora.org>
Date: Wed, 9 May 2018 01:39:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-19-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263631376354914?=
X-GMAIL-MSGID: =?utf-8?q?1599975141623743263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to SLIMBus related mixers to control mux between
> ASM stream and AFE port.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6routing.c | 261 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 261 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
