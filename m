Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeFDV3B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:29:01 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:29:00 -0400
Date: Mon, 04 Jun 2018 17:28:58 -0400 (EDT)
Message-Id: <20180604.172858.971130235733681824.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: Ariel.Elior@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, everest-linux-l2@cavium.com
Subject: Re: [PATCH net-next] qed: use dma_zalloc_coherent instead of
 allocator/memset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180604131031.24476-1-yuehaibing@huawei.com>
References: <20180604131031.24476-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 4 Jun 2018 21:10:31 +0800

> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
