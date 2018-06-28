Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C73C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5AE279A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5AE279A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935809AbeF1U5D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:57:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:8207 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934003AbeF1U5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:57:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 13:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="62364512"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2018 13:56:47 -0700
Date:   Thu, 28 Jun 2018 14:55:59 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 2/2] nvme: trace: add disk name to tracepoints
Message-ID: <20180628205559.GD12970@localhost.localdomain>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-3-jthumshirn@suse.de>
 <20180627163706.GA9361@localhost.localdomain>
 <20180628074824.crqwgdlnrqt34s3d@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628074824.crqwgdlnrqt34s3d@linux-x5ow.site>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:48:24AM +0200, Johannes Thumshirn wrote:
> On Wed, Jun 27, 2018 at 10:37:06AM -0600, Keith Busch wrote:
> > It looks like you want the # assigned to /dev/nvme<#>. Do you want to
> > use ctrl->instance here instead?
> 
> Right.
> 
> As it'll conflict with your other trace patch do you want me to wait
> with the resend?

I tried to merge your disk names but it got substantially different
after I combined the two submission trace points into one (I sort of
prefer having only one). I'm about to send it out, and I hope I was able
to preserve your intention, but please have a look and let me know.
