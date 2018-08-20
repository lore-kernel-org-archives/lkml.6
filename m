Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CACC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A10E2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A10E2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeHTWxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:53:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33856 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:53:02 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so27908308ois.1;
        Mon, 20 Aug 2018 12:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeIkd4BbvArwplsQRKUIclX3kdvXfyIoD8KytKdHccM=;
        b=SmLMsPkaz2k2FI0oKMr4hBDVOVxoej5rXYE7X5bI6jg1+m1S5Asg90hjbgszZh+RBn
         //Ikx2Uct2yVuDvjGrCgHPp+givwiMsXLL3dPraGs14cK8aXrxz9PfUHk+1/y2yvMa0s
         MrdARTRhoF62I+BwlxoHxDcn+y0w9CH0c2I8rQW9mclb/jl9f9nOHzdTEi0TfWsO/Smy
         t4GANRqvV93y9tUafcpIEH3AXpVlFGvvXvukZPhw23NjRKry3dvj1qqg2wJRd1sdIWom
         HywzplRdjFydKjd5/xF1tY3fCdx4VZufLzrw7Gb/HgPda3rkvLkwgPmVQ9oogWYi8x5N
         KxKg==
X-Gm-Message-State: AOUpUlHVtoQ9JpuzzuHSXWWRo3BLF6mWsHblgy6bw4sPvLSi6phr7BGc
        MmnFcrzB57vVqei0elwiluyop8s=
X-Google-Smtp-Source: AA+uWPyCar0OBadnckGk3dzA5G4tKQtxLlVoF9facr+6xjZ4UloI/XIBokyQyY1CpvCoGcRDHrga+w==
X-Received: by 2002:aca:5e02:: with SMTP id s2-v6mr15861042oib.176.1534793768349;
        Mon, 20 Aug 2018 12:36:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p132-v6sm14346686oia.31.2018.08.20.12.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:36:07 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:36:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] dt-bindings: input: Add document bindings for
 DA7280
Message-ID: <20180820193607.GA17298@bogus>
References: <cover.1534743380.git.Roy.Im@diasemi.com>
 <131d4b001d1da69fc8d82029a91e77a0a126a09b.1534743380.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131d4b001d1da69fc8d82029a91e77a0a126a09b.1534743380.git.Roy.Im@diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 02:36:20PM +0900, Roy Im wrote:
> 
> from: Roy Im <roy.im.opensource@diasemi.com>

Looks like this needs to be removed. You should only have 'From' line 
show up when the sender and author emails are different.

> 
> Add device tree binding information for DA7280 haptic driver.
> Example bindings for DA7280 are added.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> v3: Fixed subject format.
> 
> v2: No changes
> 
> 
>  .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.txt b/Documentation/devicetree/bindings/input/dlg,da7280.txt
> new file mode 100644
> index 0000000..759bcfe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
> @@ -0,0 +1,91 @@
> +Dialog Semiconductor DA7280 Haptics bindings
> +
> +Required properties:
> +- compatible: Should be "dlg,da7280".
> +- reg: Specifies the I2C slave address.
> +
> +- interrupt-parent : Specifies the phandle of the interrupt controller to
> +  which the IRQs from DA7280 are delivered to.

interrupt-parent is implied, so you don't need it here.

> +- interrupts: IRQ line info for DA7280.
> +  (See Documentation/devicetree/bindings/interrupt-controller/
> +   interrupts.txt for further information relating to interrupt properties)
> +- dlg,vib-mode:
> +  "LRA-MODE" - Linear Resonance Actuator mode.
> +  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
> +  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.
> +- dlg,play-mode: choose one in below five modes.
> +  "DRO-MODE" - Direct register override mode.
> +  "PWM-MODE" - PWM data source mode.
> +	In this case, user is able to set duty to 0 ~ 0xffff(0% ~ 100%)
> +  "RTWM-MODE" - Register triggered waveform memory mode.
> +	In this case, when enable this mode the pattern assigned
> +	to the PS_SEQ_ID will be played as much times as PS_SEQ_LOOP.
> +  "ETWM-MODE" - Edge triggered waveform memory mode.
> +	In this case, external GPI(N) control are required to enable/disable
> +	and it needs to keep device enabled by sending magnitude (X > 0)
> +	the pattern assigned to the GPI(N)_SEQUENCE_ID below.
> +	For more details, please see the datasheet.

'-MODE' is redundant

If these modes correspond to a register field, then using the numerical 
values would be simpler.

> +- dlg,nom-microvolt: Nominal actuator voltage rating.
> +- dlg,abs-max-microvolt: Absolute actuator maximum voltage rating.
> +- dlg,imax-microamp: Actuator max current rating.
> +- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,
> +  as read from its datasheet.
> +
> +Optional properties:
> +- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
> +  PWM properties should be named "pwms". And number of cell is different
> +  for each pwm device.
> +  (See Documentation/devicetree/bindings/pwm/pwm.txt
> +   for further information relating to pwm properties)
> +- dlg,ps-seq-id: the PS_SEQ_ID(pattern ID in waveform memory inside chip)
> +  to play back when RTWM-MODE is enabled.

What's the range of valid values?

> +- dlg,ps-seq-loop: the PS_SEQ_LOOP, Number of times the pre-stored sequence
> +  pointed to	by PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated.
> +- dlg,gpiN-seq-id: the GPI(N)_SEQUENCE_ID, pattern to play
> +  when gpi0 is triggered, 'N' must be 0~2.
> +- dlg,gpiN-mode: the pattern mode which can select either
> +  "Single-pattern" or "Multi-pattern", 'N' must be 0~2.
> +- dlg,gpiN-polarity: gpiN polarity which can be chosen among "Rising-edge",
> +  "Falling-edge" and "Both-edge", 'N' must be 0~2.
> +  Haptic will work by this edge option in case of ETWM-MODE.
> +
> +- dlg,resonant-freq-hz: use in case of LRA-MODE, default 205Hz.
> +  the freq range: 50Hz ~ 300Hz.
> +  It will be set to 205Hz if the value is out of range.
> +- dlg,bemf-sens-enable: Enable for internal loop computations.
> +- dlg,freq-track-enable: Enable for resonant frequency tracking.
> +- dlg,acc-enable: Enable for active acceleration.
> +- dlg,rapid-stop-enable: Enable for rapid stop.
> +- dlg,amp-pid-enable: Enable for the amplitude PID.
> +- dlg,mem-array: use in case that memory registers should be updated,
> +  Please fill the whole buffers(100 bytes) to avoid any error in driver.
> +  For example,
> +	dlg,mem-array = <
> +		0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A
> +		...
> +		0x71 0x72 0x73 0x74 0x75 0x76 0x77 0x78 0x79 0x7A
> +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> +		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> +	>;
> +
> +For further information, see device datasheet.
> +
> +======
> +
> +Example:
> +
> +	haptics: da7280-haptics@4A {

Use lowercase hex for unit-address.

> +		compatible = "dlg,da7280";
> +		reg = <0x4A>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		dlg,vib-mode = "LRA-MODE";
> +		dlg,play-mode = "DRO-MODE";
> +		dlg,nom-microvolt = <2000000>;
> +		dlg,abs-max-microvolt = <2000000>;
> +		dlg,imax-microamp = <170000>;
> +		dlg,resonant-freq-hz = <180>;
> +		dlg,impd-micro-ohms = <10500000>;
> +		dlg,freq-track-enable;
> +		dlg,rapid-stop-enable;
> +	};
> -- 
> end-of-patch for PATCH V3
> 
