Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCFAzu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:55:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:47981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbeCFAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:55:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,429,1515484800";
   d="scan'208";a="205753568"
Date: Mon, 5 Mar 2018 17:55:48 -0700
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NV-DIMM Mailing List <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] acpi, nfit: remove redundant __func__ in dev_dbg
Message-ID: <20180306005548.GB15227@linux.intel.com>
References: <20180302122049.13900-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302122049.13900-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 01:20:49PM +0100, Johannes Thumshirn wrote:
> Dynamic debug can be instructed to add the function name to the debug
> output using the +f switch, so there is no need for the nfit module to
> do it again. If a user decides to add the +f switch for nfit's dynamic
> debug this results in double prints of the function name like the
> following:
> 
> [ 2391.935383] acpi_nfit_ctl: nfit ACPI0012:00: acpi_nfit_ctl:nmem8 cmd: 10: func: 1 input length: 0
> 
> Thus remove the stray __func__ printing.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

I looked through this and this all looked right to me.

Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
