Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeENNaW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:30:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48713 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753395AbeENNaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:30:20 -0400
Date: Mon, 14 May 2018 15:30:09 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: nicolas.ferre@microchip.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier
Message-ID: <20180514133009.GY10960@piout.net>
References: <1526253724-3596-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526253724-3596-1-git-send-email-hernan@vanguardiasur.com.ar>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2018 20:22:04-0300, Hernán Gonzalez wrote:
> GPIO_ACTIVE_LOW was being used to specify an interrupt, use
> IRQ_TYPE_EDGE_RISING instead. This improves DT readability.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
