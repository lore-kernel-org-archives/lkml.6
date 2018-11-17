Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ACC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6145D2080C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6145D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKRA5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 19:57:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43378 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeKRA5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 19:57:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so3783128oie.10;
        Sat, 17 Nov 2018 06:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T0ExdkWgnv9BqBo4VufsfOuE4k5ZoOrVMv6pC6oU7NY=;
        b=IHsb5kEvLFT6824MDJPb1R8O923yxA4Nqxy+6ndxvSmNW8RgtehtGdhn/dkJtGOCeE
         GLWjB1nnBzVE5icZDXB4qSXu4vrqPwrrLHTpmwn3IWOi/xf/Bi5GrSbla098vmTwh2/O
         pgWKMNcEYYXkWYZxjkm8p8FF5vu/axDOolGlEisnroyde2LaCf4LfXMI1WKqnSN0T7IP
         uDOk3icRVz4SmL795lKk62eUtQo/ciUZGHvXcDB1YWsSr+suYVDEAcdKD4jH5sIA8uFi
         QfF1Ox/pgaWCWuiSRWq9QoMN/pv++Z5+OCC71pt4Npy6ms6P3VGXCqZaWFwVuRkCzc4W
         Ypiw==
X-Gm-Message-State: AGRZ1gLfZF66nvFu3B80MiFmKaRrXSlRf7Hn6ARg4j8Zs4fu40ulaJrP
        1BHEvh0J0cQfMw5RTViuxL1T3Io=
X-Google-Smtp-Source: AJdET5eLrcyA02WM0juxMVnd3JRWGkw89ekL54kIVcE3IXg4Llq/GM9eDbicIfYlXOgk7DigMXRNUg==
X-Received: by 2002:aca:5c41:: with SMTP id q62-v6mr3468064oib.357.1542465648907;
        Sat, 17 Nov 2018 06:40:48 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id w94sm13529682ota.50.2018.11.17.06.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 06:40:48 -0800 (PST)
Date:   Sat, 17 Nov 2018 08:40:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (adcxx) add devictree bindings
 documentation
Message-ID: <20181117144040.GA8016@bogus>
References: <20181115135013.30723-1-fe@dev.tdt.de>
 <20181115135013.30723-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115135013.30723-2-fe@dev.tdt.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 02:50:12PM +0100, Florian Eckert wrote:
> Document the devicetree bindings for the adcxx.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  Documentation/devicetree/bindings/hwmon/adcxx.txt | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adcxx.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adcxx.txt b/Documentation/devicetree/bindings/hwmon/adcxx.txt
> new file mode 100644
> index 000000000000..a94a5fe21b6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adcxx.txt
> @@ -0,0 +1,24 @@
> +adcxx properties

Needs a better description of what this h/w is.

ADCs go in iio/adc/

> +
> +Required properties:
> +- compatible: Must be one of the following:
> +	- "national,adcxx1s" for adcxx1s
> +	- "national,adcxx2s" for adcxx2s
> +	- "national,adcxx4s" for adcxx4s
> +	- "national,adcxx8s" for adcxx8s

Don't use wildcards in compatible strings.

> +- reg: SPI address for chip
> +
> +Optional properties:
> +
> +- vref-supply
> +  The external reference in microvolt for this device is set to this value.
> +  If it does not exists the reference will be set to 3300000uV (3.3V).
> +
> +Example:
> +
> +adc@6 {
> +	compatible = "national,adcxx2s";
> +	reg = <6 0>;

? SPI addresses are a single cell.

> +	spi-max-frequency = <1000000>;
> +	vref-supply = <&vref>;
> +};
> -- 
> 2.11.0
> 
