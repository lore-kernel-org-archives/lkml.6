Return-Path: <matthias.bgg@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524229473; cv=none;
        d=google.com; s=arc-20160816;
        b=H2KvLCwz8d7Z6EbNmOZqlIqoQtF2QvPjHuHxUF22jDXDhaXJZWFWaymborxyQkuYX1
         WIyzSVb7LN3GcdxU0YrtHHowh2kQNk3oBukcKHd35DkvyuNwUNwJotV3Td6cgINIs1q2
         tsA85PpfDwiEVznGpA006gs3N1uZT37WdU4Xpry+b1IjnFxdQYRVPW1+gkvleVFIGGgP
         PvDNq0ozWNytMMObdbPreyLpEpgdli7Z+P2F0nvXLWVITLwvzA2a4jzZJOzTQassSIe3
         P2qHIXsGCCDUxPrWegCaI+tJBUC1Ifbt7n3PjpEuGBw5+h7oKRgw8k74mLES00ggu2l+
         IZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:references:cc:to:from
         :subject:dkim-signature:arc-authentication-results;
        bh=I8EYm6OQIPcmQ9oBp4Sjqe2eAOiHYr7HZfjkOa8l02Y=;
        b=k8aIk72A4XLgJQhtFs6DEN2J/qSkjV9N0ZR8fVC3ZuSenL8RJHab8jc2lkStLlQcA1
         AYoNG9F6Hrvuj0pYjxEg+ptR8I4h+boGs/bCHo0OKIj08oYACVFTi3PbsQ6jpeGdyYaO
         1UjBdSz/DXg1O2UB53/vtd2TEtlpD3DaTKcsnJoxBWv894XrBn1/7IpBRzxs0COZl18W
         03tRLq9pmthqlt2Q4jZ9Jrdybg9z3DFX46vJqd0qkeFz8FS1wUuTPUE9SjqwIeIvBxrJ
         ag6lASfaQaLtVJ9SaA5ze9Nst9iVqVv2GraZFP9cnS8owV2fIgwOD4j3BCzYMOK3EkAw
         GzIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GgBk5IuX;
       spf=pass (google.com: domain of matthias.bgg@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=matthias.bgg@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GgBk5IuX;
       spf=pass (google.com: domain of matthias.bgg@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=matthias.bgg@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/KzBJB/Gb/6ewV5QpLW/g7iVXFEhh8kwHUMUU4LokkOCPbatDpDIUG+ZxtNkygyp6x59s4uQ==
Subject: Re: [PATCH 4/8] clk: mediatek: mt2701-mm: switch to mfd device
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
 ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
 robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
 lee.jones@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org,
 mchehab@kernel.org, rdunlap@infradead.org, pi-cheng.chen@linaro.org,
 sean.wang@mediatek.com, linux-clk@vger.kernel.org, linux@armlinux.org.uk,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <mbrugger@suse.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
 <20171114214114.15793-5-mbrugger@suse.com>
 <20171115001705.GJ11955@codeaurora.org>
 <e41d07ff-5870-1ec5-18fc-d89538529a8f@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b00448fb-6e8c-1766-f9b7-2a8581ad075b@gmail.com>
Date: Fri, 20 Apr 2018 15:04:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e41d07ff-5870-1ec5-18fc-d89538529a8f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584079275756695759?=
X-GMAIL-MSGID: =?utf-8?q?1598270444505034331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/20/2018 03:00 PM, Matthias Brugger wrote:
> Hi Stephen,
> 
> On 11/15/2017 01:17 AM, Stephen Boyd wrote:
>> On 11/14, Matthias Brugger wrote:
>>> As the new mfd device is in place, switch probing
>>> for the MMSYS to support invocation from the mfd device.
>>>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>> ---
>>
>> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
>>
> 
> I did a minor change to this patch and patch 7/8 to get rid of mmsys_private
> variable. Nevertheless I kept your Acked-by, as it only changes how we get the
> device tree node.
> 
> Hope that's OK with you.
> 

Sorry, I didn't explain me. I'm talking about v2 of the series, which I'm
working on right now.

Regards,
Matthias
