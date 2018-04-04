Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeDDPQT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:16:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40026 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDDPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:16:16 -0400
Date: Wed, 04 Apr 2018 11:16:14 -0400 (EDT)
Message-Id: <20180404.111614.1944212946671226677.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, sean.wang@mediatek.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mt7530: Use NULL instead of plain integer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180402232414.19671-1-f.fainelli@gmail.com>
References: <20180402232414.19671-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  2 Apr 2018 16:24:14 -0700

> We would be passing 0 instead of NULL as the rsp argument to
> mt7530_fdb_cmd(), fix that.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
