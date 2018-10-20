Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F563C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A21A21534
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="qrnW1NBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A21A21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeJUETC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:19:02 -0400
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:54311
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725746AbeJUETC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX7FhOfy1bH4yL1id4zIS+jyT0e8+80TdRZcovIdYdw=;
 b=qrnW1NByPZQw5Hk2MwbbbxEMTzg2VJHlPQ+MCDexcAJ60CfgZBWNmi7fWE9C39EaSnh3HP9U5thyZ0ET5tvx7jvfrej6i0FmqMW9s/8HbJlglZleuPFoyBQ6hwxBupswLF4A/1lRpH440gbSzydylthuvi6/Z0rAhOu2Es5/Yt4=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2544.namprd13.prod.outlook.com (52.135.96.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.10; Sat, 20 Oct 2018 20:07:23 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::205a:69c2:1cf5:b475%3]) with mapi id 15.20.1273.012; Sat, 20 Oct 2018
 20:07:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "gnomes@lxorguk.ukuu.org.uk" <gnomes@lxorguk.ukuu.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Tim.Bird@sony.com" <Tim.Bird@sony.com>
CC:     "mishi@linux.com" <mishi@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the  contact
 email address
Thread-Topic: [Ksummit-discuss] [PATCH 6/7] Code of Conduct: Change the
        contact email address
Thread-Index: AQHUaLCDJL25qPG/ckiDnC17q//YbQ==
Date:   Sat, 20 Oct 2018 20:07:23 +0000
Message-ID: <be343ff93c03fd40b524ae6fdc34448dc947ad82.camel@hammerspace.com>
References: <20181020134908.GA32218@kroah.com>
         <20181020135118.GG32218@kroah.com> <20181020192845.48b8b860@alans-desktop>
         <ECADFF3FD767C149AD96A924E7EA6EAF80528627@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF80528627@USCULXMSG01.am.sony.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2544;6:iUCHiZ13IgD+JDO1Y9qx5UOkDe3zT6bGXxtEs2J0GYU5YUU4nvMYh85VqF7ABSRD+zqQia/r5tcOfQ6CqT++KFykO9DJJIgB+o06lxkrnqAfUwxpDrrV7EVhN61lLFGmUFsxJIjQoforOzOGAo07li/7DtxoM3GCc+wLkeDyAAkS2pjyNhMKMS/I8EhE6DuMB6C1miId/rIdDlcrWJgBXbutOxyd5LZ2wiVpOGMrTcg6kDpWF2/0OA9ZZ2WmMGJ4Z7nqnNL3M7MKGVNDHDvSe8JAh6Z7ncbN06rg/uGBG4P6W6gf+WKhbFbIL9gVhSNmKho8vmpa3Wu2WfcxdV4lhlC/i3siCBrM97lH1APqAfcoKccoxJTdtIY63tTplIqgpCxYpgBAEP9TTawMS4+fA1AYzDfYjqBlbQWxzuCP8MijIWJym4jStZC33ANXwiPE8dRwJ8oxliE6WwQ9ubrdPA==;5:LA+ep1FgUw6otrt0vKLHvhtObi9sbEh05zCnEkObtlUu1XPNZOHJsgOkKJLOKc632eugFrzCHZejAZpoQPk8mX5NA4cLFOMycdDQQXYTOlOeprzcXLzWWasuXy0oubz/h7/SZ5jcoSXyqlhqDjZmwEavt6MxdfZKnEh2rTqpols=;7:NVfahwidV5kMHij3JISWaRNn5ymPxpqTSWpUZqkhjxAjjNO0heQaNOrx0/h91Qgq6xWxA3K4PLNKZBz0A/r0qrqT9N7aF8Ro7qjdyaOUzGSjTPVjy41Kxs6xlX+Ikc8sJIDC21oE5rytO+6cFvBxXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e3958e35-03aa-4e85-d7c4-08d636c7a64c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2544;
