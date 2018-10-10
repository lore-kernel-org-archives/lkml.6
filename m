Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2360BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7CB2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7CB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJKE2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:28:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:18482 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbeJKE2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:28:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 14:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
   d="scan'208";a="270263719"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2018 14:04:06 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 10 Oct 2018 14:04:05 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.194]) with mapi id 14.03.0319.002;
 Wed, 10 Oct 2018 14:04:05 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Topic: [Ksummit-discuss] [PATCH v2 2/3] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Index: AQHUYNVPd2JNL9wh1k2VKbSU6pfxaqUY9gBQ
Date:   Wed, 10 Oct 2018 21:04:04 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D40E4F6@ORSMSX107.amr.corp.intel.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
 <1539202180.12644.10.camel@HansenPartnership.com>
In-Reply-To: <1539202180.12644.10.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDYwZmNjYjUtNDQ3MC00MTk1LTkzN2ItY2I0OWQ3NWJkMjE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTHpma0p3UklPVTVrRVVrM0thRTdnWkdxTDlaOWJDdjRUUHg0UXJSVTlLblJXbnQzUGpTemg1TU5pQ3AyaVliayJ9
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

PiB0aGUgZW5mb3JjZW1lbnQgY2xhdXNlIG9mIHRoZSBuZXcgY29kZSBvZiBjb25kdWN0LiAgU2lu
Y2UgdGhlcmUgaXMgY29uY2Vybg0KPiB0aGF0IHRoaXMgYmVjb21lcyBiaW5kaW5nIG9uIHRoZSBy
ZWxlYXNlIG9mIHRoZSA0LjE5IGtlcm5lbA0KDQpJcyB0aGVyZSBzb21lIGxvZ2ljIGJlaGluZCB0
aGF0IGNvbmNlcm4/IFdoYXQncyBtYWdpYyBhYm91dCB0aGUgcmVsZWFzZQ0Kb2YgNC4xOT8NCg0K
T3VyIGJlbmV2b2xlbnQgZGljdGF0b3IgY29tbWl0dGVkIHRoYXQgcGF0Y2guIERpZG4ndCBpdCB0
YWtlIGVmZmVjdA0KYXMgc29vbiBhcyBoZSByYW4gImdpdCBwdXNoIiB0byBtYWtlIGl0IHZpc2li
bGUgdG8gdGhlIHdvcmxkPw0KIA0KLVRvbnkNCg==
