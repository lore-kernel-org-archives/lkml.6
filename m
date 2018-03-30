Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeC3OLt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:11:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3OLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:11:48 -0400
Date: Fri, 30 Mar 2018 10:11:44 -0400 (EDT)
Message-Id: <20180330.101144.1387038434454118517.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, thomas.petazzoni@free-electrons.com,
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk,
        linux-kernel@vger.kernel.org, antoine.tenart@bootlin.com,
        ymarkman@marvell.com, stefanc@marvell.com,
        maxime.chevallier@bootlin.com, miquel.raynal@free-electrons.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 0/2] phylink: API changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180328224416.6981-1-f.fainelli@gmail.com>
References: <20180328224416.6981-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 28 Mar 2018 15:44:14 -0700

> This patch series contains two API changes to PHYLINK which will later be used
> by DSA to migrate to PHYLINK. Because these are API changes that impact other
> outstanding work (e.g: MVPP2) I would rather get them included sooner to minimize
> conflicts.

Series applied, thanks Florian.
