Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeDDRM2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:12:28 -0400
Received: from muru.com ([72.249.23.125]:35232 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbeDDRM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:12:26 -0400
Date: Wed, 4 Apr 2018 10:12:22 -0700
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: fix am43xx build without L2X0
Message-ID: <20180404171222.GH5700@atomide.com>
References: <20180404102550.3692501-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404102550.3692501-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180404 10:27]:
> When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
> implemnentation fails to link:
> 
> arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
> (.text+0x180): undefined reference to `omap4_get_l2cache_base'
> 
> This adds an #ifdef protection around the code, like we do for am44xx.
> 
> Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
