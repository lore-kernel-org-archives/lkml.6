Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeA3WV7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:21:59 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55597 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3WV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:21:57 -0500
Date: Tue, 30 Jan 2018 23:21:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        Santiago Esteban <Santiago.Esteban@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d4: fix pinctrl compatible string
Message-ID: <20180130222145.GO2809@piout.net>
References: <20180118143847.15309-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118143847.15309-1-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2018 at 15:38:47 +0100, Ludovic Desroches wrote:
> From: Santiago Esteban <Santiago.Esteban@microchip.com>
> 
> The compatible string is incorrect. Add atmel,sama5d3-pinctrl since
> it's the appropriate compatible string. Remove the
> atmel,at91rm9200-pinctrl compatible string, this fallback is
> useless, there are too many changes.
> 
> Signed-off-by: Santiago Esteban <Santiago.Esteban@microchip.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: stable@vger.kernel.org #v3.18
> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
