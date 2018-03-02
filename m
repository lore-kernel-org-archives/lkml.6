Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164371AbeCBCYN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:24:13 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:41072 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164346AbeCBCYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:24:09 -0500
Date: Thu, 01 Mar 2018 21:24:07 -0500 (EST)
Message-Id: <20180301.212407.1353464039047216968.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rmk@armlinux.org.uk,
        linux-kernel@vger.kernel.org, moritz.fischer@ettus.com
Subject: Re: [PATCH net-next v3 0/5] net: phy: Reduce duplication
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180302000859.17309-1-f.fainelli@gmail.com>
References: <20180302000859.17309-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  1 Mar 2018 16:08:54 -0800

> This patch series reduces the duplication among 10G PHY drivers that just
> essentially stub most functions, but do that while replicating what the existing
> generic functions do.

Series applied, thanks Florian.
