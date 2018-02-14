Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032179AbeBNXws (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 18:52:48 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33172 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032143AbeBNXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 18:52:46 -0500
X-Google-Smtp-Source: AH8x227FYukEVD6hLnuQHwgQwxRXQq3sABOJRGtvqavZgbxqZP8MVukADYOBSRs0c1HITda2qfQm+Q==
Date: Wed, 14 Feb 2018 16:52:36 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: dledford@redhat.com, hal.rosenstock@gmail.com, sean.hefty@intel.com,
        swise@chelsio.com, joe@perches.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] IB/cxgb3: remove cxio_dbg.c
Message-ID: <20180214235236.GA16962@ziepe.ca>
References: <1517949451-24264-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517949451-24264-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 08:37:31PM +0000, Corentin Labbe wrote:
> cxio_dbg.c is uncompiled since commit 2b540355cd2f ("RDMA/cxgb3: cleanups")
> 10 years after, we could remove it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> Acked-by: Steve Wise <swise@opengridcomputing.com>
> 
> Changes since v1:
> - Remove also all DEBUG code as suggested by Joe Perches
> 
>  drivers/infiniband/hw/cxgb3/Kconfig    |   9 --
>  drivers/infiniband/hw/cxgb3/Makefile   |   2 -
>  drivers/infiniband/hw/cxgb3/cxio_dbg.c | 206 ---------------------------------
>  drivers/infiniband/hw/cxgb3/cxio_hal.h |   9 --
>  drivers/infiniband/hw/cxgb3/iwch_cq.c  |   6 -
>  5 files changed, 232 deletions(-)
>  delete mode 100644 drivers/infiniband/hw/cxgb3/cxio_dbg.c

Applied to -next, thanks

Jason
