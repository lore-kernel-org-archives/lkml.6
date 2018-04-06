Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeDFMSI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:18:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53623 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeDFMSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:18:07 -0400
Date: Fri, 6 Apr 2018 14:17:55 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] ARM: imx: use device properties for at24 eeprom
Message-ID: <20180406121755.n3kqdmissybounio@pengutronix.de>
References: <20180404131627.9135-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404131627.9135-1-brgl@bgdev.pl>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:17:25 up 105 days, 20:35, 77 users,  load average: 0.19, 0.21,
 0.18
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 03:16:23PM +0200, Bartosz Golaszewski wrote:
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
> 
> This series converts all users of at24_platform_data to using generic
> device properties or - as is the case with PATCH 1/4 - drops the
> platform data entirely since it's not needed.
> 
> Bartosz Golaszewski (4):
>   ARM: imx: vpr200: drop at24_platform_data
>   ARM: imx: pcm043: use device properties for at24 eeprom
>   ARM: imx: pca100: use device properties for at24 eeprom
>   ARM: imx: pcm037: use device properties for at24 eeprom

For what it's worth:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
