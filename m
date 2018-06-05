Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeFENHJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:07:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45893 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbeFENHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:07:08 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Dennis Gilmore <dennis@ausil.us>
Cc: linux-kernel@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: armada388-helios4
References: <20180605124738.24844-1-dennis@ausil.us>
Date: Tue, 05 Jun 2018 15:06:56 +0200
In-Reply-To: <20180605124738.24844-1-dennis@ausil.us> (Dennis Gilmore's
        message of "Tue, 5 Jun 2018 07:47:38 -0500")
Message-ID: <87muw9tma7.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,
 
 On mar., juin 05 2018, Dennis Gilmore <dennis@ausil.us> wrote:

> The helios4 is a Armada388 based nas board designed by SolidRun and
> based on their SOM. It is sold by kobol.io the dts file came from
> https://raw.githubusercontent.com/armbian/build/master/patch/kernel/mvebu-default/95-helios4-device-tree.patch
> I added a SPDX license line to match the clearfog it says it was based
> on and a compatible line for "kobol,helios4"

This patch looks good, I have only two remarks for now.

> +	usb3_phy: usb3-phy {
> +		compatible = "usb-nop-xceiv";
> +		//vbus-regulator = <&reg_5p0v_usb>;
Why did you comment this line?
What about removing it, if you don't need it?

[...]
> +
> +			usb@58000 {
> +				//vcc-supply = <&reg_5p0v_usb>;
Same here

> +				usb-phy = <&usb2_phy>;
> +				status = "okay";
> +			};
> +

Gregory

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
