Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA262173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xFTHnZQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbfA1QtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:49:21 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:10343 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388906AbfA1QUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:20:51 -0500
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="25857417"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jan 2019 09:20:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 28 Jan 2019 09:18:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhug1z1s4FVx0eNSFMTYBWHNLbIXcbx8IXDf9mtqtvc=;
 b=xFTHnZQ07J9P7X78g35Ndsf7SJHJlIb8XKnXW7Ik4lG8frZwjPzJpIIMiIWTu4Za5QlxOqbZXUW8Ulp5XfPiaGGpns/fclYlnNxyHGloU93Yw6WKWgRDnLVRdWW1I+H5xV+QBDSRYgEBD2nLoUq59G0L9BWUqJcc+UG68lXZfi8=
Received: from SN6PR11MB2767.namprd11.prod.outlook.com (52.135.92.154) by
 SN6PR11MB3055.namprd11.prod.outlook.com (52.135.126.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Mon, 28 Jan 2019 16:18:33 +0000
Received: from SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::509:4b08:4635:d702]) by SN6PR11MB2767.namprd11.prod.outlook.com
 ([fe80::509:4b08:4635:d702%4]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 16:18:33 +0000
From:   <Don.Brace@microchip.com>
To:     <colin.king@canonical.com>, <don.brace@microsemi.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <esc.storagedev@microsemi.com>, <linux-scsi@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: hpsa: clean up two indentation issues
Thread-Topic: [PATCH] scsi: hpsa: clean up two indentation issues
Thread-Index: AQHUsmYAwKvgguQQg0uVxsaSqUOTEKXE5SAA
Date:   Mon, 28 Jan 2019 16:18:33 +0000
Message-ID: <SN6PR11MB2767CD2DC52BC47972BF7E33E1960@SN6PR11MB2767.namprd11.prod.outlook.com>
References: <20190122151830.7230-1-colin.king@canonical.com>
In-Reply-To: <20190122151830.7230-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR11MB3055;6:/o6UQ9PtqDBie08kvOb3cs9xrKt0pACfhsnEijS5PvecQ26skQFDsfOdATBkDhoAPl1bzbP/A+N5aUaWwl+lSb3YQjiEKCSz7W/wVYRJ1S9sYvv3lF4J0Z9nnmpM5ptx3jxk8cSf8UiMdfgUzFBvofiwBmGQ7mUTm050+nrFoilz45R/khxBzlCCA4+vtF31ORfF25n8ZnaV+gRBx1Ib9VR+OMnP1q8/ibCG6BDEB0qoSuTc/Qqj7xY4ivt8cn2Fi2LQZ8xLdz7YqMfx6+nCU+xp7T+2pjB3na1YPJtgAFlw48jCX1Xu8V7JTdQIo++MuGh2i4+pb8CCmV7hgBrfZ1o25kqD5pJNO719dbqRJc/jgQiS7U7mAB1odK0sk3IXRU8Ky6TvpmMPOdbPE5F5dvCFdcaHx52V725SyUA997j7zZTzCIBBI1PG0Uzo94++LuCJKZ5XyoYBwjUBkYhI6A==;5:aGkrXjiqeOjlZWZ0Lwx/3B+HxKeZXJe31WpjBVcSn8g8UWzTo1FVX0LgKJzeDstY68fJY4fP7sZ8HUHmVVOfxYC17/0VwH0iua0N76EWBkdC0g9dFzie7xvc/6ecpfHc3eBfDdn4th+HgKGKbNmSChjKBkA0sTAnEm8R9xJLoqW/d/b7aSXElhzZJepBxHOnoo9/rauPWwFNjRYR3Qq74g==;7:RFM67IvvTKFZcJIxJ/w0XYkYWFcLRww1Hii6Gs/TSJ3IUwLVRsQSzkSwVZHD8Z/GA5YQ6mmQSFHQYCPQh4tL0wAaGAAAqvQ/JYjXdv5QoumjDr12hbH+lQ1WHzZDLrHBnyhKxpYT4uGFgIYGwqexCQ==
x-ms-office365-filtering-correlation-id: 86474259-9dac-43b0-238a-08d6853c3ff7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR11MB3055;
x-ms-traffictypediagnostic: SN6PR11MB3055:
x-microsoft-antispam-prvs: <SN6PR11MB30553D74EF96C70841005836E1960@SN6PR11MB3055.namprd11.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(396003)(39860400002)(13464003)(189003)(199004)(2906002)(86362001)(6246003)(53936002)(105586002)(14454004)(71190400001)(7696005)(478600001)(229853002)(72206003)(66066001)(4326008)(25786009)(71200400001)(2201001)(76176011)(9686003)(106356001)(316002)(446003)(186003)(81166006)(81156014)(53546011)(55016002)(486006)(54906003)(11346002)(476003)(256004)(102836004)(6506007)(74316002)(68736007)(110136005)(33656002)(6436002)(305945005)(7736002)(8676002)(99286004)(6116002)(3846002)(26005)(97736004)(8936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3055;H:SN6PR11MB2767.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UtJXJNyzjDDzCusjGfk1K05/Fxps0Fqg2Y4soc0irS8WPrRpeCxgMFa85BLk3NpMKfAC2aRqSQqf0lgqJjsAGlpxdl842x/8NsPC8ruQY0MEJI3xLLMI/3L0WFSvkiQQ/vPPqhTJ7QYzAfhv2zR0sLofYzPZvHKrkVjWfNnns5T6aOYRW2A+IwsFh6BQ1Am/5CB/FyWzb2Uqx8oUF7rzPf2pOjzppIZCdYu5FmYRR9T7SpEcMAcPI/30ayEsUV9mljp0n/TlYl7qdCw5K3hLlDOgDuzvmOQ+lWIuhntEh88dXmmecZaHd0flskEw0qXYLHuDYxY12D1tIIe//Qi+w8Z2yEVdC9V8K9ru9iBgDC02fH/3RCV7MbXAB1JXd7hXJDNfeH3ryUq8mPSL2pACooNpaWJt6tAEpMZ/Id4QQkI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 86474259-9dac-43b0-238a-08d6853c3ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 16:18:33.5785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3055
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogbGludXgtc2NzaS1vd25lckB2Z2Vy
Lmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1zY3NpLW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24g
QmVoYWxmIE9mIENvbGluIEtpbmcNClNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMjIsIDIwMTkgOTox
OSBBTQ0KVG86IERvbiBCcmFjZSA8ZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb20+OyBKYW1lcyBFIC4g
SiAuIEJvdHRvbWxleSA8amVqYkBsaW51eC5pYm0uY29tPjsgTWFydGluIEsgLiBQZXRlcnNlbiA8
bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+OyBlc2Muc3RvcmFnZWRldkBtaWNyb3NlbWkuY29t
OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZw0KQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtQQVRDSF0g
c2NzaTogaHBzYTogY2xlYW4gdXAgdHdvIGluZGVudGF0aW9uIGlzc3Vlcw0KDQpGcm9tOiBDb2xp
biBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpUaGVyZSBhcmUgdHdvIHN0
YXRlbWVudHMgdGhhdCBhcmUgaW5kZW50ZWQgaW5jb3JyZWN0bHkuIEZpeCB0aGVzZS4NCg0KU2ln
bmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCi0t
LQ0KIGRyaXZlcnMvc2NzaS9ocHNhLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2hw
c2EuYyBiL2RyaXZlcnMvc2NzaS9ocHNhLmMgaW5kZXggZmY2N2VmNWQ1MzQ3Li41Mjg0NDQ0ZmRk
MTAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Njc2kvaHBzYS5jDQorKysgYi9kcml2ZXJzL3Njc2kv
aHBzYS5jDQpAQCAtMTMyNyw3ICsxMzI3LDcgQEAgc3RhdGljIGludCBocHNhX3Njc2lfYWRkX2Vu
dHJ5KHN0cnVjdCBjdGxyX2luZm8gKmgsDQogCQlkZXZfd2FybigmaC0+cGRldi0+ZGV2LCAicGh5
c2ljYWwgZGV2aWNlIHdpdGggbm8gTFVOPTAsIg0KIAkJCSIgc3VzcGVjdCBmaXJtd2FyZSBidWcg
b3IgdW5zdXBwb3J0ZWQgaGFyZHdhcmUgIg0KIAkJCSJjb25maWd1cmF0aW9uLlxuIik7DQotCQkJ
cmV0dXJuIC0xOw0KKwkJcmV0dXJuIC0xOw0KIAl9DQogDQogbHVuX2Fzc2lnbmVkOg0KQEAgLTQx
MTAsNyArNDExMCw3IEBAIHN0YXRpYyBpbnQgaHBzYV9nYXRoZXJfbHVuX2luZm8oc3RydWN0IGN0
bHJfaW5mbyAqaCwNCiAJCQkibWF4aW11bSBsb2dpY2FsIExVTnMgKCVkKSBleGNlZWRlZC4gICIN
CiAJCQkiJWQgTFVOcyBpZ25vcmVkLlxuIiwgSFBTQV9NQVhfTFVOLA0KIAkJCSpubG9naWNhbHMg
LSBIUFNBX01BWF9MVU4pOw0KLQkJCSpubG9naWNhbHMgPSBIUFNBX01BWF9MVU47DQorCQkqbmxv
Z2ljYWxzID0gSFBTQV9NQVhfTFVOOw0KIAl9DQogCWlmICgqbmxvZ2ljYWxzICsgKm5waHlzaWNh
bHMgPiBIUFNBX01BWF9QSFlTX0xVTikgew0KIAkJZGV2X3dhcm4oJmgtPnBkZXYtPmRldiwNCi0t
DQoyLjE5LjENCg0KQWNrZWQtYnk6IERvbiBCcmFjZSA8ZG9uLmJyYWNlQG1pY3Jvc2VtaS5jb20+
Pw0KDQo=
