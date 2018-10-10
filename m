Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A350C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374CB20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374CB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeJKEwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:52:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:34573 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeJKEwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:52:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 14:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="240283586"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 10 Oct 2018 14:28:22 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.129]) with mapi id 14.03.0319.002;
 Wed, 10 Oct 2018 14:28:21 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Topic: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Index: AQHUYNVPd2JNL9wh1k2VKbSU6pfxaqUY9gBQgAB7ZwD//4zZgA==
Date:   Wed, 10 Oct 2018 21:28:20 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D40E635@ORSMSX107.amr.corp.intel.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
         <1539202180.12644.10.camel@HansenPartnership.com>
         <3908561D78D1C84285E8C5FCA982C28F7D40E4F6@ORSMSX107.amr.corp.intel.com>
 <1539206340.12644.20.camel@HansenPartnership.com>
In-Reply-To: <1539206340.12644.20.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2QzODkxYTUtYWI2NS00YjRmLThkZjktNTU3ZmNhYzA1ZTBkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVHpQb2JDUU9oaXBpME1MTzJsZUNzQms1aHF5c09WRVV3YUE4NDYxSlFvQUc5Sks3QjJzRlhuMzRNWU1yZ2ZDQiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBOb3QgdXN1YWxseTogcGVvcGxlIHVzdWFsbHkgaGF2ZSB0byBhZ3JlZSB0byBhIGNoYW5nZSBs
aWtlIHRoaXMuICBPZg0KPiBjb3Vyc2UgImFncmVlIiBpcyBhIHZhcmlhYmxlIGNvbmNlcHQgYW5k
IGNhbiBiZSBhcyBzaW1wbGUgYXMgbm90IG9iamVjdA0KPiBieSBhIGNlcnRhaW4gdGltZSBvciBi
eSB1c2luZyBjZXJ0YWluIGluZnJhc3RydWN0dXJlLg0KDQpQZXJoYXBzIHlvdSBzaG91bGQgcmV2
aWV3IHRoZSBtZWFuaW5nIG9mIHRoZSB3b3JkICJkaWN0YXRvciIuIDotKQ0KDQotVG9ueQ0K
