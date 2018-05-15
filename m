Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqzlWlrHDzTA1BhZfWXakguUI8gw18k8mNY3R/qlWZ8sdMuDXDcEp9VnYCvosrsh2nwwTGB
ARC-Seal: i=1; a=rsa-sha256; t=1526371231; cv=none;
        d=google.com; s=arc-20160816;
        b=WyfFXASLN/EMbtaW5hvWJeKTdQCievkwc/e8hKfTG1Yb0dXAQPdF/y4sTGISdvTkuK
         zjhdvFQLr8JucNJvdEGnAclKkqXMrcVDy+ifQsXSBfeT7u4U9WRnyWZPlSgb+i3aywIA
         pqybcE2uGerhFM64FAUjx5fqYjrzXUMLnZY4/5o9DL8nnw60reYE3byIF5MNroHngk9A
         ugPkJxhGZpwrxvw7p30Oz3D4ze50EMzgb7pFIp0Xlk9yf5pw30uJ+eSVWlSqy4XAv7AX
         6d1I6jBFtOLYe+YQEek7rYUUI5Aru8JoCBsZ1FTW6ZyqRzFgtq714IGafi/coSWDYxKh
         StDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=j0lyi5ZaCEg9kVLphrUlqTE7egXC4gRGAmKmOUPozN4=;
        b=sZt5VJ5doEQzbmR7RLR8zeztu4hh/rsIgJn8fnf3oJZO05jOQw3aGss1dE2Ig3lhTU
         YjcGQC8XEZoqkSbLWKnQ9gFtbrO/ofmvockdj7OeZQpylRXKTIJSv77CfvydejpSyw19
         WGLLIFs9ZuwI0AqoxxsuyKOgdt0oZb4Us1loDdBOrzZbk+UCUyxIv6qOzWExzDq3Z36f
         rmgcOBCdly2YPGaBXJyzlDc1sgfKLjkL9nPf+/6lsWJ3L0TDPz6DmGjmQICduRMCHsY0
         dZy2p8DKFvDjUszHyNYgTTRGwHDrflcvY1FJWg9f1GUdzEgmm8GIm0BftXjeqCLJ4a8o
         23UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=M/PFoaec;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I30UtiYC;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=M/PFoaec;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I30UtiYC;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C59760881
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v8 23/24] ASoC: qcom: apq8096: Add db820c machine driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-24-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <253c8a76-9aaa-d4f2-f503-db8c6518d047@codeaurora.org>
Date: Tue, 15 May 2018 01:00:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509125635.5653-24-srinivas.kandagatla@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------2376C208C84080E4DA3A49F1"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263638421096230?=
X-GMAIL-MSGID: =?utf-8?q?1600516239697957080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------2376C208C84080E4DA3A49F1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/9/2018 5:56 AM, Srinivas Kandagatla wrote:
> This patch adds support to DB820c machine driver.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig   |   9 ++
>   sound/soc/qcom/Makefile  |   2 +
>   sound/soc/qcom/apq8096.c | 255 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 266 insertions(+)
>   create mode 100644 sound/soc/qcom/apq8096.c
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


--------------2376C208C84080E4DA3A49F1
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
      cite="mid:20180509125635.5653-24-srinivas.kandagatla@linaro.org">
      <pre wrap="">This patch adds support to DB820c machine driver.

Signed-off-by: Srinivas Kandagatla <a class="moz-txt-link-rfc2396E" href="mailto:srinivas.kandagatla@linaro.org">&lt;srinivas.kandagatla@linaro.org&gt;</a>
---
 sound/soc/qcom/Kconfig   |   9 ++
 sound/soc/qcom/Makefile  |   2 +
 sound/soc/qcom/apq8096.c | 255 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 sound/soc/qcom/apq8096.c

</pre>
    </blockquote>
    Acked-by: Banajit Goswami <a class="moz-txt-link-rfc2396E"
      href="mailto:bgoswami@codeaurora.org">&lt;bgoswami@codeaurora.org&gt;</a>
    <pre class="moz-signature" cols="72">-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project</pre>
  </body>
</html>

--------------2376C208C84080E4DA3A49F1--
