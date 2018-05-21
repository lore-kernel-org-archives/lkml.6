Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526892585; cv=none;
        d=google.com; s=arc-20160816;
        b=FNLP9IWgIcT1mGQ6w396JH6K3uGF23xVIwYjO9xOMeSlLndeptvthY+H4+PA7lcB/C
         VHUTZyRxmN6FsoaR7zZV1dfCn9PoNDL+BAsCIF7qigEHdDexOgj4mBs6MbLp8TyT+pnZ
         M0PZavD6Ob8kewZMOM6tKsWIfTWYTNHqoPEVoXcZyu7RiCOIx1zwD1llbYZy1OlD5TKS
         ZQ+HsyveBYGBIUG+ITFPYo9QJAlGTqkA/6bd+k9rLJ9cmPVhxhCsl8ZYE3NWHbdN6yoF
         Qf/G3ix5D7tiWBB0Rt6tfhAfKFrLphfhhjHieBiZl3bU+kJLIfxqAuc56hVursCcKOdH
         rQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=DAkmZ+JlwxCJjU5/RFwJkdXP8BnDgJkv6/H4pcCZZ/U=;
        b=yP3LP8ICR51uzeQ3BNhT5fZ8fOJWY2krY9DiNovCLx1Erk6hgFjdL7yC8/mWhy5jcW
         2mABikXUFV6XiPPiHKQrK+WV8LfLVF2nnQDHJKGzPFFjXOD+WxLf6ONnsjh0Y5Dq/DbB
         9PIwYS7qETOaTb8zn4Aqljzd4jeWzuMwfWtR+GwindEGdOkB954jmFVMX+jm+HFQule2
         hX6DwkSw6gGIzRlxF6bZvMgPeZCqEriC9XRlUsbmloMGsUTXZrN4DgOFP5/KKbwzbkZK
         x6FDJXw8CaBpaWp1nq9Djwxzw7fwWSh6WMqfL5yGfaSAFiBOkwKEexySYxJ90B/CBScH
         p60g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EVlNTkLz;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EVlNTkLz;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZqlWiCBwSRlW5YF+q7SM6r3Z5SKgBwlL6UiYeOReSBuBbiyyRzE4JBwNELm61xFDYnj0oJQCw==
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt bindings
To: Trilok Soni <tsoni@codeaurora.org>, gregkh@linuxfoundation.org,
 robh+dt@kernel.org
Cc: kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, bgoswami@codeaurora.org,
 devicetree@vger.kernel.org, broonie@kernel.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <802138cc-77cc-9800-f725-0ab8a9f0467e@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <482723cd-1792-e17a-7114-0e67e42d6fc7@linaro.org>
Date: Mon, 21 May 2018 09:49:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <802138cc-77cc-9800-f725-0ab8a9f0467e@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600640408468818070?=
X-GMAIL-MSGID: =?utf-8?q?1601062919640333892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 18/05/18 21:47, Trilok Soni wrote:
> Hi Srinivas
> 
> On 5/16/2018 9:51 AM, Srinivas Kandagatla wrote:
>> This patch adds bindings for Qualcomm SLIMBus NGD controller found in
>> all new SoCs starting from B family.
> 
> "X/Y/Z family" has no meaning here in upstream and just put the 
> processor name from which you are adding the support or tested to start 
> with.

Thanks, Will update this when I send new version of this patch.

thanks,
srini
> 
> 
