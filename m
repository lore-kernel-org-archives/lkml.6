Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeBHCqs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:46:48 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39382 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeBHCqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:46:47 -0500
Date: Wed, 07 Feb 2018 21:46:43 -0500 (EST)
Message-Id: <20180207.214643.1455087255402471687.davem@davemloft.net>
To: christophe.jaillet@wanadoo.fr
Cc: ganeshgr@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxgb4: Fix error handling path in 'init_one()'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180206201717.27412-1-christophe.jaillet@wanadoo.fr>
References: <20180206201717.27412-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Tue,  6 Feb 2018 21:17:17 +0100

> Commit baf5086840ab1 ("cxgb4: restructure VF mgmt code") has reordered
> some code but an error handling label has not been updated accordingly.
> So fix it and free 'adapter' if 't4_wait_dev_ready()' fails.
> 
> Fixes: baf5086840ab1 ("cxgb4: restructure VF mgmt code")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.
