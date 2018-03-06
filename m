Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeCFXgM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:36:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54966 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933055AbeCFXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:36:09 -0500
X-Google-Smtp-Source: AG47ELtFLhJvR1OtQWJ+ap6bppxSqVGTd9kbPO/nICLAauZhLBs2FBAopxtPjQknDBnZPRxL5HCmaw==
Date: Tue, 6 Mar 2018 16:36:04 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] RDMA/bnxt_re/qplib_sp: Use true and false for boolean
 values
Message-ID: <20180306233604.GG8328@ziepe.ca>
References: <20180305233647.GA30787@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305233647.GA30787@embeddedgus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 05:36:47PM -0600, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
