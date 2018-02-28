Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeB1Ooe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:44:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40265 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932161AbeB1Ooa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:44:30 -0500
Date: Wed, 28 Feb 2018 15:44:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org
Subject: Re: [RFC 0/4] Add support for the Gateworks System Controller
Message-ID: <20180228144424.GC12303@lunn.ch>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 05:21:10PM -0800, Tim Harvey wrote:
> This series adds support for the Gateworks System Controller used on Gateworks
> Laguna, Ventana, and Newport product families.
> 
> The GSC is an MSP430 I2C slave controller whose firmware embeds the following
> features:
>  - I/O expander (16 GPIO's emulating a PCA955x)
>  - EEPROM (enumating AT24)
>  - RTC (enumating DS1672)

Hi Tim

Maybe it is in these patches, and i missed it....

How do these emulated devices work? Does the controller respond to
different addresses for these different emulated devices? Or is it an
I2c bus mux?

    Andrew
