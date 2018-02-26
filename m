Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeBZVZX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:25:23 -0500
Received: from muru.com ([72.249.23.125]:58324 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeBZVZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:25:22 -0500
Date: Mon, 26 Feb 2018 13:25:15 -0800
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sean Young <sean@mess.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2: set CONFIG_LIRC=y in defconfig
Message-ID: <20180226212344.GA16043@atomide.com>
References: <20180226204105.2858838-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226204105.2858838-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [180226 20:42]:
> The CONFIG_LIRC symbol has changed from 'tristate' to 'bool, so we now
> get a warning for omap2plus_defconfig:
> 
> arch/arm/configs/omap2plus_defconfig:322:warning: symbol value 'm' invalid for LIRC
> 
> This changes the file to mark the symbol as built-in to get rid of the
> warning.
> 
> Fixes: a60d64b15c20 ("media: lirc: lirc interface should not be a raw decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>
