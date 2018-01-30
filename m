Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeA3WPz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:15:55 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55378 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeA3WPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:15:53 -0500
Date: Tue, 30 Jan 2018 23:15:51 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] ARM: dts: at91: tse850: use the correct compatible
 for the eeprom
Message-ID: <20180130221551.GM2809@piout.net>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-5-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116160618.27859-5-peda@axentia.se>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2018 at 17:06:18 +0100, Peter Rosin wrote:
> The used part does contain an eeprom compatible with an Atmel 24c02
> chip and it is from NXP, but it is not called 24c02. It's actually a
> se97b chip. Adjust the compatible accordingly.
> 
> Fixes: 21dd0ece34c2 ("ARM: dts: at91: add devicetree for the Axentia TSE-850")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
