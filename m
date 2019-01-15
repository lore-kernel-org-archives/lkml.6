Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82294C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfAOTo4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:44:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:61298 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731845AbfAOTo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:44:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 11:44:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="134870858"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2019 11:44:54 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 15 Jan 2019 11:44:54 -0800
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.77]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.39]) with mapi id 14.03.0415.000;
 Tue, 15 Jan 2019 11:44:55 -0800
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Joe Perches <golf@perches.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Subject: RE: [PATCH] Documentation/process: hardcoded core.abbrev considered
 harmful!
Thread-Topic: [PATCH] Documentation/process: hardcoded core.abbrev
 considered harmful!
Thread-Index: AQHUl/dBwDM8/B9akE6x4h3L5psJAaWxar4A//96exA=
Date:   Tue, 15 Jan 2019 19:44:54 +0000
Message-ID: <02874ECE860811409154E81DA85FBB588D56A71E@ORSMSX121.amr.corp.intel.com>
References: <1396949135-27122-1-git-send-email-jeffrey.t.kirsher@intel.com>
         <20181220000112.24891-1-avarab@gmail.com>
 <aa7337c0af524751d1f9d738b10d1e2d4e1199d8.camel@perches.com>
In-Reply-To: <aa7337c0af524751d1f9d738b10d1e2d4e1199d8.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDg4YmYwNDgtNjU5Mi00M2MwLWFlNzMtYjU5YTk5YmQwYTNhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicGRFQmFVQ2dycVY0UkZPMWg1aWphZGVuNmpscTdUWXhWVHlkbGIzVGJlYVk0VGhKWFQ0U1lpTFZDSXRNZCtyRiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joe Perches [mailto:golf@perches.com]
> Sent: Tuesday, January 15, 2019 11:41 AM
> To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: linux-kernel@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; Andrew
> Morton <akpm@linux-foundation.org>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: Re: [PATCH] Documentation/process: hardcoded core.abbrev considered
> harmful!
> 
> On Thu, 2018-12-20 at 01:01 +0100, Ævar Arnfjörð Bjarmason wrote:
> > Stop recommending that core.abbrev=12 be hardcoded when referring to
> > kernel commits, and instead rely on the git's default abbreviation.
> 
> Nothing happened to this patch and there was no reply to
> it as far as I can tell.
> 
> This may be sensible for future git versions, but perhaps
> there should be a different abbrev control added and the
> kernel should enable that.
> 
> > As an aside I have upcoming git.git patches so you'll be able to set
> > core.abbbrev to e.g. +1 to get "13" now, "14" when it rolls over at
> > ~16 million etc. Maybe that'll be a good fit for projects like
> > linux.git that want more future-proof abbreviated SHAs than most.
> 
> Will '$ git config --get core.abbrev' return a specific
> number in that case?
> 
> (not +1 and not blank as current if unspecified)
> 

I wouldn't think so. There might need to be some sort of plumbing command added to obtain this information.

Might be worth pointing that out on the git-devel mailing list.

Thanks,
Jake
