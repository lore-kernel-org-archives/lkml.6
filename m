Return-Path: <tsoni@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoBVPSfWD90nVLpHsaJOTq2wY2AlX8eAZgDO5Tp9Ivt2S7bveoFHhy0IgUng+GdG2ExZWXv
ARC-Seal: i=1; a=rsa-sha256; t=1526676427; cv=none;
        d=google.com; s=arc-20160816;
        b=Clt7g1Ydx1axFwNgkdLr0EIWXxl+S/r2Z8Oi2Ne9InrBMak72eQFnFzZCsFFgskJ3L
         XwsropACNjdmv7MpV1LYXcQGlnCjBClyAZeJd7wWm0Qfkqxmm72Lj7k1HQpC1xp2z/1l
         3vQ6/qL2YShgCD3m3m25RW1LiGXlPqxGw1K6R5d+TistVnqViII3RiKQsHwbe+wkOXSr
         7qzofXBVgqvQ7uhhQsAI7hmonE8n/Bfxhk+Bv1jz5/74cZfHDDp4fPFrxeDH0oyX+CIz
         rPUUA++K7Z06sC0GV4Cqpg2aVte5yN8/31Te1hR1jEZJBMUfdLZvkWXxsf+WafMXU/Qa
         q4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=TnXNtUcbYIGp2btQzOlU9ZzgLj1rh79K0cNmKNLExmo=;
        b=wloGILK/HbXtgLz19ku7t3DLSms2mVLjajsMMEaEzHejKxPZeaF5P0w/Wyv9N7GWiy
         b23Ca0+dDBH+VFzSdd4VS+OSQGrUI29IbXSdH4uCCmAvpi2zqaL/cqyUWYaDh2IV2Bsb
         dIqqO0JP8A2Qi/u7vlpmqrQsY8+ELKKgwU4ZrNDO0Oayjf/as1N22TUDAMx8HMfTp55P
         79ah7YNSzSA+0UegnruFuANUOHuSPHcF12kdiO1n59ECtAD7V3hN1SPPmn62s7H1OzfC
         3VH5H2wnkblVWPe3H1o+3x3A+QNI1Xjn3Of9FN+frnHHygpgq28Jg5T28kuNQnXK1MDD
         XX5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e9rweFsR;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e9rweFsR;
       spf=pass (google.com: domain of tsoni@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=tsoni@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e9rweFsR;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=e9rweFsR;
       spf=pass (google.com: domain of tsoni@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=tsoni@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6E606085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc: kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, broonie@kernel.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
From: Trilok Soni <tsoni@codeaurora.org>
Message-ID: <802138cc-77cc-9800-f725-0ab8a9f0467e@codeaurora.org>
Date: Fri, 18 May 2018 13:47:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1600836261437536188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Srinivas

On 5/16/2018 9:51 AM, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm SLIMBus NGD controller found in
> all new SoCs starting from B family.

"X/Y/Z family" has no meaning here in upstream and just put the 
processor name from which you are adding the support or tested to start 
with.


-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
