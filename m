Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D8C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BCE216F7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BCE216F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeHOEe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:34:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:51575 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeHOEe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:34:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 18:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,241,1531810800"; 
   d="scan'208";a="81434631"
Received: from pgsmsx106.gar.corp.intel.com ([10.221.44.98])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2018 18:44:58 -0700
Received: from pgsmsx109.gar.corp.intel.com ([169.254.14.29]) by
 PGSMSX106.gar.corp.intel.com ([169.254.9.8]) with mapi id 14.03.0319.002;
 Wed, 15 Aug 2018 09:44:46 +0800
From:   "Ong, Hean Loong" <hean.loong.ong@intel.com>
To:     "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>
Subject: Re: [PATCH10 3/3] ARM:drm ivip Intel FPGA Video and Image
 Processing Suite
Thread-Topic: [PATCH10 3/3] ARM:drm ivip Intel FPGA Video and Image
 Processing Suite
Thread-Index: AQHUM6zXkwSIrYtQ1UymqBUiFlQbv6S+3pYAgACnCYA=
Date:   Wed, 15 Aug 2018 01:44:46 +0000
Message-ID: <1534297485.3035.2.camel@intel.com>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
         <1534237029-2648-4-git-send-email-hean.loong.ong@intel.com>
         <4c9770ce-999f-2ec3-60fb-397c4cec23a2@kernel.org>
In-Reply-To: <4c9770ce-999f-2ec3-60fb-397c4cec23a2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.226.243.17]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F534FD0D5D7764482E35C4DF7E11391@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTE0IGF0IDEwOjQ2IC0wNTAwLCBEaW5oIE5ndXllbiB3cm90ZToNCj4g
DQo+IE9uIDA4LzE0LzIwMTggMDM6NTcgQU0sIEhlYW4tTG9vbmcsIE9uZyB3cm90ZToNCj4gPiAN
Cj4gPiBGcm9tOiBPbmcgSGVhbiBMb29uZyA8aGVhbi5sb29uZy5vbmdAaW50ZWwuY29tPg0KPiA+
IA0KPiA+IERyaXZlciBmb3IgSW50ZWwgRlBHQSBWaWRlbyBhbmQgSW1hZ2UgUHJvY2Vzc2luZyBT
dWl0ZSBGcmFtZSBCdWZmZXINCj4gPiBJSS4NCj4gPiBUaGUgZHJpdmVyIG9ubHkgc3VwcG9ydHMg
dGhlIEludGVsIEFycmlhMTAgZGV2a2l0IGFuZCBpdHMgdmFyaWFudHMuDQo+IFdoeSBvbmx5IEFy
cmlhMTA/IFRoYXQncyBub3QgdHJ1ZSBpcyBpdD8gSSByZW1lbWJlciBydW5uaW5nIGEgdmVyc2lv
bg0KPiBvZg0KPiB0aGlzIG9uIHRoZSBDeWNsb25lNSBTb0NLaXQuDQo+IA0KRHVyaW5nIEN5Y2xv
bmU1IFNvQ2tpdCBpdCB3YXMgdGhlIG9sZGVyIHZlcnNpb24gb2YgdGhlIEZyYW1idWZmZXIuIEZy
b20NCnRoZSBJUCBvd25lciB0aGUgRnJhbWVCdWZmZXIgSUkgZGVzaWduIGlzIG9ubHkgYXZhaWxh
YmxlIGZvciBBcnJpYTEwDQoNCj4gRGluaA0KPiA=
