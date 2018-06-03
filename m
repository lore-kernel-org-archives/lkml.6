Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeFCO7t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 10:59:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeFCO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 10:59:48 -0400
Date: Sun, 03 Jun 2018 10:59:46 -0400 (EDT)
Message-Id: <20180603.105946.899008022965499081.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: anirudh@xilinx.com, John.Linn@xilinx.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com
Subject: Re: [PATCH net-next] net: axienet: remove stale comment of
 axienet_open
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180531115115.11920-1-yuehaibing@huawei.com>
References: <20180531115115.11920-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 31 May 2018 19:51:15 +0800

> axienet_open no longer return -ENODEV when PHY cannot be connected to
> since commit d7cc3163e026 ("net: axienet: Support phy-less mode of operation")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
