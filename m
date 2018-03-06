Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeCFPB0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:01:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:6234 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932313AbeCFPBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:01:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="209288801"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5 V2] tpm: timeouts revamp
Thread-Topic: [PATCH 0/5 V2] tpm: timeouts revamp
Thread-Index: AQHTtUUWa2w7XNJLoU6dUA5o8zEWQKPDBFyAgABIPDA=
Date: Tue, 6 Mar 2018 15:01:19 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F457@hasmsx108.ger.corp.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
 <1520338622.3779.1.camel@linux.intel.com>
 <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
In-Reply-To: <031568ca-8999-478d-8c53-8b206f312e90@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzExODcwMGItNTU5NS00MTJjLTllNDQtOTQxZjg3ZDZmNmVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI4eDZHNXZzTXQxVCtoUjd0RmJ2OHZLelVOcGhDRlVibklSOG90OWFQZ201cXVjd3BrWjJOZ1NvUXc2dXFTcHo5In0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w26F1WlS018139

> On 03/06/2018 01:17 PM, Jarkko Sakkinen wrote:
> > On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> >> This series cleans up tpm timeouts setting and handling.
> >>
> >> First motivation was to fix failures coming from too short timeouts
> >> for commands that creates keys.
> >> Key generation may take significant time depending on the underlying
> >> hardware. Rather than increasing default timeout a new constant is
> >> added, to not stall too long on regular commands failures.
> >>
> >> Second is to define timeouts for new tpm2 commands defined in TCG
> >> 1.36 spec.
> >
> 
> Probably a typo, since the latest TCG spec version is the 1.38 [0].


I have 1.36 as this is what we implement in the HW, but there might be a new one.  

> > Where can we get that specification? I don't have that new version and
> > couldn't find it from the public internet.

> 
> [0]: https://trustedcomputinggroup.org/tpm-library-specification/
> 

Yes this is the place.
Thanks
Tomas
