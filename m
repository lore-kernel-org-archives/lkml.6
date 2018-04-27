Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524838724; cv=none;
        d=google.com; s=arc-20160816;
        b=B/jY49dAPKoJqXI7e6Fx3nUUImQds1HfoEjoZOHN7oZe7o3pGuvr8pTeQjK4cqwml2
         q/+BeqKPet5mvz9TDJoWKCJTOwsGKiiHnp1gLF2/kGCMdGN7ZKjsOxu2/V0njzaPY+F0
         9jDwvaAstX39JkWXCw007m2QlaChDWdBbjDJZgmbu9Txzl51qoRPkQOAF7wnSG2+aooe
         uvYuBuPPPq/Tguy4TyqBOkSUBhjgA48Cwi0VT92xVGDNee82+hryVUI+x99rUlk6Etnr
         HUCiSTx4Yk189gU4/VWS/xGJQ8sU1m41R+2escu/rzLkVfLfnkCvnym8rB0FA1okR7yT
         H/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=3aZ9YmioJrma8Dfl7cey6sQHl2q5y25QDsVStQgYTW4=;
        b=mpcZxHOuRcODAxRrfmva6poZrwOG+OApGgDHWuNbVLmyBIrxyLuGzKi3Bljk90Vxgx
         orhtRtsGALmpJdLdC+kgua9idO5T8PC3raJUs8XbTYM8CHTRtFWzcttLriCSsMjjXHIt
         WiX/DK6SxQrhf0VmVK74iBNBMaQT/MjTVhScQF6QOg2GMfujTcsGz3sn6L+RvqKIuZwd
         xZMgAzBaFdr978mWz2FGrzNjn2J03cYSOdrFbQ1/y/LaMtzZkBcXj2jdXcrSVsq6BQao
         U8nsVq1blZzwMtpggbtLbbW0RC2JQ89Bzl8uyiQ/k7xhPZ+NbA/W3qjHOhmUTICk9kJF
         4Qig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AB8JxZoMxdxJ5CZsXRRjLOByg1lXEKuzmzSo0Bub/TGrSuHEDgWv9Yo/BcSSwox6jySpumBUK7CV0g==
Date: Fri, 27 Apr 2018 09:18:42 -0500
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, broonie@kernel.org,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org, gregkh@linuxfoundation.org,
	david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
	plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com
Subject: Re: [PATCH v6 22/24] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
Message-ID: <20180427141842.fdwhbmexf6ppfnvj@rob-hp-laptop>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-23-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426094606.4775-23-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598801787140996997?=
X-GMAIL-MSGID: =?utf-8?q?1598909290473190632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:46:04AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,apq8096.txt     | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt

Reviewed-by: Rob Herring <robh@kernel.org>
