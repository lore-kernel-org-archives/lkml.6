Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829E9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41187218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rjsuPw5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBFWR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:17:58 -0500
Received: from mail-eopbgr790055.outbound.protection.outlook.com ([40.107.79.55]:16746
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfBFWR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZGKf6+QXIVPy+pUAuA0wHb+fYdi5amP1g6wx54gGD0=;
 b=rjsuPw5ypeCRqkYlMcUy1AlYMZNjCXJKoK5CLyZ6fbPhvS/qtISg66vtNUajTcDnZGg9JgeNZ7FXIZIM6+66kXPCU9DnAZqE3na+D0Ec0rKvb1hn1tz4baVfr/JxSvdwPW92W/pwc8P0Zh22GpcTNI/gJ0eHZQdWKZtbyCteniA=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4866.namprd05.prod.outlook.com (52.132.15.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.15; Wed, 6 Feb 2019 22:17:46 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::52e:b645:417c:a4cf]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::52e:b645:417c:a4cf%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 22:17:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH 1/6] vmw_balloon: bump version number
Thread-Topic: [PATCH 1/6] vmw_balloon: bump version number
Thread-Index: AQHUvdqzIjtzT9t97UifPzgt+4rp6aXS+kOAgABCQACAAAdTgIAAFAaA
Date:   Wed, 6 Feb 2019 22:17:46 +0000
Message-ID: <D6E44AB3-39AB-41C2-83E3-0ABC910B66BE@vmware.com>
References: <20190206051336.2425-1-namit@vmware.com>
 <20190206051336.2425-2-namit@vmware.com> <20190206164245.GA8466@kroah.com>
 <83759B2D-329A-4CBA-84A4-0511398D1AB2@vmware.com>
 <20190206210605.GA4599@kroah.com>
