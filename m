Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeDCTh5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:37:57 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:37840 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDCTh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:37:56 -0400
X-Google-Smtp-Source: AIpwx49Lx4Vnc9e8cuAejvzZ/SDCJtYFHzjfwwyGqVdU6mqs+IWenDCVBL+GbrtniNAm1YH6NL/pWg==
Date: Tue, 3 Apr 2018 13:37:50 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ocrdma_hw: Remove redundant checks and goto labels
Message-ID: <20180403193750.GA24735@ziepe.ca>
References: <20180330153858.GA14385@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330153858.GA14385@embeddedgus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 10:38:58AM -0500, Gustavo A. R. Silva wrote:
> Check on return values and goto label mbx_err are unnecessary.
> 
> Addresses-Coverity-ID: 1271151 ("Identical code for different branches")
> Addresses-Coverity-ID: 1268788 ("Identical code for different branches")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_hw.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
