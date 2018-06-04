Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeFDUAt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:00:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:36234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeFDUAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:00:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="54690249"
Date: Mon, 4 Jun 2018 23:00:43 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>
Subject: Re: [PATCH v2 0/2] fixes for v4.4
Message-ID: <20180604200043.GF2691@linux.intel.com>
References: <20180530204440.27299-1-jarkko.sakkinen@linux.intel.com>
 <20180602131858.GF31493@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602131858.GF31493@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 03:18:58PM +0200, Greg KH wrote:
> On Wed, May 30, 2018 at 11:44:38PM +0300, Jarkko Sakkinen wrote:
> > Decided to add Enric's commit because it is also a bug fix instead
> > of modifying Chris commit.
> 
> Why just 4.4 and not also 4.9?  I don't want to take patches that would
> cause a regression for people moving from 4.4 to 4.9, so can you also
> provide 4.9 backports of this?  If so, I will be glad to queue up both
> sets of patches.

Yes, I can do this. I'll check the v4.4 change with the original author
as I have to put the check in the original patch into different place
before sending anything (I do not have any POWER systes available to
test it myself).

/Jarkko
