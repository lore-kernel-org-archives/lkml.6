Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC480C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCD92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfARRlB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:41:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:32115 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbfARRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:41:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 09:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="312983981"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2019 09:40:57 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.47]) with mapi id 14.03.0415.000;
 Fri, 18 Jan 2019 17:40:57 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Subject: RE: [PATCH 0/5] sched refcount_t conversions
Thread-Topic: [PATCH 0/5] sched refcount_t conversions
Thread-Index: AQHUryk8nIpvQnacJEKv36LRANRZEaW1ME0AgAAbG1A=
Date:   Fri, 18 Jan 2019 17:40:56 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B872B2@IRSMSX102.ger.corp.intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <20190118160312.GF14054@worktop.programming.kicks-ass.net>
In-Reply-To: <20190118160312.GF14054@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Jan 18, 2019 at 02:27:25PM +0200, Elena Reshetova wrote:
> > Elena Reshetova (5):
> >   sched: convert sighand_struct.count to refcount_t
> >   sched: convert signal_struct.sigcnt to refcount_t
> 
> These should really be seen by Oleg (bounced) and I'll await his reply.
> 
> >   sched: convert numa_group.refcount to refcount_t
> >   sched/task_struct: convert task_struct.usage to refcount_t
> >   sched/task_struct: convert task_struct.stack_refcount to refcount_t
> 
> Those are ok and I'll queue them.

Thank you Peter! 

Best Regards,
Elena
