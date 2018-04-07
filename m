Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeDGXrZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 19:47:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:28501 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeDGXrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 19:47:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,421,1517904000";
   d="scan'208";a="41524570"
From: "Brown, Len" <len.brown@intel.com>
To: Matt Turner <mattst88@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] tools/power turbostat: Correct
 SNB_C1/C3_AUTO_UNDEMOTE defines
Thread-Topic: [PATCH 1/2] tools/power turbostat: Correct
 SNB_C1/C3_AUTO_UNDEMOTE defines
Thread-Index: AQHTpP6owIsZbc8agE2piPjajWd0GaP2qb8A//+hw1A=
Date: Sat, 7 Apr 2018 23:47:20 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948499630EE@FMSMSX126.amr.corp.intel.com>
References: <20180213191205.7057-1-mattst88@gmail.com>
 <CAEdQ38FyyphUpQdfO_Jc4RAo4noVeQ+mXo5XBY04wJSAOkoAWw@mail.gmail.com>
In-Reply-To: <CAEdQ38FyyphUpQdfO_Jc4RAo4noVeQ+mXo5XBY04wJSAOkoAWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWEyOGE5NGMtOGY5My00MDI4LTliNmItMjQ4YTNhNmVkYTFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI0VXRSODRCeGxBRFVGQ05mQ2NXcEVFSXJKaEZITVREU3QwNm1yNlwvYWg1MW5EZXlNRzd3ckdrTEtTUlFvSGRPcCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w37NlUk6029256

You just did it:-)

-----Original Message-----
From: Matt Turner [mailto:mattst88@gmail.com] 
Sent: Saturday, April 07, 2018 6:25 PM
To: Brown, Len <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; H. Peter Anvin <hpa@zytor.com>; Borislav Petkov <bp@suse.de>; LKML <linux-kernel@vger.kernel.org>; x86@kernel.org; Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 1/2] tools/power turbostat: Correct SNB_C1/C3_AUTO_UNDEMOTE defines

On Tue, Feb 13, 2018 at 11:12 AM, Matt Turner <mattst88@gmail.com> wrote:
> According to the Intel Software Developers' Manual, Vol. 4, Order No.
> 335592, these macros have been reversed since they were added.
>
> Fixes: 889facbee3e6 ("tools/power turbostat: v3.0: monitor Watts and 
> Temperature")
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Is there something I need to do to ensure these two trivial patches get picked up?
