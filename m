Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6BAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76068219D2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 06:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76068219D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeHFIVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 04:21:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:46129 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725735AbeHFIVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 04:21:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2018 23:14:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,451,1526367600"; 
   d="scan'208";a="62542444"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by orsmga007.jf.intel.com with ESMTP; 05 Aug 2018 23:14:23 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.185]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.61]) with mapi id 14.03.0319.002;
 Mon, 6 Aug 2018 07:13:05 +0100
From:   "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix typo in i915_drm_resume()
Thread-Topic: [Intel-gfx] [PATCH] drm/i915: Fix typo in i915_drm_resume()
Thread-Index: AQHUK0jzIzQfZ4NVnk6I27qEpoRWoqSuVF8AgAPdToA=
Date:   Mon, 6 Aug 2018 06:13:05 +0000
Message-ID: <251f85f6cca248b7db7289d53f984892d41c67e2.camel@intel.com>
References: <20180803164150.8185-1-gwan-gyeong.mun@intel.com>
         <153332352090.15394.16477722089065680950@skylake-alporthouse-com>
In-Reply-To: <153332352090.15394.16477722089065680950@skylake-alporthouse-com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.66.147]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2473244F35B75C458812D5432A591C60@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA4LTAzIGF0IDIwOjEyICswMTAwLCBDaHJpcyBXaWxzb24gd3JvdGU6DQo+
IFF1b3RpbmcgR3dhbi1neWVvbmcgTXVuICgyMDE4LTA4LTAzIDE3OjQxOjUwKQ0KPiANCj4gRXZl
biBmb3IgdHJpdmlhbCBwYXRjaGVzLCBhbHdheXMgaW5jbHVkZSBhIGNoYW5nZWxvZy4gSW4gdGhp
cyBjYXNlLCBJDQo+IGFkZGVkICJUcml2aWFsIHR5cG8sIHMvbG9vc2UvbG9zZS8sIGluIGk5MTVf
ZHJtX3Jlc3VtZS4iDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEd3YW4tZ3llb25nIE11biA8Z3dh
bi1neWVvbmcubXVuQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpcyBXaWxzb24g
PGNocmlzQGNocmlzLXdpbHNvbi5jby51az4NCj4gDQo+IEFuZCBwdXNoZWQsIHRoYW5rcyBmb3Ig
dGhlIHNwZWxsaW5nIGNvcnJlY3Rpb24uDQo+IC1DaHJpcw0KDQpIaSBDaHJpcywNClRoYW5rIHlv
dSBmb3IgZ3VpZGluZyBtZSBhbmQgcmV2aWV3aW5nIGl0Lg0KLSBHd2FuLWd5ZW9uZy4NCg==
