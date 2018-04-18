Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeDRDTm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 23:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753584AbeDRDTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 23:19:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49062175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Wed, 18 Apr 2018 11:19:04 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: imx: use device properties for at24 eeprom
Message-ID: <20180418031903.GS25429@dragon>
References: <20180404131627.9135-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404131627.9135-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

Applied all, thanks.
