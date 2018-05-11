Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeEKKSp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 06:18:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:13367 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbeEKKSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 06:18:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="57774905"
Date: Fri, 11 May 2018 13:18:34 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Message-ID: <20180511101834.GE20210@linux.intel.com>
References: <20180424160328.GA5119@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94272F33@hasmsx108.ger.corp.intel.com>
 <20180502133246.GA6091@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B083@hasmsx108.ger.corp.intel.com>
 <20180503063508.GA8702@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B9A6@hasmsx108.ger.corp.intel.com>
 <20180504081634.GB6373@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427D284@hasmsx108.ger.corp.intel.com>
 <20180509122621.GB8271@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D895BA3@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D895BA3@hasmsx109.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 09:49:49PM +0000, Winkler, Tomas wrote:
> > 
> > On Sat, May 05, 2018 at 09:07:21PM +0000, Winkler, Tomas wrote:
> > > There is already one 'out' label in that function, what would you prefer for
> > this new label name?
> > > Thanks
> > > Tomas
> > 
> > Aah, of course. My bad that I did not notice it but please just point me if I
> > miss something obvious like that :-) I'll apply the patch today..
> > 
> Thanks
> Tomas

It's also in next now!

/Jarkko
