Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeCOX3D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:29:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:34766 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932841AbeCOX3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:29:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="24452287"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
Thread-Topic: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
Thread-Index: AQHTvH1poGkXJc+lEU2uPT0FwojHsqPR8RlA
Date: Thu, 15 Mar 2018 23:28:55 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DEE@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
         <20180310082428.31519-8-tomas.winkler@intel.com>
 <62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
In-Reply-To: <62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTBlZWEyZDEtZjRhMS00NzAxLThkZjAtYzEwNGQ0MzZiNTM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJzb3B0TVNHWmVjaHgrTnZwWkMyZWE0RkdWTmFkb2xvUVFCeTM2TEhkeFJkd2xjSWRCN3RtU2g5NnJsa1FpelNZIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.20.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2FNTBu5032403

> 
> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > Add tpm2_pcr_extend function to tpm2-cmd.c with signature required by
> > tpm-interface.c. It wraps the original open code implementation. The
> > original original tpm2_pcr_extend function is renamed and made static,
> > called only from new tpm2_pcr_extend.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This might concern some of the earlier patches too but please use exact
> names for functions in the short and long summary i.e.
> 
>   tpm: migrate all of the PCR extension code to tpm2_pcr_extend()
> 
> Check this also for your long descriptions and previous that I gave reviewed-
> by (I think they were otherwise fine). And you refer to a function in text use
> parentheses after the name. I don't like hastily written commit messages.


Yeah,  got little tired of describing the obvious. but you are right.
Tomas
