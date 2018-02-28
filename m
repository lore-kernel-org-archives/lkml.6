Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934946AbeB1VOO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:14:14 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54355 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933820AbeB1VOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:14:11 -0500
X-Google-Smtp-Source: AG47ELuFui4QRLR8kDuADj8Yjd5dHq+k6laPpQqmRXybMjBGHkSMR7wo/I08YVHLzpU0BxQR4EcGCQ==
Date: Wed, 28 Feb 2018 14:14:05 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-rdma@vger.kernel.org, Chien Tin Tung <chien.tin.tung@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] RDMA/iwpm: Delete an error message for a failed
 memory allocation in iwpm_create_nlmsg()
Message-ID: <20180228211405.GB13394@ziepe.ca>
References: <b1df0889-b967-97ae-3a3d-0dde0d7258cd@users.sourceforge.net>
 <ac5f9bdd-4924-2613-f074-0dd285427604@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5f9bdd-4924-2613-f074-0dd285427604@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2018 at 10:19:05PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2018 21:48:01 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>  drivers/infiniband/core/iwpm_util.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

applied to for-next

Jason
