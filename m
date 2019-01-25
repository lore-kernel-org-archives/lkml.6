Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E861CC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD849218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfAYBVa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:21:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:34294 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfAYBVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:21:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 17:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,519,1539673200"; 
   d="scan'208";a="313325522"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2019 17:21:29 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 24 Jan 2019 17:21:29 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.109]) with mapi id 14.03.0415.000;
 Fri, 25 Jan 2019 09:21:26 +0800
From:   "Li, Weinan Z" <weinan.z.li@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: RE: linux-next: Fixes tag needs some work in the drm-intel-fixes
 tree
Thread-Topic: linux-next: Fixes tag needs some work in the drm-intel-fixes
 tree
Thread-Index: AQHUs9bKIwsXWCK9806yhEIdx16rWqW9w2mAgAFsrCA=
Date:   Fri, 25 Jan 2019 01:21:26 +0000
Message-ID: <9BD218709B5F2A4F96F08B4A3B98A8977335C38E@SHSMSX101.ccr.corp.intel.com>
References: <20190124221949.4c89542a@canb.auug.org.au>
 <87munq1e9u.fsf@intel.com>
In-Reply-To: <87munq1e9u.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTlmZTA4YWUtMzgzNy00NDRkLTg3OWMtYzVmYzNhOTI2NjZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ3MDJDQUxrN2dGc2VvR3FQdXZjUFVFbmw3a0d6SUQ3cEJtaENLcXBGdmtoWkJZbkFlcGVPMStiQjl4d0JkSzdZIn0=
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Stephen.
I am not sure about the problem. The commit id "0cce2823ed37" is just for the patch of "drm/i915/gvt: Refine error handling for prepare_execlist_workload". Is there any other problems I missed?

Regards.
-Weinan


> -----Original Message-----
> From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
> Sent: Thursday, January 24, 2019 7:33 PM
> To: Stephen Rothwell <sfr@canb.auug.org.au>; Daniel Vetter
> <daniel.vetter@ffwll.ch>; Joonas Lahtinen <joonas.lahtinen@linux.intel.com>;
> Vivi, Rodrigo <rodrigo.vivi@intel.com>; Intel Graphics
> <intel-gfx@lists.freedesktop.org>; DRI <dri-devel@lists.freedesktop.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>; Li, Weinan Z <weinan.z.li@intel.com>; Zhenyu
> Wang <zhenyuw@linux.intel.com>
> Subject: Re: linux-next: Fixes tag needs some work in the drm-intel-fixes tree
> 
> On Thu, 24 Jan 2019, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > In commit
> >
> >   0f7555121609 ("drm/i915/gvt: release shadow batch buffer and wa_ctx
> > before destroy one workload")
> >
> > Fixes tag
> >
> >   Fixes: 0cce2823ed37 ("drm/i915/gvt/kvmgt:Refine error handling for
> > prepare_execlist_workload")
> >
> > has these problem(s):
> >
> >   - Subject does not match target commit subject
> >
> > Just some whitespace.
> 
> Thanks for the report. The commit being referenced seems to be the right one,
> though, so I don't think I'm going to force push to fix this.
> 
> BR,
> Jani.
> 
> --
> Jani Nikula, Intel Open Source Graphics Center
