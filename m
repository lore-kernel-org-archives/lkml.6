Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeCFLVM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:21:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:35300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFLVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:21:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="32776557"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
 tpm1-cmd.c
Thread-Topic: [PATCH 2/6] tpm: factor out tpm 1.2 duration calculation to
 tpm1-cmd.c
Thread-Index: AQHTtT0TicUnLqYpKkylL5f+qGEG5qPDD88Q
Date: Tue, 6 Mar 2018 11:21:04 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F21B@hasmsx108.ger.corp.intel.com>
References: <20180305202017.24008-1-tomas.winkler@intel.com>
         <20180305202017.24008-3-tomas.winkler@intel.com>
 <1520335194.7549.7.camel@linux.intel.com>
In-Reply-To: <1520335194.7549.7.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzFjZTk1NjEtYTVlZS00YzI3LTg5MjctNGU1YTViMWNjZDE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJFSHBod0RpWnJYc2NFTktpUmlSWGdvRjhyM3U1cG9JcXMza3RDT1I3blQwN05najN3N0FmT0t1cWdGcjFvNEErIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.12.116.226]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w26BLIL3014560


> 
> On Mon, 2018-03-05 at 22:20 +0200, Tomas Winkler wrote:
> > Factor out tpm1.2 commands calculation into tpm1-cmd.c file.
> > and change the prefix from tpm_ to tpm1_.
> > No functional change is done here.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This a good idea but can you go on and move all TPM 1.x stuff to this new
> file while you are doing it?

Yes, see the next patch series.
Tomas
