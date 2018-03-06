Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeCFI2a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 03:28:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:58440 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbeCFI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 03:28:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="180266783"
Date: Tue, 6 Mar 2018 10:28:21 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm_crb: use __le64 annotated variable for response
 buffer address
Message-ID: <20180306082821.GB5705@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180304121205.16934-3-tomas.winkler@intel.com>
 <20180305130320.GC3425@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305130320.GC3425@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 03:03:20PM +0200, Jarkko Sakkinen wrote:
> On Sun, Mar 04, 2018 at 02:12:05PM +0200, Tomas Winkler wrote:
> > This suppresses sparse warning
> > drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64
> > 
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> The guideline is that you should describe what is wrong rather than
> copy-paste the sparse message.

Jason, didn't yo give the feedback to some patch 1-2 years ago that
instead of copy-pasting parse error one should write a clear commit
msg or is this OK?

/Jarkko
