Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeCPOI5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:08:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:32243 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeCPOIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:08:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="38020613"
Date: Fri, 16 Mar 2018 16:08:50 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
Message-ID: <20180316140850.GC9616@linux.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
 <20180310082428.31519-8-tomas.winkler@intel.com>
 <62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94237DEE@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94237DEE@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:28:55PM +0000, Winkler, Tomas wrote:
> > 
> > On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > > Add tpm2_pcr_extend function to tpm2-cmd.c with signature required by
> > > tpm-interface.c. It wraps the original open code implementation. The
> > > original original tpm2_pcr_extend function is renamed and made static,
> > > called only from new tpm2_pcr_extend.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > This might concern some of the earlier patches too but please use exact
> > names for functions in the short and long summary i.e.
> > 
> >   tpm: migrate all of the PCR extension code to tpm2_pcr_extend()
> > 
> > Check this also for your long descriptions and previous that I gave reviewed-
> > by (I think they were otherwise fine). And you refer to a function in text use
> > parentheses after the name. I don't like hastily written commit messages.
> 
> 
> Yeah,  got little tired of describing the obvious. but you are right.
> Tomas

Might sound nit picking but a solid git log is useful tool.

/Jarkko
