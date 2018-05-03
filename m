Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeECQ6t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:58:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECQ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:58:44 -0400
Date: Thu, 03 May 2018 12:58:42 -0400 (EDT)
Message-Id: <20180503.125842.794766419877660253.davem@davemloft.net>
To: colin.king@canonical.com
Cc: saeedm@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix spelling mistake: "loobpack" ->
 "loopback"
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180503091253.29324-1-colin.king@canonical.com>
References: <20180503091253.29324-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu,  3 May 2018 10:12:53 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in netdev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Transposed characters are so annoying ;)

Applied, thanks Colin.
