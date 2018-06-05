Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeFEPKr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:10:47 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37510 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeFEPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:10:46 -0400
Date: Tue, 05 Jun 2018 11:10:42 -0400 (EDT)
Message-Id: <20180605.111042.973794153148667987.davem@davemloft.net>
To: arnd@arndb.de
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, lipeng321@huawei.com,
        liangfuyun1@huawei.com, linyunsheng@huawei.com, shenjian15@huawei.com,
        wangxi11@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns3: remove unused hclgevf_cfg_func_mta_filter
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605113904.1193671-1-arnd@arndb.de>
References: <20180605113904.1193671-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue,  5 Jun 2018 13:38:21 +0200

> The last patch apparently added a complete replacement for this
> function, but left the old one in place, which now causes a
> harmless warning:
> 
> drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c:731:12: 'hclgevf_cfg_func_mta_filter' defined but not used
> 
> I assume it can be removed.
> 
> Fixes: 3a678b5806e6 ("net: hns3: Optimize the VF's process of updating multicast MAC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
