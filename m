Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeETW7y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 18:59:54 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46920 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeETW7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 18:59:53 -0400
Date: Sun, 20 May 2018 18:59:51 -0400 (EDT)
Message-Id: <20180520.185951.2147212615548538271.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: b53: Extend platform data to
 include DSA ports
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180520155630.23432-1-f.fainelli@gmail.com>
References: <20180520155630.23432-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 20 May 2018 08:56:30 -0700

> The b53 driver already defines and internally uses platform data to let the
> glue drivers specify parameters such as the chip id.  What we were missing was
> a way to tell the core DSA layer about the ports and their type.
> 
> Place a dsa_chip_data structure at the beginning of b53_platform_data for
> dsa_register_switch() to access it. This does not require modifications to
> b53_common.c which will pass platform_data trough.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks.
