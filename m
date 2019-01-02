Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D37C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC9214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfABU4P convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:56:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:56468 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727766AbfABU4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:56:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 12:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="132456929"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2019 12:56:14 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.152]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.175]) with mapi id 14.03.0415.000;
 Wed, 2 Jan 2019 12:56:13 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        "Shen, Xiaochen" <xiaochen.shen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "Pathan, Arshiya Hayatkhan" <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/10] selftests/resctrl: Add the test in MAINTAINERS
Thread-Topic: [PATCH v4 10/10] selftests/resctrl: Add the test in MAINTAINERS
Thread-Index: AQHUmY0EsE4nuBLt2k2iZIrNBWCjIKWdBK8A//+DK6A=
Date:   Wed, 2 Jan 2019 20:56:13 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C71220985C2062@ORSMSX106.amr.corp.intel.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
 <1545438038-75107-11-git-send-email-fenghua.yu@intel.com>
 <c6a28360-b6fa-9003-8981-a6618ac6a0ff@amd.com>
In-Reply-To: <c6a28360-b6fa-9003-8981-a6618ac6a0ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjc2ZGIwOTItOWRiYi00YWEyLTliMTItZDM0Mzc1Yjc3NDY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWkJIbG9qNEVJN0pjYWNxSnczcno0dGZ2bzZpcTZ3MHlzd3VlakVJdWJIck5yZGpCRjVxbmZ3SVJkMnQ0YWlUciJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Moger, Babu [mailto:Babu.Moger@amd.com]
> >  F:	Documentation/x86/intel_rdt*
> 
> This patch does not apply cleanly.  We have changed the above names from
> intel_rdt to resctrl now. You need to re-base again.

That's right. Will rebase this patch.

Thanks.

-Fenghua
