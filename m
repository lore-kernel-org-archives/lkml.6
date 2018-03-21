Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCURLc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:11:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:23143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeCURL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:11:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="36950017"
Date: Wed, 21 Mar 2018 11:11:28 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm, region: hide persistence_domain when unknown
Message-ID: <20180321171128.GA16113@linux.intel.com>
References: <152160620119.29833.14356675736401790361.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152160620119.29833.14356675736401790361.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 09:23:21PM -0700, Dan Williams wrote:
> Similar to other region attributes, do not emit the persistence_domain
> attribute if its contents are empty.
> 
> Fixes: 96c3a239054a ("libnvdimm: expose platform persistence attr...")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
