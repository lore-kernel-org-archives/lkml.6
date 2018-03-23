Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbeCWRSc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:18:32 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbeCWRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:18:26 -0400
Date: Fri, 23 Mar 2018 13:18:24 -0400 (EDT)
Message-Id: <20180323.131824.1985048300737629373.davem@davemloft.net>
To: fengguang.wu@intel.com
Cc: salil.mehta@huawei.com, kbuild-all@01.org, netdev@vger.kernel.org,
        yisen.zhuang@huawei.com, lipeng321@huawei.com, liangfuyun1@huawei.com,
        shenjian15@huawei.com, linyunsheng@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: hns3:
 hclge_inform_reset_assert_to_vf() can be static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180322213107.GA29844@roam>
References: <201803230525.jlwCIx4C%fengguang.wu@intel.com>
        <20180322213107.GA29844@roam>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 23 Mar 2018 05:31:07 +0800

> 
> Fixes: 2bfbd35d8ecd ("net: hns3: Changes required in PF mailbox to support VF reset")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Applied, thanks.
