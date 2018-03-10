Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeCJMik (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 07:38:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:32318 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeCJMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 07:38:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,451,1515484800";
   d="scan'208";a="210401673"
Message-ID: <f29db30997454e99c57b3fe0f5928b71efa484a7.camel@linux.intel.com>
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1520361396.10396.396.camel@linux.vnet.ibm.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
         <1520353933.5393.21.camel@HansenPartnership.com>
         <1520361396.10396.396.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 10 Mar 2018 14:37:53 +0200
Mime-Version: 1.0
X-Mailer: Evolution 3.27.90-1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 13:36 -0500, Mimi Zohar wrote:
> I've heard that some maintainers are moving away from cover letters,
> since they are not include in the git repo and are lost.  I've seen
> Andrew Morton cut and paste the cover letter in the first patch
> description of the patch set.

When I contribute code, the cover letter helps me to do the Right
Thing.. Taking the time to write a proper cover letter helps to do a
"mental exercise" that

1. The changes make sense in the first place.
2. Only the necessary is done, not more or less.

Even for a small patch set the time used to write the cover letter
will pay off because it helps the maitainer to make a fair and
educated decision.

/Jarkko
