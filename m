Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD04FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AD120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AD120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLFRgG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:36:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:3205 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeLFRgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:36:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 09:36:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,323,1539673200"; 
   d="scan'208";a="105420068"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2018 09:36:04 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.232]) with mapi id 14.03.0415.000;
 Thu, 6 Dec 2018 09:36:04 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] x86/mce: Streamline MCE subsystem's naming
Thread-Topic: [PATCH] x86/mce: Streamline MCE subsystem's naming
Thread-Index: AQHUjKTFLPWViI0DbkicQSjlsyYtrqVw3IeAgAAIPQCAABFJAIAAEU+AgAFmgYD//4zYsA==
Date:   Thu, 6 Dec 2018 17:36:03 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D47B665@ORSMSX110.amr.corp.intel.com>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205163037.GC109259@gmail.com> <20181205170006.GK29510@zn.tnic>
 <20181205180158.GA64770@gmail.com> <20181205190355.GP29510@zn.tnic>
 <20181206162703.GA119163@gmail.com>
In-Reply-To: <20181206162703.GA119163@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjAxMmNjYzctOTM5YS00ZTkyLTg4NmQtMDJmOWU3MWJiZTMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNGkyMkJjUVF3WGRxSUxURVFDdVN1UTY1a29ZWEVlQlJKZTRwYU1tYnk1Vm1hOG1uMG96RGtuaXgwUWZjaXJqWCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So the real question is, is there a signifcant class of MCE events that 
> are not tied to the reporting channel which is per CPU (-ish ...) MCA 
> banks?

Perhaps QPI/UPI interconnect errors?

-Tony
