Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeCZRKA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:10:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53646 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCZRJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:09:59 -0400
Date: Mon, 26 Mar 2018 13:09:56 -0400 (EDT)
Message-Id: <20180326.130956.19399658394636738.davem@davemloft.net>
To: sean.wang@mediatek.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 1/2] net: dsa: mt7530: remove redundant
 MODULE_ALIAS entries
From: David Miller <davem@davemloft.net>
In-Reply-To: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
References: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <sean.wang@mediatek.com>
Date: Mon, 26 Mar 2018 18:07:09 +0800

> From: Sean Wang <sean.wang@mediatek.com>
> 
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
> 
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied.
