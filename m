Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934022AbeCGQHw convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:07:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:17920 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933479AbeCGQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:07:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="22762424"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "\"linux-security-module@vger.kernel.org\\\"
        <linux-security-module@vger.kernel.org>, \"@lwn.net"
        <"linux-security-module@vger.kernel.org\" <linux-security-module@vger.kernel.org>, "@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "\" <linux-kernel@vger.kernel.org>\"@lwn.net"
        <" <linux-kernel@vger.kernel.org>"@lwn.net>
Subject: RE: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Topic: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Thread-Index: AQHTs7KEInSI42HCTUSCFlGLoOJ8nqPBeeQAgAAiLaCAARpWAIAAJchggABsQYCAACLBAIABZScAgAAiLhA=
Date: Wed, 7 Mar 2018 16:04:02 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9423018C@hasmsx108.ger.corp.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
        <20180305125642.GA3425@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
        <20180306074932.GB3624@linux.intel.com>
        <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
        <1520353933.5393.21.camel@HansenPartnership.com>
        <1520361396.10396.396.camel@linux.vnet.ibm.com>
 <20180307085454.2c820a13@lwn.net>
In-Reply-To: <20180307085454.2c820a13@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWQ2YTliODUtMGUwZS00YWUzLTg2NjktODNjZTFlMGU2MWNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJJd2N3MnpMbTZpR0gwZEZEWDJpY0pRZVZYMkV3bDg3RUJESzQ3U3F3QWFvZnhSMWFmaTNCUmllWkVYQkRZZ1wvYyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Tue, 06 Mar 2018 13:36:36 -0500
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > I've heard that some maintainers are moving away from cover letters,
> > since they are not include in the git repo and are lost.
> 
> If I get a patch series with a cover letter that should be preserved, I apply the
> series in a branch then do a no-ff merge; the cover letter can then go into
> the merge commit.  There's no reason why cover letters need to be lost.

That's clever, but still it feels like a hack. 
I've try to keep cover letters as an empty commits for that but it has to be always forced when rebasing.
Not sure git has a real user friendly support for that.

Tomas
