Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755230AbeDJXXG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:23:06 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42309 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754955AbeDJXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 19:22:57 -0400
X-Google-Smtp-Source: AIpwx4/q4URkbXumh3xzveoiehugvT+twxJE9PGVOWRjclLwKsGjINI2hM+QI68yDsz3zWkZqfx8/A==
Date: Tue, 10 Apr 2018 17:22:54 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin Ian King <colin.king@canonical.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Message-ID: <20180410232254.mg7stooh5tytv6m2@ziepe.ca>
References: <20180409124336.29274-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409124336.29274-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 01:43:36PM +0100, Colin Ian King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several lines where there is an extraneous space causing
> indentation misalignment. Remove them.
> 
> Cleans up Cocconelle warnings:
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:409:3-18: code aligned
> with following code on line 410
> ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:415:3-18: code aligned
> with following code on line 416
> ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:421:3-18: code aligned
> with following code on line 422
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/qp.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

applied to for-next thanks

Jason
