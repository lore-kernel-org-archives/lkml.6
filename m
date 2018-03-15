Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbeCOXZz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:25:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:58546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeCOXZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:25:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="183196388"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
Thread-Topic: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
Thread-Index: AQHTvHu8Hi7BJ18K4E25ifo5mBJlxqPR8LZQ
Date: Thu, 15 Mar 2018 23:25:48 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94237DDA@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
 <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
In-Reply-To: <ee4a88f87158e8cb38f90b955af85d68b9105a97.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWRiYjg1NTUtOGFkYS00N2UyLWI0MDUtMzJjMGM0ZWIyMmQ3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJiVlAyaXZlWE1BRTdnNmd2amFjOWdRRUxmb2VOdlFnMGFwSnBGajdSdWZYeHR6WWIxTEsyd1lrNDQ5bWkwV3NlIn0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2FNQ1a9032389

> On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c similarly
> > to tpm2-cmd.c, as well as move TPM2 open code flows into new functions
> > to tpm2-cmd.c The functions in tpm-interface.c should now be in form:
> 
> In which patch tpm1-cmd.c is created?

tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c

https://patchwork.kernel.org/patch/10259691/

> 
> /Jarkko
