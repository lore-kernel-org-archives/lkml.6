Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeEKEEd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:04:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:26957 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeEKEEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:04:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,387,1520924400";
   d="scan'208";a="53349107"
Date: Thu, 10 May 2018 22:04:30 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH 0/5] fix radix tree multi-order iteration race
Message-ID: <20180511040430.GA32655@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180508174424.GA12638@linux.intel.com>
 <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 03:48:44PM -0700, Andrew Morton wrote:
> so I think I'll just ignore all that and send this series off to Linus next
> week.

Great.  Thank you, Andrew.
