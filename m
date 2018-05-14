Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeENS4s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:56:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40154 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeENS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:56:45 -0400
Date: Mon, 14 May 2018 14:56:42 -0400 (EDT)
Message-Id: <20180514.145642.989041199343505570.davem@davemloft.net>
To: christophe.jaillet@wanadoo.fr
Cc: saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Use 'kvfree()' for memory allocated by
 'kvzalloc()'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180512170925.23690-1-christophe.jaillet@wanadoo.fr>
References: <20180512170925.23690-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 12 May 2018 19:09:25 +0200

> 'out' is allocated with 'kvzalloc()'. 'kvfree()' must be used to free it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Saeed, I assume I will see this in one of your forthcoming pull
requests.

Thanks.
