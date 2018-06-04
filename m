Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeFDV20 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:28:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeFDV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:28:24 -0400
Date: Mon, 04 Jun 2018 17:28:22 -0400 (EDT)
Message-Id: <20180604.172822.453377894759104069.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: qiang.zhao@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] wan/fsl_ucc_hdlc: use dma_zalloc_coherent
 instead of allocator/memset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180604130759.25024-1-yuehaibing@huawei.com>
References: <20180604130759.25024-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 4 Jun 2018 21:07:59 +0800

> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
