Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F91C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B0F218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAXWN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:13:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:18681 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfAXWNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:13:25 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 14:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="110844747"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2019 14:13:24 -0800
Date:   Thu, 24 Jan 2019 15:12:27 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] MAINTAINERS: Update filesystem-dax and NVDIMM entries
Message-ID: <20190124221226.GB9882@localhost.localdomain>
References: <154835747897.2884847.389054528444820204.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154835747897.2884847.389054528444820204.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:17:59AM -0800, Dan Williams wrote:
> Ross has moved on to other areas.
> 
> Matthew and Jan are trusted reviewers for DAX.
> 
> Dan is now coordinating filesystem-dax pull requests.
> 
> Ira and Keith are now involved with the NVDIMM and Device-DAX
> sub-systems.
> 
> The linux-nvdimm mailing hosts a patchwork instance for both DAX and
> NVDIMM patches.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Keith Busch <keith.busch@intel.com>
