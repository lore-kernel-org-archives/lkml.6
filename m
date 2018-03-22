Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeCVSsx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:48:53 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59418 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeCVSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:48:50 -0400
Date: Thu, 22 Mar 2018 14:48:49 -0400 (EDT)
Message-Id: <20180322.144849.993359976144963406.davem@davemloft.net>
To: colin.king@canonical.com
Cc: antoine.tenart@bootlin.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: mvpp2: use correct index on array
 mvpp2_pools
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180321173115.1820-1-colin.king@canonical.com>
References: <20180321173115.1820-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 21 Mar 2018 17:31:15 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Array mvpp2_pools is being indexed by long_log_pool, however this
> looks like a cut-n-paste bug and in fact should be short_log_pool.
> 
> Detected by CoverityScan, CID#1466113 ("Copy-paste error")
> 
> Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.
