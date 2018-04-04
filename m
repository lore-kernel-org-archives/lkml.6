Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDDPq2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:46:28 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40492 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeDDPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:46:27 -0400
Date: Wed, 04 Apr 2018 11:46:25 -0400 (EDT)
Message-Id: <20180404.114625.963104761929638198.davem@davemloft.net>
To: tanxiaojun@huawei.com
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        huawei.libin@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        linyunsheng@huawei.com
Subject: Re: [PATCH] net: hns3: fix length overflow when
 CONFIG_ARM64_64K_PAGES
From: David Miller <davem@davemloft.net>
In-Reply-To: <1522834848-63974-1-git-send-email-tanxiaojun@huawei.com>
References: <1522834848-63974-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>
Date: Wed, 4 Apr 2018 17:40:48 +0800

> When enable the config item "CONFIG_ARM64_64K_PAGES", the size of PAGE_SIZE
> is 65536(64K). But the type of length is u16, it will overflow. So change it
> to u32.
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>

Applied, thanks.
