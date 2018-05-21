Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeEUMBJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:01:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38585 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeEUMBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:01:06 -0400
Date: Mon, 21 May 2018 14:00:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: phylink: Don't release NULL GPIO
Message-ID: <20180521120054.GB27140@lunn.ch>
References: <20180521034947.469-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521034947.469-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 08:49:47PM -0700, Florian Fainelli wrote:
> If CONFIG_GPIOLIB is disabled, gpiod_put() becomes a stub that produces a
> warning, this helped identify that we could be attempting to release a NULL
> pl->link_gpio GPIO descriptor, so guard against that.
> 
> Fixes: daab3349ad1a ("net: phy: phylink: Release link GPIO")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
