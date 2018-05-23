Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbeEWQfw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:35:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:31274 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754623AbeEWQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:35:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="53256472"
Date: Wed, 23 May 2018 10:35:48 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        tony.luck@intel.com, hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] pmem: switch to copy_to_iter_mcsafe()
Message-ID: <20180523163548.GC29519@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, tony.luck@intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152539240757.31796.14176557943876214824.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152539240757.31796.14176557943876214824.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 05:06:47PM -0700, Dan Williams wrote:
> Use the machine check safe version of copy_to_iter() for the
> ->copy_to_iter() operation published by the pmem driver.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Sure.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
