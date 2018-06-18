Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26E1C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2102075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2102075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936343AbeFRXMs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:12:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:35391 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755375AbeFRXMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:12:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 16:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="50359845"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 16:12:46 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 18 Jun 2018 16:12:46 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.79]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.4]) with mapi id 14.03.0319.002;
 Mon, 18 Jun 2018 17:12:43 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 7/7] x86/vdso: Move out the CPU number store
Thread-Topic: [PATCH v3 7/7] x86/vdso: Move out the CPU number store
Thread-Index: AQHT/oHkthm7SJ1SI06xl1wBrUNjyqRnCVyA//+tGiI=
Date:   Mon, 18 Jun 2018 23:12:43 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BD5C79@CRSMSX101.amr.corp.intel.com>
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
 <1528391168-22224-8-git-send-email-chang.seok.bae@intel.com>,<CALCETrXJ31ArFKt3QYi=p9ufyhBW8ZFBdSaDU3ueDmFEFKvY6g@mail.gmail.com>
In-Reply-To: <CALCETrXJ31ArFKt3QYi=p9ufyhBW8ZFBdSaDU3ueDmFEFKvY6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.135]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Couldn't setup_cpu_number_segment()'s contents go in setup_cpu_number()?

Okay. I will do that.
