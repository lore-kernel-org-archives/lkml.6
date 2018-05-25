Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030261AbeEYUwv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:52:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968275AbeEYUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:52:50 -0400
Date: Fri, 25 May 2018 16:52:48 -0400 (EDT)
Message-Id: <20180525.165248.256217104154156598.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: dsa_loop: Make dynamic debugging
 helpful
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525035215.19341-1-f.fainelli@gmail.com>
References: <20180525035215.19341-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 24 May 2018 20:52:14 -0700

> Remove redundant debug prints from phy_read/write since we can trace those
> calls through trace events. Enhance dynamic debug prints to print arguments
> which helps figuring how what is going on at the driver level with higher level
> configuration interfaces.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
