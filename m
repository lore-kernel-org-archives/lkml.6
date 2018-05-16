Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeEPTHt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:07:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44210 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeEPTHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:07:47 -0400
Date: Wed, 16 May 2018 15:07:46 -0400 (EDT)
Message-Id: <20180516.150746.403203754959197656.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, fugang.duan@nxp.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: Allow more drivers with
 COMPILE_TEST
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180516.150659.104496510409110952.davem@davemloft.net>
References: <20180516185258.20508-1-f.fainelli@gmail.com>
        <20180516.150659.104496510409110952.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 16 May 2018 15:06:59 -0400 (EDT)

> So applied, thanks.

Nevermind, eventually got a build failure:

ERROR: "knav_queue_open" [drivers/net/ethernet/ti/keystone_netcp.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
make: *** [Makefile:1276: modules] Error 2

Reverted.
