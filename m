Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeFCOkN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 10:40:13 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35562 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 10:40:11 -0400
Date: Sun, 03 Jun 2018 10:40:10 -0400 (EDT)
Message-Id: <20180603.104010.759067934151445129.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: w-kwok2@ti.com, m-karicheri2@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: netcp: ethss: remove unnecessary pointer
 set to NULL
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180531034848.23080-1-yuehaibing@huawei.com>
References: <20180531034848.23080-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 31 May 2018 11:48:48 +0800

> If statement has make sure the 'slave->phy' is NULL
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks good, applied.
