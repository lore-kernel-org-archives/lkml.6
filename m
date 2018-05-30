Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeE3LB6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:01:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:51603 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752541AbeE3LBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:01:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="scan'208";a="43915698"
Date: Wed, 30 May 2018 14:01:45 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
Message-ID: <20180530110145.GC14905@linux.intel.com>
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180523132318.GE363@linux.intel.com>
 <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
 <20180523194115.GC8705@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523194115.GC8705@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 01:41:15PM -0600, Jason Gunthorpe wrote:
> On Wed, May 23, 2018 at 10:57:07AM -0700, Tadeusz Struk wrote:
> > On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> > > Ouch o_O Do you have a fixes tag for this one?
> > > 
> > 
> > This one is quite tricky.
> > The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
> > and the code back then was in drivers/char/tpm/tpm-interface.c file
> 
> No, it has been wrong since before git history started, so just use
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> All the other commits you listed are just moving the bad code around
> to new files.
> 
> Jason

OK, thank you Jason. I'll use that.

/Jarkko
