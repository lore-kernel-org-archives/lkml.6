Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeEaVDg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:03:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:57212 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750711AbeEaVDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:03:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="43749963"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 03/15] x86/fsgsbase/64: Use FS/GS base helpers in
 core dump
Thread-Topic: [PATCH V2 03/15] x86/fsgsbase/64: Use FS/GS base helpers in
 core dump
Thread-Index: AQHT+QkbR+czjaQHyESHd9iH7jvMVKRKqs0A//+or8A=
Date: Thu, 31 May 2018 21:03:31 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BBA467@CRSMSX101.amr.corp.intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
 <1527789525-8857-4-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXSQNU1utxkhq8ishFqER_XGCgYMxkxMtxFXHRuOv-zCg@mail.gmail.com>
In-Reply-To: <CALCETrXSQNU1utxkhq8ishFqER_XGCgYMxkxMtxFXHRuOv-zCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTliYWUxOWMtOWJiNC00YWJhLThhZTgtMmQ4ZTliZTI5NDcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJrV0JLeEFoQ2JzV3M4R3pYR2Q4WUZOcnI2bmtCNDhKZzlQbXRNUWJ4ZXkybTRHZkNlUWNibko0U1dQV2RlWTVKIn0=
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4VL3f9D009892

Okay, will fix. Thanks

-----Original Message-----
From: Andy Lutomirski [mailto:luto@kernel.org] 
Sent: Thursday, May 31, 2018 1:16 PM

On Thu, May 31, 2018 at 10:58 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> When new FSGSBASE instructions enabled, this read will be switched to 
> be faster.

s/switched to be/become/

Otherwise:
Reviewed-by: Andy Lutomirski <luto@kernel.org>
