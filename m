Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59575C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142E32075E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142E32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJIASj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:18:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:61852 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeJIASj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:18:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 10:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="270550246"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga006.fm.intel.com with ESMTP; 08 Oct 2018 10:05:59 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 8 Oct 2018 10:05:59 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.116]) with mapi id 14.03.0319.002;
 Mon, 8 Oct 2018 10:05:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>, Dave Airlie <airlied@gmail.com>
CC:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: RE: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Thread-Topic: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the
 ambiguity about collecting email addresses
Thread-Index: AQHUXbyz/O8WjoAECEan4x4+MNmuk6UU0zSAgAAIj4CAALoWMA==
Date:   Mon, 8 Oct 2018 17:05:58 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D409730@ORSMSX107.amr.corp.intel.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861799.4088.6.camel@HansenPartnership.com>
        <CAPM=9tz3Z=vD6qWUL2boZGEAgMeC_o9euBXFu2V58RHOn6gR9g@mail.gmail.com>
 <20181007225613.GZ32577@ZenIV.linux.org.uk>
In-Reply-To: <20181007225613.GZ32577@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWYwODcwZGMtNzZiNy00NTA3LTgwMWQtYjM2MzkyZGUyYjM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSWZyY2IrR2QzWEJkQTZuaHg4cnlsVFRhMXlwXC9DenZWbmVzTm43YmJuM210UW8rYVAzdWlQaGxUSkU4aENDU1QifQ==
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

On Mon, Oct 08, 2018 at 08:25:35AM +1000, Dave Airlie wrote:

> This isn't a legally binding license or anything, but departing from
> the upstream wording makes it tricker to merge new upstream versions
> if they are considered appropriate.

The whole document is under 500 words, if we can manage merges of tens
of thousands of lines of code, this should be pretty easy by comparison.

Making it difficult to merge new upstream versions could also be considered
a positive thing.  Given the outcry about this version appearing with no
community discussion, I think folks will also be unhappy about finding some
future merge that just says "Update CoC to upstream 1.5".

-Tony
