Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525853283; cv=none;
        d=google.com; s=arc-20160816;
        b=S7Gc0hNGGMsrmcjPjDch4ZWz1pSeTXol23fYycyP1h1Nf76sEetsGxni7gvfIsQLVI
         u9Kn6QUhteSy5kxP2wmd+x8LeLiQ61MST6mU0kh6ySMIlu+PXdfdI7kXmSfoU2WId1B+
         cKNgmasAILUHXUdzL4Mux4OTVp+TGw9+Ra4cP3b5Ugq+Z0dGcFMmPdP3QX5mACD6KJlJ
         5irCja3XCDMLrFvx7BKc1BiSzzy1pdVy8yVoLW0vUu9rIl4ATD9QseDsVrUCXDRH3lvJ
         p968BPu5gMdEwtqRT65gWWIc4wX386vzMJnunXEqxE2fdyOboMFKv2OMDkJKRhJ9wuRE
         w8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=0S6fLQ1V3lm4RQHbtTa0ml0qPWHAqL5UNpD1HyrLvI4=;
        b=a72Vci+NqJ1pUMgVcd+JuarJsZYYqncoKtYbddIDcS0BfCaEPdPE7OB7zCGVRoIrZv
         xJO4aIMcgzHv7TLDfsdDWhvahmN82/0c9rUCi2EEcEpV46i17V+BHm35ZqyEi9NAK7g7
         VanoQYUYmWaliiuThGb1CigMygl4J7nW6uO64KBfkLpSa9dlWm9DHujtMrofNBSRBL8q
         EL8yIuMkZf5m3+60RIDQzDPzKuDHJaCRtl3m3MPsEw+DHXs8iAqQuu7lcSJ+d1RstIRV
         u/uMGqLOzP2Rcda03mRqqQpeJHF6DidxJhiiDBVX1oBjZ0Erpo+M30OpPpx/NFkw2muP
         lsEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=U1iGkOC7;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=U1iGkOC7;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrSQOVWwD4YYxHsIz9uv0H9iqk7eufKVbClicETYA8Xo/cJGNHuQBubMHwo2NLTqNeAYS545Q==
Subject: Re: [PATCH v7 13/24] ASoC: qdsp6: q6adm: Add q6adm driver
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-14-srinivas.kandagatla@linaro.org>
 <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d85db592-903a-2da3-4ff1-e153b3dde2cb@linaro.org>
Date: Wed, 9 May 2018 09:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <e9a97387-2bd7-9733-5946-50091aec93a0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263623773893739?=
X-GMAIL-MSGID: =?utf-8?q?1599973132310849692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 09/05/18 08:55, Banajit Goswami wrote:
>> + */
>> +int q6adm_close(struct device *dev, int port_id, int perf_mode, int 
>> copp_idx)
> perf_mode unused param. Remove for now. Can be added back when needed.
> 
> Otherwise LGTM.
Yep, will do that thanks.

--srini
> Once fixed above, add acked-by
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