In-Reply-To: <20190206210605.GA4599@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4866;20:i6e395L7IQ7AqHmjf0TcWqCBxtlqedllv7keQPJQwACsN/NYX8EL0/2WMWaW2hdHjdabbCgziysJ2Rg2+qL5ffF36CYsSPLUjMZBo59sNCcNTFjk5gFDhgUJSRzTmrtoarSiCqWuA/QKi5UMCYksxJYXOCGN4op+r/YT9VN1DLo=
x-ms-office365-filtering-correlation-id: 6e8ee815-de86-4cd8-e19c-08d68c80ec34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4866;
x-ms-traffictypediagnostic: BL0PR05MB4866:
x-microsoft-antispam-prvs: <BL0PR05MB48666061AAE73DD2E4E89F00D06F0@BL0PR05MB4866.namprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(39860400002)(396003)(189003)(199004)(478600001)(476003)(36756003)(99286004)(256004)(71190400001)(71200400001)(76176011)(33656002)(53936002)(107886003)(102836004)(6116002)(81166006)(8676002)(81156014)(4326008)(3846002)(25786009)(82746002)(6246003)(97736004)(14444005)(53546011)(6506007)(106356001)(229853002)(105586002)(26005)(186003)(446003)(2906002)(6486002)(83716004)(6512007)(6436002)(86362001)(66066001)(305945005)(316002)(7736002)(8936002)(68736007)(6916009)(93886005)(14454004)(2616005)(11346002)(486006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4866;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WBIO1dEG/H4iB18Qz5McFgkw9w9k1pSDLKXE4of6wnirbhKCY6rDG3MPIiDAjhRyP4/CV3WQeILG2cKZYDUNa2tjJbxzKJ91i8x/DOC/fkVJv4d5DV7xpy5WqCV9u4uDsXf+WLh7cL1atqMC63Bj0OO7sWNE/TA4FRYTgwMRSgy7Tps7e7j875nmgqGbpYYqu3cLS49n6jA5cH46Y2vruCl21+MsyLt8fG/tLh2m2RvfS4HozlH5JmXOzOSgFf6Csx8J/XZI+YHtTnJ9Uvx1bqZ7oZ4KuKENh7Tp7hmd2uVZJSA4OXQT7TqONv1Nbrfh67RLWDvRXluVF72DiQzjKGmLxSoufA4p/Jk/k4uK6KAFoZFVtUbeBQezDV7AI1JhKVSNpm0K/g2ygVHIfoi67Iu0OuOQGRXjRCdwLML9Pg0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA747C83ED7BF3489E58579C7B02FDF1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8ee815-de86-4cd8-e19c-08d68c80ec34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 22:17:46.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgNiwgMjAxOSwgYXQgMTowNiBQTSwgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEZlYiAwNiwgMjAxOSBh
dCAwODozOTo1MlBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIEZlYiA2LCAyMDE5
LCBhdCA4OjQyIEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsIEZlYiAwNSwgMjAxOSBhdCAwOToxMzozMVBN
IC0wODAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+PiBGb2xsb3dpbmcgcmVjZW50IGNoYW5nZXMu
DQo+Pj4+IA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gZHJpdmVycy9taXNjL3Ztd19iYWxsb29uLmMgfCAyICstDQo+Pj4+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+PiANCj4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jIGIvZHJpdmVycy9taXNj
L3Ztd19iYWxsb29uLmMNCj4+Pj4gaW5kZXggZjgyNDBiODdkZjIyLi43Mjk0ZjMwNTc1M2YgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jDQo+Pj4+ICsrKyBiL2Ry
aXZlcnMvbWlzYy92bXdfYmFsbG9vbi5jDQo+Pj4+IEBAIC0zNCw3ICszNCw3IEBADQo+Pj4+IA0K
Pj4+PiBNT0RVTEVfQVVUSE9SKCJWTXdhcmUsIEluYy4iKTsNCj4+Pj4gTU9EVUxFX0RFU0NSSVBU
SU9OKCJWTXdhcmUgTWVtb3J5IENvbnRyb2wgKEJhbGxvb24pIERyaXZlciIpOw0KPj4+PiAtTU9E
VUxFX1ZFUlNJT04oIjEuNS4wLjAtayIpOw0KPj4+PiArTU9EVUxFX1ZFUlNJT04oIjEuNi4wLjAt
ayIpOw0KPj4+IA0KPj4+IFBsZWFzZSBqdXN0IGRyb3AgdGhpcyBwb2ludGxlc3MgbGluZSwgaXQg
bWVhbnMgbm90aGluZyBhbmQgaXMgYWx3YXlzIG91dA0KPj4+IG9mIGRhdGUuICBJdCdzIGJlZW4g
cmVtb3ZlZCBmcm9tIG1hbnkgb3RoZXIgZHJpdmVycywgYW5kIEkgcmVhbGx5IGRvbid0DQo+Pj4g
d2FudCB0byBzZWUgaXQgY29tZSBiYWNrLg0KPj4+IA0KPj4+IFlvdXIgZHJpdmVyICJ2ZXJzaW9u
IiBpcyB0aGUga2VybmVsIHZlcnNpb24sIGZ1bGwgc3RvcC4gIFRoYXQncyBhbGwgeW91DQo+Pj4g
bmVlZCB0byBldmVyIHdvcnJ5IGFib3V0Lg0KPj4gDQo+PiBJIHVuZGVyc3RhbmQsIGFuZCBJIHdp
bGwgaW5mb3JtIHRob3NlIHdobyBhc2tlZCBmb3IgdGhlIHZlcnNpb24gYnVtcC4NCj4+IA0KPj4g
SGF2aW5nIHNhaWQgdGhhdCwgSSBkbyBub3Qgc2VlIGEgcmVmZXJlbmNlIGZvciB0aGlzIHBvbGlj
eS4gSSB1bmRlcnN0YW5kDQo+PiB0aGF0IHlvdSByZW1vdmVkIHRoZSBNT0RVTEVfVkVSU0lPTiBm
cm9tIGluLWtlcm5lbCBkcml2ZXJzLCBidXQgSSBhbHNvIHNlZQ0KPj4gdGhhdCB5b3UgYWNjZXB0
ZWQgc2V2ZXJhbCBkcml2ZXJzIGxhc3QgeWVhciB0aGF0IHVzZWQgTU9EVUxFX1ZFUlNJT04uDQo+
IA0KPiBJIG1lc3NlZCB1cCwgYW5kIHdpbGwgYmUgZ2xhZCB0byB0YWtlIHBhdGNoZXMgdG8gcmVt
b3ZlIHRoZW0uICBVc3VhbGx5DQo+IHRoYXQncyB0aGUgbGFzdCB0aGluZyBJIHJlbWVtYmVyIHRv
IGNoZWNrIHdoZW4gcmV2aWV3aW5nIHBhdGNoZXMsIEkNCj4gY2FuIGFsd2F5cyB1c2UgdGhlIGhl
bHAgOikNCj4gDQo+IEFsc28sIEkgb25seSByZWNlaXZlZCAxIHBhdGNoIGluIHRoaXMgc2VyaWVz
LCBkaWQgc29tZXRoaW5nIGdvIHdyb25nDQo+IHdpdGggdGhlIHNlbmRpbmcgb2YgaXQ/DQoNCkVy
ci4gVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cuIEkgZ3Vlc3MgdGhhdCB0aGF0IEkgbWVzc2Vk
IHVwIHRoZSBnaXQtc2VuZA0KdHJ5aW5nIHRvIGF2b2lkIGNj4oCZaW5nIHBhdGNoIGF1dGhvciB3
aG8gZ290IGhpcyBlbWFpbCBhZGRyZXNzIGRlYWN0aXZhdGVkLg0KDQpJIHdpbGwgcmVzZW5kLg0K
DQo=
