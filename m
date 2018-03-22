Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCVRIG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:08:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:57910 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeCVRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:08:02 -0400
Date: Thu, 22 Mar 2018 13:08:00 -0400 (EDT)
Message-Id: <20180322.130800.1607432793434617893.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: Fix functional dsa-loop dependency on
 FIXED_PHY
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180321003110.1699-1-f.fainelli@gmail.com>
References: <20180321003110.1699-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 20 Mar 2018 17:31:10 -0700

> We have a functional dependency on the FIXED_PHY MDIO bus because we register
> fixed PHY devices "the old way" which only works if the code that does this has
> had a chance to run before the fixed MDIO bus is probed. Make sure we account
> for that and have dsa_loop_bdinfo.o be either built-in or modular depending on
> whether CONFIG_FIXED_PHY reflects that too.
> 
> Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
