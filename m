Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeEHEIE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:08:04 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52326 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeEHEID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:08:03 -0400
Date: Tue, 08 May 2018 00:08:01 -0400 (EDT)
Message-Id: <20180508.000801.2279496055246436389.davem@davemloft.net>
To: zhaochen6@huawei.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        aviad.krawczyk@huawei.com, tony.qu@huawei.com, yin.yinshi@huawei.com,
        luoshaokai@huawei.com
Subject: Re: [PATCH net-next] net-next/hinic: add pci device ids for 25ge
 and 100ge card
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180507132157.25047-1-zhaochen6@huawei.com>
References: <20180507132157.25047-1-zhaochen6@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Chen <zhaochen6@huawei.com>
Date: Mon, 7 May 2018 09:21:57 -0400

> This patch adds PCI device IDs to support 25GE and 100GE card:
> 
> 1. Add device id 0x0201 for HINIC 100GE dual port card.
> 2. Add device id 0x0200 for HINIC 25GE dual port card.
> 3. Macro of device id 0x1822 is modified for HINIC 25GE quad port card.
> 
> Signed-off-by: Zhao Chen <zhaochen6@huawei.com>

Applied.
