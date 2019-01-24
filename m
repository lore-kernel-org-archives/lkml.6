Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11879C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1267218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfAXU54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:57:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:53806 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfAXU5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:57:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 12:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="119243245"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2019 12:57:53 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gmm4O-0005Mk-AD; Thu, 24 Jan 2019 22:57:52 +0200
Date:   Thu, 24 Jan 2019 22:57:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Tai <thomas.tai@oracle.com>, linux-kernel@vger.kernel.org,
        Tyler Baicar <tbaicar@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v1] ras: Use consistent types for UUIDs
Message-ID: <20190124205752.GK9224@smile.fi.intel.com>
References: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
 <20181005073305.GB24224@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005073305.GB24224@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:33:05AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 13, 2018 at 04:10:27PM +0300, Andy Shevchenko wrote:
> > The commit
> > 
> >   297b64c74385 ("ras: acpi / apei: generate trace event for unrecognized CPER section")
> > 
> > brought inconsistency in UUID types which are used across the RAS subsystem.
> > 
> > Fix this by moving to use guid_t everywhere.
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Rafael, since you handled ACPI/APEI stuff for this cycle, perhaps you can take
this one as well since for half a year there is no response from maintainers?


-- 
With Best Regards,
Andy Shevchenko


