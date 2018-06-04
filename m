Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeFDVdf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:33:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52980 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeFDVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:33:34 -0400
Date: Mon, 04 Jun 2018 17:33:32 -0400 (EDT)
Message-Id: <20180604.173332.935788715931197646.davem@davemloft.net>
To: salil.mehta@huawei.com
Cc: yisen.zhuang@huawei.com, lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, wangxi11@huawei.com
Subject: Re: [PATCH V2 net] net: hns: Fix the process of adding broadcast
 addresses to tcam
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180604165009.24476-1-salil.mehta@huawei.com>
References: <20180604165009.24476-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Mon, 4 Jun 2018 17:50:09 +0100

> From: Xi Wang <wangxi11@huawei.com>
> 
> If the multicast mask value in device tree is configured not all
> 0xff, the broadcast mac will be lost from tcam table after the
> execution of command 'ifconfig up'. The address is appended by
> hns_ae_start, but will be clear later by hns_nic_set_rx_mode
> called in dev_open process.
> 
> This patch fixed it by not use the multicast mask when add a
> broadcast address.
> 
> Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
> Patch V2: Fixed comments by David Miller
>    Link: https://lkml.org/lkml/2018/6/4/671
> Patch V1: Initial Submit

Applied and queued up for -stable, thank you.
