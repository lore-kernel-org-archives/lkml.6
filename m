Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525853703; cv=none;
        d=google.com; s=arc-20160816;
        b=H3/lTjcdKingCZzxhimS7D3zZriZz66PiuEuPjpXhz8GtVdlK24P5mgkdGqo4j7t1A
         j0/z2yucn9juj2Czt4WAFTIlXvegoNe6n0MRZLGN2ztzEQXZImb/oT59IQA7Z1vlF1wJ
         wpqOOOdm6mSXKyOuoq3iJsMkxY10T6IAeWSowRuakZDorIdr5YCyyj14LyO+uJoEbKwl
         qjaMgfUhmHdEuhs7zBojGPqNWJ4CbqcpvFDM2YdYz0wZjblwaP0P0kE4obWVQK/Jq4H+
         Eaq9dG63jJU1enpISmNERD1ZjBPaeN8XxWDTgdz5APoSQi5R9vvZkHpHv8sFrgHFq7IA
         ksSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=0B1iEGm1jVPlPFeA9TGJIbnp5Ua2+gjg/s1RDskbxTs=;
        b=pQsv1g0P3m7Elzp+HbXVcty7ICVFkhlj7DAsGWRuXfP5uIWJtgnnf/+lOCYtQIY1JM
         MjU9ppmvTVJHMok+sElMw0byYwmxI+jU5BKjSQu5d/KX1OWwpM4oElqKOkma+LEwD0yg
         fcTGdHhm9uZ6RYjXkBu6QfYbPfWZbKYE7/kKOiQbhGp912IXCUYTfP/PtL2yRNapAOVV
         InkZosmiPTzVdMQqDpWdfms5HzpP9JveENa3DU4wDDtTg342p0Uu7VspRGJNHBcEtkVO
         HNjUwI9M6Y/EGftc52yih0Izfo0o7MyeFTkEFH+PoVvGlD9Jlr3LPUffqNHDvSo3aQ35
         9P4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D/96L4WH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D/96L4WH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqc05GtRNdTTQUUN9CmPBsycF91Q70lChJZxHq5pCPDhxggmzo70rWkTlH4yK4HnzgwYkiVig==
Subject: Re: [PATCH v7 14/24] ASoC: qdsp6: q6asm: Add q6asm driver
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-15-srinivas.kandagatla@linaro.org>
 <3e7601d4-0304-3aa1-66cc-617b99727567@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e6e8fdd0-b6a3-07fa-46d8-d75d6de4c173@linaro.org>
Date: Wed, 9 May 2018 09:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3e7601d4-0304-3aa1-66cc-617b99727567@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263625649235845?=
X-GMAIL-MSGID: =?utf-8?q?1599973573105833648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 09/05/18 09:10, Banajit Goswami wrote:
>>
> MAX_SESSIONS should be 8?
> 
Yep, will update it in v8.

thanks,
srini
> Otherwise LGTM.
> Once addressed about, add acked-by-
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
