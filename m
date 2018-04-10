Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755336AbeDJX1Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:27:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32782 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754299AbeDJX1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 19:27:21 -0400
X-Google-Smtp-Source: AIpwx4/ous6dtQoUpfdPNBGSA6g8/bzrfgWSCiJTobP82HR/TttMJcTrPrHLLp+qnGZ1zG+PY5iqig==
Date: Tue, 10 Apr 2018 17:27:19 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin Ian King <colin.king@canonical.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: remove some extraneous spaces in indentations
Message-ID: <20180410232719.qzaltu7hu57aqps3@ziepe.ca>
References: <20180409124336.29274-1-colin.king@canonical.com>
 <20180410232254.mg7stooh5tytv6m2@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410232254.mg7stooh5tytv6m2@ziepe.ca>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 05:22:54PM -0600, Jason Gunthorpe wrote:
> On Mon, Apr 09, 2018 at 01:43:36PM +0100, Colin Ian King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are several lines where there is an extraneous space causing
> > indentation misalignment. Remove them.
> > 
> > Cleans up Cocconelle warnings:
> > 
> > ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:409:3-18: code aligned
> > with following code on line 410
> > ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:415:3-18: code aligned
> > with following code on line 416
> > ./drivers/net/ethernet/mellanox/mlx5/core/qp.c:421:3-18: code aligned
> > with following code on line 422
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >  drivers/net/ethernet/mellanox/mlx5/core/qp.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> applied to for-next thanks

Oh wait, this is for netdev, not rdma sorry. Never mind, DaveM should
pick it up.

Jason
