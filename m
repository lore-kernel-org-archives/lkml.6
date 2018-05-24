Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161512AbeEXVnv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:43:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51656 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966099AbeEXVnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:43:47 -0400
X-Google-Smtp-Source: AB8JxZpXh/C2P1WWka4OENeflq+MzwoXqcpkJ44MMO7nsdhT59aF2CqWZU17DBBQesLos9nQCVY4Dg==
Date: Thu, 24 May 2018 15:43:42 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 rdma-next 0/4] Misc update for hns driver
Message-ID: <20180524214342.GA13272@ziepe.ca>
References: <1527070590-94399-1-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527070590-94399-1-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 06:16:26PM +0800, Wei Hu (Xavier) wrote:
> This patchset included fixing bug, some optimization, reset
> process for hns driver.
> 
> v1->v2: 1.pull the patch out of the series. The name of the patch is 
> 	  RDMA/hns: Implement the disassociate_ucontext API.
> 	2.Modify the fixes statement according to Leon's comment.
> 	3.Address the Jason's comment in reset relevant patch.
> 
> Wei Hu (Xavier) (4):
>   RDMA/hns: Modify uar allocation algorithm to avoid bitmap exhaust
>   RDMA/hns: Increase checking CMQ status timeout value

I took these two to for-next , the others have to respun.

>   RDMA/hns: Add reset process for RoCE in hip08
>   RDMA/hns: Fix the illegal memory operation when cross page

Thanks,
Jason
