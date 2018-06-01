Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeFARQL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:16:11 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:43335 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeFARQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:16:09 -0400
X-Google-Smtp-Source: ADUXVKLHRSyvaxvfvpmmVUhTNKklDnUAR4MW9qj/9NoYqUfD1pa94YVvEFy3h//qD/mxOBD8ekF+B1t3bvUwowd2ctM=
MIME-Version: 1.0
In-Reply-To: <20180601185846.1c5b7d0a@canb.auug.org.au>
References: <20180601185846.1c5b7d0a@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 1 Jun 2018 10:16:08 -0700
Message-ID: <CAPcyv4gHQBwvC9bGjFNvVWsZe2XW=52eT7QCcP1dduxaY7Gfbw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the xfs tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Chinner <david@fromorbit.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 1:58 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Dan,
>
> Today's linux-next merge of the nvdimm tree got a conflict in:
>
>   drivers/dax/super.c
>
> between commits:
>
>   ba23cba9b3bd ("fs: allow per-device dax status checking for filesystems")
>   80660f20252d ("dax: change bdev_dax_supported() to support boolean returns")
>
> from the xfs tree and commit:
>
>   e76384884344 ("mm: introduce MEMORY_DEVICE_FS_DAX and CONFIG_DEV_PAGEMAP_OPS")
>
> from the nvdimm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Resolution looks good to me Stephen. Thanks for fixing this up, I'll
let Linus know in the libnvdimm pull request.
