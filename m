Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeD3PyF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:54:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33450 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeD3PyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:54:03 -0400
Date: Mon, 30 Apr 2018 11:54:01 -0400 (EDT)
Message-Id: <20180430.115401.814841781132744012.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: ganeshgr@chelsio.com, johannes.berg@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] libcxgb,cxgb4: use __skb_put_zero to simplfy
 code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180428043522.12408-1-yuehaibing@huawei.com>
References: <20180428043522.12408-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 28 Apr 2018 12:35:22 +0800

> use helper __skb_put_zero to replace the pattern of __skb_put() && memset()
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.
