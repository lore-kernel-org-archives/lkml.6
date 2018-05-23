Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeEWToX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:44:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34214 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934223AbeEWToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:44:21 -0400
Date: Wed, 23 May 2018 15:44:19 -0400 (EDT)
Message-Id: <20180523.154419.1536190727590965193.davem@davemloft.net>
To: colin.king@canonical.com
Cc: tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] net/mlx4: fix spelling mistake: "Inrerface" ->
 "Interface" and rephrase message
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522154251.16789-1-colin.king@canonical.com>
References: <20180522154251.16789-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 22 May 2018 16:42:51 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in mlx4_dbg debug message and also
> change the phrasing of the message so that is is more readable
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> ---
> V2: rephrase message, as helpfully suggested by Tariq Toukan

Applied.
