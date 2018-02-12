Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeBLQru (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:47:50 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54738 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeBLQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:47:48 -0500
Date: Mon, 12 Feb 2018 11:47:47 -0500 (EST)
Message-Id: <20180212.114747.1883056426847767210.davem@davemloft.net>
To: inguin@gmx.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rmk+kernel@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH] net: phy: fix wrong mask to phy_modify()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180212110252.27804-1-inguin@gmx.de>
References: <20180212110252.27804-1-inguin@gmx.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo van Lil <inguin@gmx.de>
Date: Mon, 12 Feb 2018 12:02:52 +0100

> When forcing a specific link mode, the PHY driver must clear the
> existing speed and duplex bits in BMCR while preserving some other
> control bits. This logic was accidentally inverted with the introduction
> of phy_modify().
> 
> Signed-off-by: Ingo van Lil <inguin@gmx.de>

Applied and queued up for -stable.
