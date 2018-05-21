Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeEUQOf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:14:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56334 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeEUQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:14:31 -0400
Date: Mon, 21 May 2018 12:14:29 -0400 (EDT)
Message-Id: <20180521.121429.1892126313890198061.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: phylink: Don't release NULL GPIO
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180521034947.469-1-f.fainelli@gmail.com>
References: <20180521034947.469-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 20 May 2018 20:49:47 -0700

> If CONFIG_GPIOLIB is disabled, gpiod_put() becomes a stub that produces a
> warning, this helped identify that we could be attempting to release a NULL
> pl->link_gpio GPIO descriptor, so guard against that.
> 
> Fixes: daab3349ad1a ("net: phy: phylink: Release link GPIO")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
