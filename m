Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9855EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75493218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfAVJgU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:36:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:22954 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfAVJgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:36:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 01:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; 
   d="scan'208";a="137682063"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2019 01:36:18 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.133]) with mapi id 14.03.0415.000;
 Tue, 22 Jan 2019 09:36:17 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Oleg Nesterov <oleg@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Thread-Topic: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Thread-Index: AQHUryk/+6USNNTpGUy8c415xyULQ6W5/xiAgAEHKeCAAAR4AIAAAqCw
Date:   Tue, 22 Jan 2019 09:36:17 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B8B98E@IRSMSX102.ger.corp.intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
 <20190121172822.GB8088@redhat.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B8B877@IRSMSX102.ger.corp.intel.com>
 <20190122092616.GF13777@hirez.programming.kicks-ass.net>
In-Reply-To: <20190122092616.GF13777@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 22, 2019 at 09:11:42AM +0000, Reshetova, Elena wrote:
> > Will you be able to take this and the other scheduler
> > patch to whatever tree/path it should normally go to get eventually
> > integrated?
> 
> I've queeud them up.

Thank you!

Best Regards,
Elena.
