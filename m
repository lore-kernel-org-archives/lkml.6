Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeBWSSz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:18:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:34412 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbeBWSSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:18:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="20587920"
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
CC: "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        Jon Masters <jcm@jonmasters.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: RE: RSB Alternative bit in IA32_ARCH_CAPABILITIES Was:Re: [PATCH
 2/2] x86/speculation: Support "Enhanced IBRS" on future CPUs
Thread-Topic: RSB Alternative bit in IA32_ARCH_CAPABILITIES Was:Re: [PATCH
 2/2] x86/speculation: Support "Enhanced IBRS" on future CPUs
Thread-Index: AQHTpBYQl8Dyc4mRm0iZ20KRHB9/vaOif+eAgAADjgCAABy9AIAABnAAgAAEXACAAAFigIAEqxQAgAACw4CAAAOrgIAAC+oAgAASX4CABXcSgP//eu2wgACJV4D//3ujYIABSuKA//+iJWAAEiKggACeDpyAABCQEzA=
Date: Fri, 23 Feb 2018 18:18:52 +0000
Message-ID: <0575AF4FD06DD142AD198903C74E1CC87A61DDF7@ORSMSX103.amr.corp.intel.com>
References: <1518776517.7876.21.camel@infradead.org>
 <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
 <1518783021.7876.34.camel@infradead.org>
 <4882860e-23c5-75b3-ac02-c700f615156e@jonmasters.org>
 <0575AF4FD06DD142AD198903C74E1CC87A61923C@ORSMSX103.amr.corp.intel.com>
 <10373.1519084385@turing-police.cc.vt.edu>
 <0575AF4FD06DD142AD198903C74E1CC87A619255@ORSMSX103.amr.corp.intel.com>
 <aa3fbaf1-0efc-64b1-4f7b-3d00b0493d48@redhat.com>
 <0575AF4FD06DD142AD198903C74E1CC87A619465@ORSMSX103.amr.corp.intel.com>
 <2159cdc0-c30d-3bf8-1c25-74bff46a1e91@redhat.com>
 <20180223181237.GA19321@char.us.oracle.com>
In-Reply-To: <20180223181237.GA19321@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1NIJ0s9012383

> To add a bit more to this, Intel just updated their
> IA32_ARCH_CAPABILITIES_MSR
> to have a new bit to sample to figure out whether you need IBRS or not
> during runtime.

actually we updated the document when you need RSB stuffing.
based on the request of various folks here on LKML.
