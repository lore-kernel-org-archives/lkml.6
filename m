Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeCVHZJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 03:25:09 -0400
Received: from verein.lst.de ([213.95.11.211]:45867 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbeCVHZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 03:25:08 -0400
Date: Thu, 22 Mar 2018 08:25:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v7 12/14] xfs: prepare xfs_break_layouts() to be called
        with XFS_MMAPLOCK_EXCL
Message-ID: <20180322072506.GA28713@lst.de>
References: <152167302988.5268.4370226749268662682.stgit@dwillia2-desk3.amr.corp.intel.com> <152167310017.5268.8654419042128713101.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152167310017.5268.8654419042128713101.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
