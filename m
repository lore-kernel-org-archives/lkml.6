Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeCFV7N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:59:13 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54391 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:59:10 -0500
X-Google-Smtp-Source: AG47ELvyKcyy9PrYpEr6rjiZgYZjGlQ/yh1Miibhp0Wju+swfneM+6li7ndHq9+1qB/cI1QrK/+U0w==
Date: Tue, 6 Mar 2018 14:59:04 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Message-ID: <20180306215904.GA32097@ziepe.ca>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
 <20180305125642.GA3425@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
 <20180306074932.GB3624@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
 <1520353933.5393.21.camel@HansenPartnership.com>
 <1520361396.10396.396.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520361396.10396.396.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 01:36:36PM -0500, Mimi Zohar wrote:
> On Tue, 2018-03-06 at 08:32 -0800, James Bottomley wrote:
> > On Tue, 2018-03-06 at 08:06 +0000, Winkler, Tomas wrote:
> > > > 
> > > > 
> > > > On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > > > 
> > > > > Why you need cover letter?  What are u missing in the patch
> > > > > description
> > > > 
> > > > If you submit a *patch set* I *require* a cover letter, yes.
> > > 
> > > It's good but it is not must, you are inventing your own rules.
> > 
> > As long as the Maintainer is the gatekeeper, you're not going to get
> > very far with this argument.  The fact is that a lot of subsystems have
> > varying rules; often undocumented, some of which are even in conflict,
> > like alphabetic vs reverse christmas tree format for includes.
> > 
> > A cover letter is actually one of the more uniform rules.  It's
> > referred to in submitting patches, but not actually documented there.
> 
> I've heard that some maintainers are moving away from cover letters,
> since they are not include in the git repo and are lost.  I've seen
> Andrew Morton cut and paste the cover letter in the first patch
> description of the patch set.

Andrew has a workflow unlike any other I've seen..

In my view the cover letter should explain why the maintainer should
apply the series, and give any guidance to the review process.

Not duplicate information that belongs in the patch comments. It
shouldn't explain how/why the patch(es) works, etc.

Jason
