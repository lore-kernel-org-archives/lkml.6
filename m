Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeEPQAO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:00:14 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41608 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEPQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:00:13 -0400
Date: Wed, 16 May 2018 12:00:11 -0400 (EDT)
Message-Id: <20180516.120011.1436307390065240981.davem@davemloft.net>
To: liuqifa@huawei.com
Cc: dsahern@gmail.com, maheshb@google.com, weiyongjun1@huawei.com,
        maowenan@huawei.com, dingtianhong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipvlan: call netdevice notifier when master mac
 address changed
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180514113809.10196-1-liuqifa@huawei.com>
References: <20180514113809.10196-1-liuqifa@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <liuqifa@huawei.com>
Date: Mon, 14 May 2018 19:38:09 +0800

> From: Keefe Liu <liuqifa@huawei.com>
> 
> When master device's mac has been changed, the commit
> 32c10bbfe914 ("ipvlan: always use the current L2 addr of the
> master") makes the IPVlan devices's mac changed also, but it
> doesn't do related works such as flush the IPVlan devices's
> arp table.
> 
> Signed-off-by: Keefe Liu <liuqifa@huawei.com>

Applied and queued up for -stable, thanks.
