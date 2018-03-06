Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeCFQcS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:32:18 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40420 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750817AbeCFQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:32:16 -0500
Message-ID: <1520353933.5393.21.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 06 Mar 2018 08:32:13 -0800
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 08:06 +0000, Winkler, Tomas wrote:
> > 
> > 
> > On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > 
> > > Why you need cover letter?  What are u missing in the patch
> > > description
> > 
> > If you submit a *patch set* I *require* a cover letter, yes.
> 
> It's good but it is not must, you are inventing your own rules.

As long as the Maintainer is the gatekeeper, you're not going to get
very far with this argument.  The fact is that a lot of subsystems have
varying rules; often undocumented, some of which are even in conflict,
like alphabetic vs reverse christmas tree format for includes.

A cover letter is actually one of the more uniform rules.  It's
referred to in submitting patches, but not actually documented there.

James
