Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeFDVEd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:04:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52520 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFDVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:04:31 -0400
Date: Mon, 04 Jun 2018 17:04:29 -0400 (EDT)
Message-Id: <20180604.170429.1549988504157998763.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: santosh@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ganeshgr@chelsio.com, leedom@chelsio.com
Subject: Re: [PATCH net-next] net: chelsio: Use zeroing memory allocator
 instead of allocator/memset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180603024015.12744-1-yuehaibing@huawei.com>
References: <20180603024015.12744-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 3 Jun 2018 10:40:15 +0800

> Use dma_zalloc_coherent for allocating zeroed
> memory and remove unnecessary memset function.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
