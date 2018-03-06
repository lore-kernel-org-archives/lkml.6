Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeCFD5k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:57:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:55292 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbeCFD5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:57:39 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="180210140"
Date: Mon, 5 Mar 2018 20:57:38 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-dax: remove redundant __func__ in dev_dbg
Message-ID: <20180306035738.GD15227@linux.intel.com>
References: <152029856688.39547.15137553409024621536.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152029856688.39547.15137553409024621536.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 05:09:32PM -0800, Dan Williams wrote:
> Dynamic debug can be instructed to add the function name to the debug
> output using the +f switch, so there is no need for the dax modules to
> do it again. If a user decides to add the +f switch for the dax modules'
> dynamic debug this results in double prints of the function name.
> 
> Reported-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reported-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
