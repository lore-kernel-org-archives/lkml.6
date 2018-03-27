Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeC0CJG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:09:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:27647 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeC0CJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:09:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="27795797"
From: "Zhang, Rui" <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: RE: linux-next: Tree for Mar 22 (thermal)
Thread-Topic: linux-next: Tree for Mar 22 (thermal)
Thread-Index: AQHTwgRicGhsc9ixwU+6FSKWYxQ4jKPigi+AgADatkA=
Date: Tue, 27 Mar 2018 02:09:00 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092636BF28012@SHSMSX101.ccr.corp.intel.com>
References: <20180322193847.63181403@canb.auug.org.au>
 <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
 <20180326210524.GB1899@localhost.localdomain>
In-Reply-To: <20180326210524.GB1899@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmZhNzJmMzUtZjkyNC00MDRhLWE4NGUtZDU2N2M3OWI5ZDQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJJWUhzZHpEQVNwNnlMdHBKUjY2SkJrYmRMcGYwSkF2dkFhd2pScEYyRkUwcktQQTdOM3VoaVI0R1F1c3N2TEFOIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Tuesday, March 27, 2018 5:05 AM
> To: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>; Linux-Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux PM list <linux-pm@vger.kernel.org>; Zhang,
> Rui <rui.zhang@intel.com>
> Subject: Re: linux-next: Tree for Mar 22 (thermal)
> Importance: High
> 
> Rui,
> 
> On Thu, Mar 22, 2018 at 10:36:38AM -0700, Randy Dunlap wrote:
> > On 03/22/2018 01:38 AM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20180321:
> > >
> > > The vfs tree still had its build failure for which I reverted a commit.
> > >
> >
> > on i386:
> >
> > ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!
> >
> > so in drivers/thermal/thermal_sysfs.c, please add:
> >
> > #include <linux/jiffies.h>
> >
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Are you taking care of this?
> 
No, I missed that email.
Will check it today.

Thanks,
rui
> >
> > thanks,
> > --
> > ~Randy
