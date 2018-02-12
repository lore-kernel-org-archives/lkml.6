Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935636AbeBLNj4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:39:56 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:52095 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbeBLNjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:39:51 -0500
Date: Mon, 12 Feb 2018 14:39:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ingo van Lil <inguin@gmx.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] net: phy: fix wrong mask to phy_modify()
Message-ID: <20180212133949.GA5544@lunn.ch>
References: <20180212110252.27804-1-inguin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212110252.27804-1-inguin@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 12:02:52PM +0100, Ingo van Lil wrote:
> When forcing a specific link mode, the PHY driver must clear the
> existing speed and duplex bits in BMCR while preserving some other
> control bits. This logic was accidentally inverted with the introduction
> of phy_modify().
> 
> Signed-off-by: Ingo van Lil <inguin@gmx.de>

Fixes: fea23fb591cc ("net: phy: convert read-modify-write to phy_modify()")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
