Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CottEgrlGltnSQAAmS7hNA
	; Fri, 08 Jun 2018 20:20:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 37733601D2; Fri,  8 Jun 2018 20:20:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BB374607A4;
	Fri,  8 Jun 2018 20:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB374607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeFHUUS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:20:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:51243 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752739AbeFHUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:20:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 13:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,491,1520924400";
   d="scan'208";a="206502569"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga004.jf.intel.com with ESMTP; 08 Jun 2018 13:20:15 -0700
Date: Fri, 8 Jun 2018 14:23:03 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/13] PCI/AER: Squash into one file
Message-ID: <20180608202303.GB24554@localhost.localdomain>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:04:45PM -0500, Bjorn Helgaas wrote:
> The AER code is scattered across several files and buried a little too deep
> in the hierarchy, which makes it a bit of a hassle to browse.  Consolidate
> it all in a single file (plus the optional aer_inject module) and move it
> up one level to drivers/pci/pcie/aer.c.
> 
> This is all pure code moves; no functional changes intended.

Thanks for doing this. I got a head start on reviewing when I saw this
merged to your tree earlier today, and the driver is much more pleasant
to read than before!

Reviewed-by: Keith Busch <keith.busch@intel.com>
