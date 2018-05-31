Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeEaVLu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:11:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:46819 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbeEaVLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:11:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="55572418"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 00/15] x86: Enable FSGSBASE instructions
Thread-Topic: [PATCH V2 00/15] x86: Enable FSGSBASE instructions
Thread-Index: AQHT+QkbMI0rMwAEAkyWFDH5cwIjEqRKsQgA//+jiQA=
Date: Thu, 31 May 2018 21:11:44 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BBA483@CRSMSX101.amr.corp.intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
 <CALCETrVAW5wuABK63h8frMuW_-tT29ZWPH2fPMiffOWQn8Lp2g@mail.gmail.com>
In-Reply-To: <CALCETrVAW5wuABK63h8frMuW_-tT29ZWPH2fPMiffOWQn8Lp2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDJjNmJjNWMtMzAxMC00YzQ0LTgzZTMtOWFlZTcwMWE1ZGMzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJ4bGU3Q1FPZkROaVpGNnpFWU9RTldOYThXaVNhZ3h2ZTllSzVUaENkU1dUNG1JRlROWkx0NmpYam5cLzRcL1RMeHgifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4VLBrmc009946

> 1. Can you try and generate a new version of patches 1-5 quickly?  I think it would be nice to get them merged this cycle.

Okay, let me reply, first, what I can do now. Will do submit patches with revisions, (as soon as I can).