x-ms-traffictypediagnostic: SN6PR13MB2544:
x-microsoft-antispam-prvs: <SN6PR13MB254432046D04060C052D27E8B8FA0@SN6PR13MB2544.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(182409339516656)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR13MB2544;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2544;
x-forefront-prvs: 0831C25939
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(71200400001)(71190400001)(14454004)(54906003)(106356001)(118296001)(105586002)(86362001)(4326008)(53936002)(110136005)(2201001)(6512007)(2900100001)(99286004)(25786009)(6116002)(3846002)(76176011)(6506007)(2906002)(6246003)(102836004)(97736004)(4001150100001)(229853002)(36756003)(6436002)(5660300001)(316002)(6486002)(26005)(256004)(93886005)(186003)(5250100002)(446003)(2616005)(66066001)(8936002)(11346002)(7736002)(305945005)(476003)(486006)(68736007)(81166006)(81156014)(2501003)(223583001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2544;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 08FHBA5tzDiDQwLfEITjYrPQND5FBIsUBUdv69TdzRDQUaoQATGD4dd6SjKWnH7i6gYdFWKGthRUnM86eD87ySEBUni9+s730DoAruTlfKPg6OPnRm6oDUryE61qoGY80NG8AFfRw5IlJ8XmzMowqKojJSRrCLRXL0dIVg9fVJs3jLyLbQuhbUyQ+R8W6w+TGkVb8MBZGauvhb19E6TakPUGj2TJst7J88SBrTzfrcicSm0Tb5F39iarJNCOPN9YWJcI+0dz3G8nRHrLpPkLTfYotDnlqqOJoqesF9pyGnvpHciWJazdh0OXONTooQAKL7vx56rb1PXmpb89tI7f8dYdE5JB9KCfF7rzwISKnbo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A852B5DE9DF9C469E13F242EA1BC133@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3958e35-03aa-4e85-d7c4-08d636c7a64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2018 20:07:23.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE4LTEwLTIwIGF0IDE5OjI0ICswMDAwLCBUaW0uQmlyZEBzb255LmNvbSB3cm90
ZToNCg0KPiBUaGUgc2NvcGUgb2YgdGhlIGNvZGUgb2YgY29uZHVjdCBiYXNpY2FsbHkgbWVhbnMg
dGhhdCBpdCBjb3ZlcnMNCj4gb25saW5lIGludGVyYWN0aW9ucyAoY29tbXVuaWNhdGlvbiB2aWEg
bWFpbGluZyBsaXN0LCBnaXQgY29tbWl0cw0KPiBhbmQgQnVnemlsbGEpLiAgTm90IHRvIGJlIGZs
aXBwYW50LCBidXQgdGhvc2UgYXJlIGhhcmRseSBtZWRpdW1zDQo+IHRoYXQgYXJlIHN1c2NlcHRp
YmxlIHRvIGV4ZWN1dGluZyBwaHlzaWNhbCBhYnVzZS4gIEFsc28sIHRoZXkgYXJlDQo+IGFsbCBt
ZWRpdW1zIHRoYXQgbGVhdmUgYSBwZXJzaXN0ZW50LCBwdWJsaWMgdHJhaWwuICBTbyBJIGRvbid0
IHRoaW5rDQo+IHRoZQ0KPiBjb21wYXJpc29uIGlzIHZlcnkgYXB0IGhlcmUuDQo+ICAtLSBUaW0N
Cg0KSWYgdGhhdCBpcyB0aGUgY2FzZSwgdGhlbiB3aHkgZG9lcyB0aGlzIG5lZWQgdG8gZ28gaW50
byB0aGUgTGludXgNCmtlcm5lbCBpbiB0aGUgZmlyc3QgcGxhY2U/IFRoZSBtYWlsaW5nIGxpc3Rz
LCB0aGUga2VybmVsLm9yZyBnaXQNCnJlcG9zaXRvcnksIGFuZCBidWd6aWxsYSBwcmVzdW1hYmx5
IGFsbCBoYXZlICJ0ZXJtcyBvZiB1c2UiIHBhZ2VzIHRoYXQNCmNvdWxkIHNwZWNpZnkgdGhlIGV4
cGVjdGVkIGJlaGF2aW91ciB2ZXJ5IGV4cGxpY2l0bHksIGFuZCBjb3VsZCBzcGVjaWZ5DQpob3cg
YXJiaXRyYXRpb24gd29ya3MgYXMgcGFydCBvZiB0aG9zZSB0ZXJtcyBvZiB1c2UgKGFuZCBpZiBl
bmZvcmNlbWVudA0KaXMgcmVxdWlyZWQsIHRoZW4gaXQgY291bGQgc3BlY2lmeSBsZWdhbCB2ZW51
ZXMgZXRjKS4NCg0KSU9XOiBpZiB0aGUgc2NvcGUgaXMganVzdCBjb21tdW5pY2F0aW9uIG9ubGlu
ZSwgdGhlbiBJIHdvdWxkIHRoaW5rDQp0aGVyZSBhcmUgYmV0dGVyIHRvb2xzIGZvciB0aGF0Lg0K
DQpQdXR0aW5nIGEgY29kZSBvZiBjb25kdWN0IGludG8gdGhlIGtlcm5lbCBjb2RlIGl0c2VsZiB3
YW50cyB0byBiZQ0KanVzdGlmaWVkIGJ5IG1vcmUgdGhhbiBqdXN0IHJlZ3VsYXRpbmcgb25saW5l
IGJlaGF2aW91ci4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
