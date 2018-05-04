Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeEDQyA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:54:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35502 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbeEDQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:53:59 -0400
Date: Fri, 04 May 2018 12:53:56 -0400 (EDT)
Message-Id: <20180504.125356.606110987348629445.davem@davemloft.net>
To: salil.mehta@huawei.com
Cc: yisen.zhuang@huawei.com, lipeng321@huawei.com, mehta.salil@opnsrc.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linyunsheng@huawei.com
Subject: Re: [PATCH net-next] net: hns3: Add support of hardware
 rx-vlan-offload to HNS3 VF driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180503162811.12440-1-salil.mehta@huawei.com>
References: <20180503162811.12440-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Thu, 3 May 2018 17:28:11 +0100

> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> This patch adds support of hardware rx-vlan-offload to VF driver.
> VF uses mailbox to convey PF to configure the hardware.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Applied.
