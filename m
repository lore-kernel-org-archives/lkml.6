Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D397821726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfBAXuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:50:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:48142 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAXuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:50:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 15:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="315657688"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2019 15:50:13 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.115]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 15:50:12 -0800
From:   "Brown, Aaron F" <aaron.f.brown@intel.com>
To:     Colin King <colin.king@canonical.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] igb: fix various indentation issues
Thread-Topic: [PATCH] igb: fix various indentation issues
Thread-Index: AQHUrczJ/Rn6MGRhVky1wsAus/0wuaXLtgBg
Date:   Fri, 1 Feb 2019 23:50:11 +0000
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B966212A7@ORSMSX103.amr.corp.intel.com>
References: <20190116185316.24814-1-colin.king@canonical.com>
In-Reply-To: <20190116185316.24814-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBuZXRkZXYtb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bmV0ZGV2LQ0KPiBv
d25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBDb2xpbiBLaW5nDQo+IFNlbnQ6IFdl
ZG5lc2RheSwgSmFudWFyeSAxNiwgMjAxOSAxMDo1MyBBTQ0KPiBUbzogS2lyc2hlciwgSmVmZnJl
eSBUIDxqZWZmcmV5LnQua2lyc2hlckBpbnRlbC5jb20+OyBEYXZpZCBTIC4gTWlsbGVyDQo+IDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7DQo+
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBp
Z2I6IGZpeCB2YXJpb3VzIGluZGVudGF0aW9uIGlzc3Vlcw0KPiANCj4gRnJvbTogQ29saW4gSWFu
IEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IFRoZXJlIGFyZSBzb21lIGxp
bmVzIHRoYXQgaGF2ZSBpbmRlbnRhdGlvbiBpc3N1ZXMsIGZpeCB0aGVzZQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX2V0aHRvb2wuYyB8IDQgKyst
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQpUZXN0ZWQtYnk6IEFhcm9uIEJyb3duIDxhYXJvbi5mLmJyb3duQGludGVsLmNvbT4NCg==
