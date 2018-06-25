Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3FAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41E02606D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41E02606D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934992AbeFYTRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:17:41 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:46135 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbeFYTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:17:40 -0400
Received: by mail-yb0-f195.google.com with SMTP id s14-v6so5604117ybp.13;
        Mon, 25 Jun 2018 12:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z28XUjtEE33Yqr6rwj4JlSuJu1i5tF0RD0/8p+oakBs=;
        b=XXKcuuvrW4YOK/ae27Qpb9/IkSmianIO9ngRmyoQ6wmf3DjNtDnYbtwTOQWzgVf76J
         QpiT6HgFsp1/yk0YexmV0Dj4GKb0V5UItnUByt3/UFb29w+KJDUCgE8bOXj1PZ9KAuZK
         FH/CJeQ1pjHro2GA6+Ai7v0WpoELKjyI04FMY8tb9giJgznBa5cq8XI3oBYhAAi96PK2
         Wtf8urscXif4hoSWhwlEhFQdybwBUpN7aw0TMhmw7hwyuXSJrX7LOz8kkfjDWpgtpylt
         ghcwZlXZhztcj4Z/5ac3DUKbXAH46TCWDnau4MXZ6fEFESudVP1Km9rG4dXlmBbNK5Yx
         0C9Q==
X-Gm-Message-State: APt69E31T1EFFfGyXrCdcxeaosxtoevycko5hsoBDAcpg0Q1eW++kJzN
        Mg82u+3gqsg98Itr6xEWyw==
X-Google-Smtp-Source: ADUXVKKHwiOfPpbH4D3/1ncWWLjgQjCFbqPjDLu1M/dZVTNCUzGbU8m7/Yhdoi4ajjbf6D71tMhXYw==
X-Received: by 2002:a25:9742:: with SMTP id h2-v6mr7168792ybo.77.1529954259471;
        Mon, 25 Jun 2018 12:17:39 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q62-v6sm5938567ywg.2.2018.06.25.12.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:17:38 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:17:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sdm845 machine
 bindings
Message-ID: <20180625191737.GA13246@rob-hp-laptop>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:23:18PM +0530, Rohit kumar wrote:
> Add devicetree bindings documentation file for SDM845 sound card.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt      | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> new file mode 100644
> index 0000000..68feb08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> @@ -0,0 +1,82 @@
> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
> +
> +This binding describes the SDM845 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,sdm845-sndcard"
> +
> +- qcom,audio-routing:

Use just 'audio-routing'.

> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board.
> +
> +- cdc-vdd-supply:
> +	Usage: Optional
> +	Value type: <phandle>
> +	Definition: phandle of regulator supply required for codec vdd.

The codec supply should be in the codec node.

> +
> += dailinks
> +Each subnode of sndcard represents either a dailink, and subnodes of each
> +dailinks would be cpu/codec/platform dais.
> +
> +- link-name:
> +	Usage: required
> +	Value type: <string>
> +	Definition: User friendly name for dai link
> +
> += CPU, PLATFORM, CODEC dais subnodes
> +- cpu:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: cpu dai sub-node
> +
> +- codec:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: codec dai sub-node
> +
> +- platform:
> +	Usage: Optional
> +	Value type: <subnode>
> +	Definition: platform dai sub-node
> +
> +- sound-dai:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
> +
> +Example:
> +
> +audio {
> +	compatible = "qcom,sdm845-sndcard";
> +	qcom,model = "sdm845-snd-card";

Not documented. Just use 'model'.

> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
> +	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
> +
> +	cdc-vdd-supply = <&pm8998_l14>;
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	pri-mi2s-dai-link {
> +		link-name = "PRI MI2S Playback";
> +		cpu {
> +			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +};
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
