Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F23620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeJZDRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:17:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39477 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZDRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:17:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id d5so824160oti.6;
        Thu, 25 Oct 2018 11:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SD75fBsHoBBND5lYx1/vza9JkvdKf9yECZp1hhw1mVo=;
        b=N8kYRqX8iqmKQYamMomWHtkh+dKvdwAd9zvDSoRnsQ+g1Va5339MmSyGiQceaAoffo
         qb3DgXYwp0tCEy0K2CxNBUQu4WA6Yl55dQN6C3KstYTYL2/eh/dKJHwuHVq2yO6Disqm
         UCkpbFyIg9TzUuqPJTc7qmsF86q3HrZ6h/3yWvLb8BZ7Xixd8vuiFTijN5cd/wHDHFIC
         pJUDC9YSjVcqfa6NIC4xmuMvNZuIhg2TxUAPRHKqiyZUYMB9BtnYc7MqIlvwZwvfPofW
         xcyB8XlkErEfa0aJeVUCY0yBx1l0sSUbQ5aWYiaz5n6l2mz7iE+6QAwScn55dw5mvhYM
         xKTg==
X-Gm-Message-State: AGRZ1gKPl1UuLu4R7Cz1rJZ80YQ6lnpU+xhIprwTZ4W7A3w63rbR4toC
        DY683AvIiCSxj39BFfriPg==
X-Google-Smtp-Source: AJdET5eYoJlF/MBKLxKlz8fqHXeyXJ24Jf3tIp1cfU1OKrzQffiAdke5UJYX71g5BttJteclEEVh2Q==
X-Received: by 2002:a9d:7850:: with SMTP id c16mr256058otm.175.1540493007773;
        Thu, 25 Oct 2018 11:43:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q187-v6sm2854712oih.49.2018.10.25.11.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:43:27 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:43:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Message-ID: <20181025184326.GA9995@bogus>
References: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1539853956-26644-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:12:36PM +0300, Stefan Popa wrote:
> Document support for AD7606 Analog to Digital Converter.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 51 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> new file mode 100644
> index 0000000..dede581
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
> @@ -0,0 +1,51 @@
> +Analog Devices AD7606 Simultaneous Sampling ADC
> +
> +Required properties for the AD7606:
> +
> + - compatible: Must be one of "adi,ad7605-4", "adi,ad7606-8", "adi,ad7606-6" or
> + 	       "adi,ad7606-4".

Format as one per line please.

> + - reg: SPI chip select number for the device
> + - spi-max-frequency: Max SPI frequency to use
> + 	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> + - spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> + - avcc-supply: phandle to the Avcc power supply
> + - interrupts: IRQ line for the ADC
> + 	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> + - conversion-start-gpio: must be the device tree identifier of the CONVST pin.
> +			  This logic input is used to initiate conversions on
> +			  the analog input channels.

Doesn't IIO have trigger GPIOs?

> +
> +Optional properties:
> +
> + - reset-gpio: must be the device tree identifier of the RESET pin. If specified,
> + 	       it will be asserted during driver probe.

-gpios is the preferred form: reset-gpios

And state the active state

> + - first-data-gpio: must be the device tree identifier of the FRSTDATA pin.
> + 		    The FRSTDATA output indicates when the first channel, V1, is
> +		    being read back on either the parallel, byte or serial interface.
> +- standby-gpio: must be the device tree identifier of the STBY pin. This pin is used
> +		to place the AD7606 into one of two power-down modes, Standby mode or
> +		Shutdown mode.
> +- range-gpio: must be the device tree identifier of the RANGE pin. The polarity on
> +	      this pin determines the input range of the analog input channels. If
> +	      this pin is tied to a logic high, the analog input range is ±10V for
> +	      allchannels. If this pin is tied to a logic low, the analog input range

s/allchannels/all channels/

> +	      is ±5V for all channels.

conversion-start-gpio, first-data-gpio, and range-gpio should all have 
vendor prefix (in addition to -gpios).

> +
> +Example:
> +
> +	adc@0 {
> +		compatible = "adi,ad7606-8";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +
> +		avcc-supply = <&adc_vref>;
> +
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpio>;
> +
> +		conversion-start-gpio = <&gpio 17 0>;
> +		reset-gpio = <&gpio 27 0>;
> +		first-data-gpio = <&gpio 22 0>;
> +		standby-gpio = <&gpio 24 0>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 843545d..6d63db4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported
>  F:	drivers/iio/adc/ad7606.c
> +F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
>  
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
> -- 
> 2.7.4
> 
