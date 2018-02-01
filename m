Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeBAWte (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 17:49:34 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52602 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeBAWtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 17:49:23 -0500
X-Google-Smtp-Source: AH8x227inzODZWZDLbjl68IFpEb9HXumL++kp86SBAhsssmBiHvK1uopJaba+tWiogVD/JzEYFX1gw==
Date: Thu, 1 Feb 2018 15:49:17 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-rdma@vger.kernel.org, Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Jonathan Toppins <jtoppins@redhat.com>
Subject: Re: [PATCH 0/2] RDMA/bnxt_re: Adjustments for
 bnxt_qplib_alloc_dpi_tbl()
Message-ID: <20180201224917.GA8590@ziepe.ca>
References: <19c755a6-8c52-bbd5-a425-48fc08cecd4f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c755a6-8c52-bbd5-a425-48fc08cecd4f@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2018 at 09:15:09PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2018 21:10:12 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete two error messages for a failed memory allocation
>   Use common error handling code

Applied to for-next with Jonathan and Devesh's ack, thanks all

Jason
