Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB1C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C772146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="G0ezVuhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C772146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbeKPNSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:18:44 -0500
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:9780 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbeKPNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:18:44 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 08:18:41 EST
X-IronPort-AV: E=McAfee;i="5900,7806,9078"; a="1587095"
X-IronPort-AV: E=Sophos;i="5.56,238,1539615600"; 
   d="scan'208";a="1587095"
Received: from mail-pu1apc01lp0017.outbound.protection.outlook.com (HELO APC01-PU1-obe.outbound.protection.outlook.com) ([65.55.88.17])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2018 11:58:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector1-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSWpzkcKjzgp1JTeiapI0DD2k/p8Ae3BCyQU40OhKVw=;
 b=G0ezVuhikKnCrlkUDvZ4BNrw5mn7MRknd6mUGA1DMKa0+qLTgoUmf0ojFMDOa7/XFUoHC0Ix/DK4B6EPGiMaCjzUDJd7oBhcfVd3YE2XgzYasP5GhPem3UUs0oDfjd2xWLEROiVupWwn9+TCxpiwTE3CaTTL38UFAf+V20Lq9s0=
Received: from TY2PR01MB3259.jpnprd01.prod.outlook.com (20.177.100.83) by
 TY2PR01MB3754.jpnprd01.prod.outlook.com (20.178.132.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 02:58:17 +0000
Received: from TY2PR01MB3259.jpnprd01.prod.outlook.com
 ([fe80::cd65:4f84:1fb2:645f]) by TY2PR01MB3259.jpnprd01.prod.outlook.com
 ([fe80::cd65:4f84:1fb2:645f%2]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 02:58:17 +0000
From:   "y-goto@fujitsu.com" <y-goto@fujitsu.com>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: RE: [RFC PATCH 3/3] libnvdimm, MAINTAINERS: Subsystem Profile
Thread-Topic: [RFC PATCH 3/3] libnvdimm, MAINTAINERS: Subsystem Profile
Thread-Index: AQHUfKDgVS5dBKbJUEOXJFTuR9ziJqVRsIjA
Date:   Fri, 16 Nov 2018 02:58:16 +0000
Message-ID: <TY2PR01MB32595232F5179F94D5ED203590DD0@TY2PR01MB3259.jpnprd01.prod.outlook.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: c311f20bbc5e4072a708b4891a14b6bc
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=y-goto@fujitsu.com; 
x-originating-ip: [180.43.167.179]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB3754;6:KwlhxgT85qVA9udSalb0ERFmawD4T+Ep12zgEiCuAVIFC1nHYA8ZEUnTy35yygE8v0k29X+pAOBi9BvQ3fb52beb2VAJAuJAGdbzQrrch2SbAwIBvN+s7hwNeHLJKmY6sTTjK/CzUP4oWTiyhG/BA6ti/g7EaCSHelPbYGamCBv77vUCsa8J8Ldtx2ZuwM5e2P4piKsYQaYXFwzeHdwuot74XAQ7ercvHxZIiXWhbhZgt2K0BEyo9zfM0C3o6vlUTnPwA26HvpDxFBZhCkrGgRAO+BYGjCfzQMQsQ0KiOCPwA3VoVNQykW4u4AzgRjLpf7FiK7OqkRiu0F8Jox11D6RQZBSCK1M8BLYkalrJFmZaFRNGSzZJk5Wp8gokL2UNY7sKDdiYQaDOMOGwnkadh5j0aoe9/mRzJiTgRyg51jr3DkHHJ+jKjMzPkCS2i4UPPVtuFy2ZecOshciyoXSerQ==;5:J51VQUqaM9Lt3kk+lmV5GeVF2+M4d6oXIx0x2mNzI81i0nXzKnpc3BtvSK+TDKFyJy1uNzBOIi8snhBMOi1Q0U48jTgAHRRjd9tjfBL1RZx2qg7PrDzuhrO1HDQgilmiEOE+bl9O7+ZEnFBP4IkNqs/Y5/QJCApwUP7srIiLSbA=;7:/2YyMTyUSbPKB/FLGvFzcoLe37eU/8gYWefTWlC+jgUWfe4L5xT9p/jA2DHQsLKfKhXYjRKSGbMCqo3+VknXc5g1dVPAcy8zvJULH9jkwRp/N/zR1kIC3nFkDN1Y7Q0iyt6AxnmaqeNqn8cswu3crg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dc427be3-d03b-4c1e-9dab-08d64b6f5bb1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:TY2PR01MB3754;
x-ms-traffictypediagnostic: TY2PR01MB3754:
x-microsoft-antispam-prvs: <TY2PR01MB37548C78216920000B0A4A9190DD0@TY2PR01MB3754.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231415)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB3754;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB3754;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(51444003)(199004)(189003)(305945005)(7736002)(71190400001)(74316002)(8936002)(6506007)(102836004)(81166006)(81156014)(66066001)(229853002)(8676002)(2501003)(217873002)(4326008)(5660300001)(71200400001)(7696005)(85182001)(2900100001)(33656002)(76176011)(105586002)(256004)(2906002)(25786009)(6246003)(106356001)(478600001)(486006)(11346002)(26005)(6116002)(110136005)(86362001)(345774005)(55016002)(316002)(9686003)(97736004)(476003)(3846002)(99286004)(186003)(6436002)(53936002)(446003)(54906003)(68736007)(14454004)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB3754;H:TY2PR01MB3259.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: h1sSJJaJNdkqkmgcsy1V5HBG6ktv9B42eOuHeMluFl8nr1MQqeEiOYSQLDmhoaxRllvkvpwSjvSBz1/Ei2j+cYUVfjSgN5yZoq1zCHiQ4NLT1RnSqLtlaQBs++opueS3eHthAjULFu+n2a0CHC2v54GlF5CTjMR5gQvU5FLOaNOF+iLwBxIlJrAU6d65dFSHEUB8UxW84UTDVEq7QI28PbXCB9kcoTcXz3uQA3s+5n+faEmLru/5Y4nBIdYQsFLlBXx5VCy/TddH3TElpauManZsqhqRusHEnoNvP3Tu3Vv5+tcryBGemK0XwX51ctie2RYHqixqgOflWaTRZk26Zlml1NhJU7Y7cj73slgBTYQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc427be3-d03b-4c1e-9dab-08d64b6f5bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 02:58:16.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbi1zYW4sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4gSSBoYXZlIG9uZSBjb21t
ZW50Lg0KDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9udmRpbW0vc3Vic3lzdGVtLXByb2ZpbGUu
cnN0IHwgICA4NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA0ICsNCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgOTAgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
bnZkaW1tL3N1YnN5c3RlbS1wcm9maWxlLnJzdA0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vbnZkaW1tL3N1YnN5c3RlbS1wcm9maWxlLnJzdCBiL0RvY3VtZW50YXRpb24vbnZkaW1t
L3N1YnN5c3RlbS1wcm9maWxlLnJzdA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAw
MDAwMDAwMDAwMDAuLmQzNDI4YmU3NTI4ZQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vbnZkaW1tL3N1YnN5c3RlbS1wcm9maWxlLnJzdA0KPiBAQCAtMCwwICsxLDg2IEBA
DQo+ICtMSUJOVkRJTU0gU3Vic3lzdGVtIFByb2ZpbGUNCj4gKz09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiArDQo+ICtPdmVydmlldw0KPiArLS0tLS0tLS0NCj4gK1NvLCB5b3UgaGF2ZSBy
ZWNlbnRseSBiZWNvbWUgYSBtYWludGFpbmVyIG9mIHRoZSBMSUJOVkRJTU0gc3Vic3lzdGVtLA0K
PiArY29uZG9sZW5jZXMsIGl0IGlzIGEgdGhhbmtsZXNzIGpvYiwgaGVyZSBpcyB0aGUgbGF5IG9m
IHRoZSBsYW5kLiBUaGUgZ2l0DQoNCkhlcmUsIEkgdGhpbmsgdGhhdCBtb3JlIHBvc2l0aXZlIHNl
bnRlbmNlIGlzIGRlc2lyYWJsZSB0byBlbmNvdXJhZ2UgbmV3IGNvbWVyLg0KDQpDZXJ0YWlubHks
IEkgY2FuIGltYWdpbmUgdGhhdCBtYWludGFpbmVyIGlzIGhhcmQgYW5kIHRvdWdoIHdvcmssDQpi
dXQgSSBiZWxpZXZlIGl0IGlzIGdyZWF0IHdvcmsuDQpFdmVuIGlmIHRoaXMgaXMgaXJvbnkgb3Ig
am9rZSwgdGhlbiBpdCBtYXkgYmUgY2F1c2Ugb2YgbWlzcy11bmRlcnN0YW5kaW5nDQooZXNwZWNp
YWxseSwgbm9uLW5hdGl2ZSBFbmdsaXNoIHNwZWFrZXIgbGlrZSBtZS4pDQoNCkluIGFkZGl0aW9u
LCBuZXcgY29taW5nIGRldmVsb3BlciBpcyBzb21ldGltZXMgbmVydm91cyANCnRvIHBvc3QgbmV3
IG1haWwvcGF0Y2guIElmIHRoaXMgdGV4dCB3aWxsIGJlIGNoYW5nZWQgZm9yIG5ldyBjb21lciwg
DQp0aGVuIEkgdGhpbmsgdGhpcyB0ZXh0IHdpbGwgYmUgZ29vZCB0byBlbmNvdXJhZ2UgdGhlbS4N
ClNvLCBJIHRoaW5rIG1vcmUgcG9zaXRpdmUgZXhwcmVzc2lvbiBpcyBkZXNpcmFibGUuDQoNClRo
YW5rcywNCg0K
