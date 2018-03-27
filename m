Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeC0VIH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:08:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38398 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeC0VIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:08:05 -0400
X-Google-Smtp-Source: AIpwx4/J7Sf7MtH6YWVwYKb/IprQYRtv9ay6bg0a5jMeivP+kM+Uv2FoXx5tlIxLj8tVzzxrwJPPZQ==
Date: Tue, 27 Mar 2018 15:08:03 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Colin Ian King <colin.king@canonical.com>
Cc: Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: ensure for-loop actually iterates and free's
 buffers
Message-ID: <20180327210803.GA26189@ziepe.ca>
References: <20180326151018.21066-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326151018.21066-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 04:10:18PM +0100, Colin Ian King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current for-loop zeros variable i and only loops once, hence
> not all the buffers are free'd.  Fix this by setting i correctly.
> 
> Detected by CoverityScan, CID#1463415 ("Operands don't affect result")
> 
> Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Yixian Liu <liuyixian@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
