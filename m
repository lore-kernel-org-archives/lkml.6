Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeCPTJl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:09:41 -0400
Received: from verein.lst.de ([213.95.11.211]:48441 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbeCPTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:09:40 -0400
Date: Fri, 16 Mar 2018 20:09:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 15/15] xfs, dax: introduce xfs_break_dax_layouts()
Message-ID: <20180316190938.GI3671@lst.de>
References: <152112908134.24669.10222746224538377035.stgit@dwillia2-desk3.amr.corp.intel.com> <152112917064.24669.8101553386217458496.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152112917064.24669.8101553386217458496.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
