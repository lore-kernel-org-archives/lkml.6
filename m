Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE85C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5722075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfBFOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:52:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:64455 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbfBFOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:52:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 06:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="132017939"
Received: from pgsmsx106.gar.corp.intel.com ([10.221.44.98])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2019 06:52:08 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.99]) by
 PGSMSX106.gar.corp.intel.com ([169.254.9.46]) with mapi id 14.03.0415.000;
 Wed, 6 Feb 2019 22:52:07 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gs0622@gmail.com" <gs0622@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Topic: [PATCH] PM / suspend: measure the time of filesystem syncing
Thread-Index: AQHUvUnOquesjEnW50+dl61NWIyu6qXSVlqA
Date:   Wed, 6 Feb 2019 14:52:06 +0000
Message-ID: <e34a97305c9f40fd510582b4c04ea3839f85e04d.camel@intel.com>
References: <20190203052007.27392-1-harry.pan@intel.com>
         <1702604.tyfAVjpQ0o@aspire.rjw.lan>
In-Reply-To: <1702604.tyfAVjpQ0o@aspire.rjw.lan>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.140.202]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D66E85236CD4BE4A8AC68D0E546C211A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTA1IGF0IDEyOjU1ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gDQo+ID4gKwlrdGltZV90IHN0YXJ0LCBlbmQsIGVsYXBzZWQ7DQo+IA0KPiBXaHkgZG8g
eW91IG5lZWQgdGhyZWUgdmFycyBoZXJlPyAgT25lIHNob3VsZCBiZSBzdWZmaWNpZW50Lg0KLi4u
DQo+ID4gKwlzdGFydCA9IGt0aW1lX2dldF9ib290dGltZSgpOw0KPiANCj4gV2h5IF9ib290dGlt
ZSgpPw0KPiANClllcywgSSBhZ3JlZSBib3RoIGNvbW1lbnRzLg0KDQpCVFcsIFRoZSBpbml0aWFs
IGlkZWEgY2FtZSBmcm9tIHByb2Nlc3NlcyBmcmVlemluZywgYXBvbG9neSBteSBza2V0Y2h5DQpp
bWl0YXRpb24gbm90IGNvbnNpZGVyaW5nIHRoZSBjb250ZXh0IHdlbGwgdG8gY2hvb3NlIGEgcHJv
cGVyIEFQSS4NCg0KLUhhcnJ5DQoNCg==
