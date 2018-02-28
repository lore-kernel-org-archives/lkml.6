Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933063AbeB1Pnc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:43:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39470 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932654AbeB1Pn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:43:29 -0500
Date: Wed, 28 Feb 2018 16:43:18 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ARM Maintainers <arm@kernel.org>
Subject: Re: [PATCH 1/3] MAINTAINERS: ARM: at91: update entry for
 ARM/Microchip
Message-ID: <20180228154318.GN1479@piout.net>
References: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2018 at 15:56:41 +0100, Nicolas Ferre wrote:
> Change the entry name and move it to its alphabetical location.
> We move to ARM/Microchip instead of ARM/ATMEL to reflect the merger
> that is now nearly 2 years old.
> AT91 is kept as the identity of our community. The atmel pattern is
> obviously kept as well. I removed the names of the different SoCs as
> they are better exposed in the arch/arm/mach-at91/Kconfig entries.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Hi,
> 
> This patch goes on top of linux-next because Alexandre's email change is taken
> into account (already in arm-soc).
> 

All applied in my at91-soc branch which takes care of the dependency

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
