Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCVQq3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:46:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:61810 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeCVQq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:46:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="27558993"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Topic: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Index: AQHTv61cgKpKrSnds0atXlLhYuaZSaPZns+A//+jdICAAP9OgIAAfB0AgAElGwCAAHavgIAAe5+A//+VaAA=
Date: Thu, 22 Mar 2018 16:46:22 +0000
Message-ID: <E3872173-6EDB-4861-896E-4D636A5A9B55@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
 <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
 <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com>
 <CALCETrUxQ1XOs7V1XKOsk-iQ-qOwn41sWGYkepkVOE7PtfX24A@mail.gmail.com>
 <9C732DC6-F9CA-474F-B8F5-F8EBE406B12E@intel.com>
 <CALCETrWyuDC9Visx2-7rwpicVfS3wVMVFBykysaYcoBBe2y+tg@mail.gmail.com>
In-Reply-To: <CALCETrWyuDC9Visx2-7rwpicVfS3wVMVFBykysaYcoBBe2y+tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.180.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0E48A8E1BB2E34C879A7FB5857C328B@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MGkWr0005895

> But your patch doesn't actually do this, since gdb will just do
> SETREGS anyway, right?
GDB does SETREGS on any exclusive (FS/GS) updates in inferior call.
    
    
