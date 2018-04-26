Return-Path: <andy.gross@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524777415; cv=none;
        d=google.com; s=arc-20160816;
        b=v2GD09YwXrUkILI3iECrvXg46OKPvO5wcRYix5Tz//5U/MIWFtIvMc6h+EZRpNqH12
         SYD3EUzBmy4PSw7m6RT8IN0r3PCpbQm3/HryM+4l6xgOYYe8htJVNdktIIKONNV55wiw
         ZyCoae7JmFmmjRaMuSPK3yXN6PBHXYBZW01FskHFJybEOTm3w1r14A+Tl0O9VZ/TZ/p+
         NH+vzOTTGKlvs30ZCsczEoc+icI1ctJrNkOtnEOtD64rWAtj/lcr6Rt5/SaJqebiGKCt
         JZzjp06OLXBbrMg9HmUAirSL5bMwqIvaenASZvRD9FU0AmnrdomonmWwCnoMZYUePeOs
         //Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0k1ZfUIzndH3V1n0wq+7pKEkIkZq+zwDenzMzluHIfw=;
        b=gb6H7ssqmoQBzemblwEZaVnVyeHtKrPeDfKEeQ/52/3sSrqTFhAInBznPreeAh/G53
         0R8fYjQGpbyx6vB7GpUtqXX/wGtEFlYoY54r6k727bcqzmrsZjKfMQI53iLPRfJWBe67
         yL8ypW4blzM7x5RRZd+zLZQeFIzS84MHfduTbib+uSAFLsbZr21vxflJxgyQU/CUflvf
         JUQMW5gZ/ID9unarQLh610fGV2UPPg9pLDtSKWEB+U6p8rbG0bD6/WzxJaNgG6B4HTUW
         YzIDvirOG1/ZDXpn/9kbaHNNuzpLpAzWp51PFa9TtHRpnM1NpgaSye3YLV4QAz0DYvuf
         ik+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Gnrc2rld;
       spf=pass (google.com: domain of andy.gross@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.gross@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Gnrc2rld;
       spf=pass (google.com: domain of andy.gross@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.gross@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+liKfrJaPg+roNp9aWljOYowaAWLfwWj9SJ3gER5fmPUHO33Ved3NEgNUHFRaLhTMgZztOSw==
Date: Thu, 26 Apr 2018 16:16:48 -0500
From: Andy Gross <andy.gross@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org, robh+dt@kernel.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Message-ID: <20180426211648.GB25699@hector.attlocal.net>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801756443527719?=
X-GMAIL-MSGID: =?utf-8?q?1598845002624646410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
