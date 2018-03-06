Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeCFNzf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:55:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:40135 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFNzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:55:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="209238422"
Date: Tue, 6 Mar 2018 15:55:28 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
 tpm1-cmd.c
Message-ID: <20180306135528.GA5700@linux.intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
 <20180305202017.24008-3-tomas.winkler@intel.com>
 <1520335194.7549.7.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422F21B@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422F21B@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 11:21:04AM +0000, Winkler, Tomas wrote:
> 
> > 
> > On Mon, 2018-03-05 at 22:20 +0200, Tomas Winkler wrote:
> > > Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
> > > and change the prefix from tpm_ to tpm1_.
> > > No functional change is done here.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > This a good idea but can you go on and move all TPM 1.x stuff to this new
> > file while you are doing it?
> 
> Yes, see the next patch series.

I read this before that series, sorry :-)

/Jarkko
