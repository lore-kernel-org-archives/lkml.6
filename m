Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeCFQq0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:46:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:15121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFQqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:46:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="23396341"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Topic: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Index: AQHTs7KEInSI42HCTUSCFlGLoOJ8nqPBeeQAgAAiLaCAARpWAIAAJchggABsQYCAACIiQA==
Date: Tue, 6 Mar 2018 16:45:59 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F595@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
 <1520353933.5393.21.camel@HansenPartnership.com>
In-Reply-To: <1520353933.5393.21.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWQ4MWY2ZjgtMTQwZC00YTY4LWEzYTItNDE5ZjU1OTc4NjAyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJqdHpGRUcxMFg2MG54bmNscWl5UTEyYVZTVWZId2N3SW85UThGSk45Rk1RNXFZOXJOVytHQ2hNTVwvSXdySVJOTSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.24.108]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w26GkUo2032177

> 
> On Tue, 2018-03-06 at 08:06 +0000, Winkler, Tomas wrote:
> > >
> > >
> > > On Mon, Mar 05, 2018 at 01:09:09PM +0000, Winkler, Tomas wrote:
> > > >
> > > > Why you need cover letter?  What are u missing in the patch
> > > > description
> > >
> > > If you submit a *patch set* I *require* a cover letter, yes.
> >
> > It's good but it is not must, you are inventing your own rules.
> 
> As long as the Maintainer is the gatekeeper, you're not going to get very far
> with this argument.  The fact is that a lot of subsystems have varying rules;
> often undocumented, some of which are even in conflict, like alphabetic vs
> reverse christmas tree format for includes.

Usually I'm trying to stay in convention of the surouding code even if it's agains my personal taste.
 I think this particular case was a bit different. 
 
> A cover letter is actually one of the more uniform rules.  It's referred to in
> submitting patches, but not actually documented there.

I'm all for cover letters,  but for few code line fixes it's more comments then code.

What is most important I think I and Jarkko had found finally a common ground.

Thanks
Tomas
