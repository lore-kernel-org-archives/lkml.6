Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeCQXst (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:48:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49936 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753867AbeCQXsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:48:47 -0400
Date: Sat, 17 Mar 2018 19:48:44 -0400 (EDT)
Message-Id: <20180317.194844.414275023228237273.davem@davemloft.net>
To: matthias.bgg@gmail.com
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        tianjinchuan1@huawei.com, lipeng321@huawei.com, lixiaoping3@huawei.com,
        mbrugger@suse.com, yankejian@huawei.com, linyunsheng@huawei.com,
        huangdaode@hisilicon.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hns: Fix ethtool private flags
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180315165420.16086-1-mbrugger@suse.com>
References: <20180315165420.16086-1-mbrugger@suse.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 15 Mar 2018 17:54:20 +0100

> The driver implementation returns support for private flags, while
> no private flags are present. When asked for the number of private
> flags it returns the number of statistic flag names.
> 
> Fix this by returning EOPNOTSUPP for not implemented ethtool flags.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Looks good, applied, thank you.
