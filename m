Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161091AbeCASr1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:47:27 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:36230 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161033AbeCASrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:47:21 -0500
Date: Thu, 01 Mar 2018 13:47:17 -0500 (EST)
Message-Id: <20180301.134717.1628675594904426105.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rmk@armlinux.org.uk,
        linux-kernel@vger.kernel.org, moritz.fischer@ettus.com
Subject: Re: [PATCH net-next v2 0/5] net: phy: Reduce duplication
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228195849.17770-1-f.fainelli@gmail.com>
References: <20180228195849.17770-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 28 Feb 2018 11:58:44 -0800

> Hi all,
> 
> This patch series reduces the duplication among 10G PHY drivers that just
> essentially stub most functions, but do that while replicating what the existing
> generic functions do.
> 
> Changes in v2:
> 
> - rename gen10g_soft_reset() to gen10g_no_soft_reset() to better illustrate
>   what it does (or does not)
> - removed stray comment in marvell10g.c

The teranetics change creates an unused variable warning on 'reg'.
