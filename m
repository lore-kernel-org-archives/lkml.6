Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0322147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfBSVy7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:54:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:60433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfBSVy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:54:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 13:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="300993588"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2019 13:54:58 -0800
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Feb 2019 13:54:57 -0800
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.212]) by
 fmsmsx123.amr.corp.intel.com ([169.254.7.3]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 13:54:57 -0800
From:   "Brown, Len" <len.brown@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Len Brown <lenb@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jiang Liu <jiang.liu@linux.intel.com>, X86 ML <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: update simple firmware interface (SFI)
 section entry
Thread-Topic: [PATCH] MAINTAINERS: update simple firmware interface (SFI)
 section entry
Thread-Index: AQHUsDKnZFTWiof71UmPeLGCgGfLc6XoRLcAgAAIvoD//417cA==
Date:   Tue, 19 Feb 2019 21:54:56 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5B7942@FMSMSX126.amr.corp.intel.com>
References: <20190119200719.5686-1-lukas.bulwahn@gmail.com>
 <CAJvTdKnui1i4pswtNWPKG8RBHBiSgv3H9Xo4bW_Fdn1MtSwE3Q@mail.gmail.com>
 <alpine.DEB.2.21.1902192140480.20286@felia>
In-Reply-To: <alpine.DEB.2.21.1902192140480.20286@felia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmQ2ZWJlNzctZThkMi00M2ZjLWI5MDgtNjE2MmIzODUzZDJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMXNKQXpRQWRkdWRPRFJVWklEQmJQWXU5NEVORDU0WlU4amtaQ3RSRjEyYzBNMnhIbHVUSk5mOEM5RCtUbHgyRyJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this can be scheduled to be deleted.

