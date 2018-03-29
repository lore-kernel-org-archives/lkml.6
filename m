Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeC2TU3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:20:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45489 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeC2TU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:20:27 -0400
X-Google-Smtp-Source: AIpwx4/cSNgsU8pwaZi+2ljY0FWqLmCHQFT7RKd5WqZAcYifSg/PwAOkh8n6eBYd7yagFbxENoS6BQ==
Date: Thu, 29 Mar 2018 13:20:21 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin King <colin.king@canonical.com>
Cc: Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qedr: ix spelling mistake: "hanlde" -> "handle"
Message-ID: <20180329192021.GA24572@ziepe.ca>
References: <20180329121107.27248-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329121107.27248-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 01:11:07PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in DP_ERR message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> ---
>  drivers/infiniband/hw/qedr/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to for-next, thanks.

I also fixed the spelling error in the subject :)

Jason
