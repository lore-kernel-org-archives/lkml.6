Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrbp9UOPZIMo+sKKKsuocZpEtuQkTFQfxa9mM8QOvr8GhoERCcRLbdph7U181fxtgVJOAbD
ARC-Seal: i=1; a=rsa-sha256; t=1526370249; cv=none;
        d=google.com; s=arc-20160816;
        b=XUjAITAvHPNtD0XF20KLCRfmhCZfvGXbqwUb8oARPpG/D5xCgNHsOt2XY3TQbCGXFc
         PdTZJ+J20wQKB6uVIOZXw6JKl6lZ5hu+AqX0qJPNkGokn4upt8CH9mV8HKGwBcor/OC1
         rYhG1cboUli+xKAUYsEGBnURE6rTi0iE428qYY55bbCZYZBajZEGF549sQE5boss/oSW
         80LYXmDTDcB78URmjzI97a66C4nxh4VoZTub8nobMFZF9Gd3HV3AXLH+WKP6TSx5vGVX
         5xrSeZn6Zej0if0K2PtateSfdelbLC/6VguQi4zX9r123dtexcpgzh25hNMwXqTXG0cs
         bYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=6FeOXHPq/s1ubGI6pwcZ9HtisbyeCwLA3W3/B1G8sFs=;
        b=bBNMrJRbjlBEIRilDzqGx/mA52GlsPd67TdSbMvcJBcFMcUQ1R1mUP8QFLBxcrBZem
         Lizr5NF+QUqjtxWnFphHlua48a/dcVOGEB9DBi1eoOOaiL8wUdJA2n5Ef8Aou3/eiE9c
         CYnRBVvGYaluM1EXAbwR9mGWMKRRENsOT/JFjz6PWUkpKBv1MOtgg+3jZsQIqg7S++4V
         DPIaeGPpQOkVxIhdTMXri4n6j04FWwLrsAEyhD8pjbRR0OHZhhipQ5NPOngWNEY/ExAd
         sAEra5YcDOeY4qbgOesx5bGyvpMCCiqbbfD6WLeg9r3CeLlBImvsuFtDzBD6xklTFj+H
         Bntg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NdR9gIdI;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=drrW10iA;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NdR9gIdI;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=drrW10iA;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B79A660A00
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v8 08/24] ASoC: qdsp6: q6core: Add q6core driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-9-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <fa023436-fa6b-5ed1-85b2-8d144bd37afa@codeaurora.org>
Date: Tue, 15 May 2018 00:44:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509125635.5653-9-srinivas.kandagatla@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------81A9B949EA32259B24578391"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263616340654821?=
X-GMAIL-MSGID: =?utf-8?q?1600515210363526654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------81A9B949EA32259B24578391
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/9/2018 5:56 AM, Srinivas Kandagatla wrote:
> This patch adds support to core apr service, which is used to query
> status of other static and dynamic services on the dsp.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6core.c | 380 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6core.h |  15 ++
>   4 files changed, 400 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6core.h
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


--------------81A9B949EA32259B24578391
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <div class="moz-cite-prefix">On 5/9/2018 5:56 AM, Srinivas
      Kandagatla wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180509125635.5653-9-srinivas.kandagatla@linaro.org">
      <pre wrap="">This patch adds support to core apr service, which is used to query
status of other static and dynamic services on the dsp.

Signed-off-by: Srinivas Kandagatla <a class="moz-txt-link-rfc2396E" href="mailto:srinivas.kandagatla@linaro.org">&lt;srinivas.kandagatla@linaro.org&gt;</a>
Reviewed-and-tested-by: Rohit kumar <a class="moz-txt-link-rfc2396E" href="mailto:rohitkr@codeaurora.org">&lt;rohitkr@codeaurora.org&gt;</a>
---
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6core.c | 380 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6core.h |  15 ++
 4 files changed, 400 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h
</pre>
    </blockquote>
    Acked-by: Banajit Goswami <a class="moz-txt-link-rfc2396E"
      href="mailto:bgoswami@codeaurora.org">&lt;bgoswami@codeaurora.org&gt;</a>
    <pre class="moz-signature" cols="72">-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project</pre>
  </body>
</html>

--------------81A9B949EA32259B24578391--
