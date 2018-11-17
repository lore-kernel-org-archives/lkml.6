Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E62CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA732082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA732082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeKRCIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:08:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36189 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:08:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so24070754otk.3;
        Sat, 17 Nov 2018 07:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xMuTuqyQ9VSh8NgRhrqXSsqUTYlt3GrF50laeMbleUA=;
        b=ouEUGKLzrXuECoArdp7PS0Oi4dZ7+frQJ2JLLbdgD/opUOAaqHqpTZCM6woRtjdPmp
         BFxL9EIOQ5ek35I2J++C/UelnnHktcXNz3uSqTKYW7uLMffOMKBIji5/HnCVM/ggQEzj
         50lDk1UoTY6RHdIvcZxtZvb1ITNSVbslITtEAz6yGccsNxkxnymnSQmXRSr61kaHOIck
         5RC+S2bvnn2TVAtALpVHiEAHk1wAyDnOJn2kM/bIEruT2lTZEKVH9MqQYGqErqPDIp+e
         yccMKS+yo9LdggkyL6k2mg8Xt6DbuZEVB/zE5sqZXeQxcL6C+x61CDGjqdHnrZJ2ce38
         0e3w==
X-Gm-Message-State: AGRZ1gKxlVFTgi7a4j4vtAPQSBYtywK0DJmaZJwZgrk/pdaUlb27MlU2
        0d0C/O+gCKFzYqCMVRgJtQ==
X-Google-Smtp-Source: AJdET5euvoux1Lg2Zqj8CTtdNHQfL/fARklHQsxW/zc03niGUIMDFyLHs0O0ryEKZzyqb7mo6Uvn4g==
X-Received: by 2002:a9d:3387:: with SMTP id u7mr9729849otc.81.1542469904530;
        Sat, 17 Nov 2018 07:51:44 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id w31sm16026995otb.57.2018.11.17.07.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:51:43 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:51:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: add bindings for AK4118
 transceiver
Message-ID: <20181117155140.GA11554@bogus>
References: <20181114121642.1404-1-peron.clem@gmail.com>
 <20181114121642.1404-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114121642.1404-2-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 01:16:42PM +0100, Clément Péron wrote:
> Document the bindings for AK4118 S/PDIF transceiver
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../devicetree/bindings/sound/ak4118.txt      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4118.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4118.txt b/Documentation/devicetree/bindings/sound/ak4118.txt
> new file mode 100644
> index 000000000000..6e11a2f7404c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak4118.txt
> @@ -0,0 +1,22 @@
> +AK4118 S/PDIF transceiver
> +
> +This device supports I2C mode.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak4118"
> +- reg : The I2C address of the device for I2C
> +- reset-gpios: A GPIO specifier for the reset pin
> +- irq-gpios: A GPIO specifier for the IRQ pin

This should use 'interrupts' instead.

> +
> +Example:
> +
> +&i2c {
> +	ak4118: ak4118@13 {

spdif@13 ? Node names should be based on the class of device, but 
there's not really one defined for this.

> +		#sound-dai-cells = <0>;
> +		compatible = "asahi-kasei,ak4118";
> +		reg = <0x13>;
> +		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>
> +		irq-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> -- 
> 2.19.1
> 
