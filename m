Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39732208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="o8IdY+UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39732208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936412AbeFOUjC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:39:02 -0400
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:58925
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755493AbeFOUjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sHNsmM49A2DKHYKwNWOvrFe7XswX6om0+LUbLWF/U0=;
 b=o8IdY+UZw9XUO/BpiyYDt65o2jNXtG9aDZmKATJv23HYFEcN+yOh8nrsgUJrervO8L9k5GL5E0gXOYQaMHed0DUywTCi9xVluGD4Tg/9jfnFRJ5mrEp0Js8xfNMplAcYntg/sCOGa0L+ZATIhQBtIfmqgnxdsl+4q/nizHp+U3E=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4055.namprd05.prod.outlook.com (52.135.199.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Fri, 15 Jun 2018 20:38:58 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%3]) with mapi id 15.20.0884.010; Fri, 15 Jun 2018
 20:38:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 6/7] vmw_balloon: update copyright message
Thread-Topic: [PATCH v2 6/7] vmw_balloon: update copyright message
Thread-Index: AQHUA1rMO9cx543LJ0SFW/MABZa0SKRfOSaAgAACqQCAAo46AIAAAQQA
Date:   Fri, 15 Jun 2018 20:38:57 +0000
Message-ID: <5151EA1B-D065-44D1-995C-47B791F574E1@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-7-namit@vmware.com> <20180614052413.GB29739@kroah.com>
 <F8F02A0A-133F-458A-9492-30C3ABD8C592@vmware.com>
 <81730.1529094918@turing-police.cc.vt.edu>
In-Reply-To: <81730.1529094918@turing-police.cc.vt.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4055;7:ZBgZOx1maIzK13i8TNC0LLM8Cut74gjbN0VJcm6FF5+hEg9d9THcDQsw8To5nyIiFhCcQje9QYs73n55V114ujhDk7Z7wKU0h3TNVw6FSTTohd+FJyL3boveaGKMpRuDIzTz2cn2w6I30BOdGbHG9h7Yq72qU85ToUnmTot4QgrtH9zb64jB7qOJXx2UKNPwOfZULxZdeErEpFipvRd2ljzBW+rqlDXBMLp+NwxeCjsQ+dxSX/srIgHkJ0wALqFb;20:z6hZskJCNmdPuxcLHKBVxz2N32JelKNmZ2g1Osfdjwn/PhNpZnSKd5EvonXKAP6xKzwvIkoxXkQlBM4ivtitAqqmzQdOUSNBZlwcPULtZnc2n34MKVafibCNQZqI3TJZg6hNcgM11+rkBXm2N3WIlhSb3NrwzyLORnBWFg0IKtM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 97feb2e4-5061-42ef-9d62-08d5d3000508
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4055;
x-ms-traffictypediagnostic: BYAPR05MB4055:
x-microsoft-antispam-prvs: <BYAPR05MB4055D347ACFDCC18E19D70B7D07C0@BYAPR05MB4055.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4055;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4055;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(199004)(189003)(186003)(26005)(4326008)(102836004)(14454004)(66066001)(81166006)(7736002)(5250100002)(8676002)(81156014)(6506007)(2900100001)(6116002)(2501003)(33656002)(2351001)(105586002)(305945005)(68736007)(3660700001)(3280700002)(82746002)(3846002)(2906002)(76176011)(5660300001)(86362001)(6512007)(99286004)(36756003)(25786009)(486006)(6436002)(2616005)(229853002)(93886005)(11346002)(476003)(54906003)(316002)(8936002)(6486002)(106356001)(478600001)(53936002)(446003)(6246003)(2171002)(97736004)(83716003)(5640700003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4055;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IwWkbse4hWSpEY801DnYeN2LgEL9/1m1RBiduh+8oQkIoqmwRA3tnGq9ndocmPjWiNfyOQoJKtb7PziO2aNB20vuJFmon2Pzm36DcAJGi8DSN8eVhD0EjsHVp25bHL65ifMMZVbX89DBHIcf9ehxhIJi7K+f5c1G520x8jK4kwnsVQOATm80/vRN3N/B+vKX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D748B939DCED1F49AD112A03295E47F1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97feb2e4-5061-42ef-9d62-08d5d3000508
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 20:38:57.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTozNSBQTSwgdmFsZGlzLmtsZXRuaWVrc0B2dC5lZHUgd3JvdGU6DQoNCj4gT24gVGh1LCAx
NCBKdW4gMjAxOCAwNTozMzo0NiAtMDAwMCwgTmFkYXYgQW1pdCBzYWlkOg0KPiANCj4+Pj4gSW4g
YWRkaXRpb24sIHVwZGF0aW5nIHRoZSB5ZWFyIGFuZCBhZGRpbmcgYSBsaWNlbnNlIHRhZy4NCj4g
DQo+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiANCj4+PiBZb3Ug
c3RpbGwgaGF2ZSBhIGxvdCBvZiBib2lsZXItcGxhdGUgdGV4dCBpbiBoZXJlIHRoYXQgY2FuIGJl
IHJlbW92ZWQuDQo+Pj4gUGxlYXNlIGRvIHNvLg0KPiANCj4+IEJ1dCB3aGF0IGVsc2UgZG8geW91
IHdhbnQgbWUgdG8gcmVtb3ZlPyBUaGlzIGlzIGEgc3RhbmRhcmQgR1BMIGxpY2Vuc2UuIElmIEkN
Cj4+IGFtIHJlcXVpcmVkIHRvIHJlbW92ZSB0aGUgR1BMIGxpY2Vuc2UsIEkgd2lsbCBoYXZlIHRv
IHJ1biBjaGVja3MgdG8gZW5zdXJlDQo+PiBpdCBpcyBhcHByb3ByaWF0ZS4NCj4gDQo+IFlvdSBt
ZWFuIHRoZSBjaGVja3MgdGhhdCB5b3Ugc2hvdWxkIGhhdmUgZG9uZSB3aGVuIHlvdSBzdHVjayB0
aGUgU1BEWA0KPiB0YWcgb24gdGhlIGZpbGU/DQo+IA0KPiAoSGludDogVGhpbmsgb2YgdGhlIFNQ
RFggdGFnIGFzIGEgJyNpbmNsdWRlIGdwbHYyLmxpY2Vuc2UuYmx1cmIiIDopDQoNCkkgbWF0Y2hl
ZCB0aGUgU1BEWCB0byB0aGUgbGljZW5zZSB3ZSBoYXZlLCB0dXQgSSBkb27igJl0IGtub3cgd2hl
dGhlciBteQ0KY29tcGFueSByZWdhcmRzIGFuIFNQRFggdGFnIGFzIGEgc3VmZmljaWVudCBtZWFu
cyB0byBwcm90ZWN0IGNvcHlyaWdodHMsDQp3aGljaCBhbGxvd3MgdG8gcmVtb3ZlIGFsbCB0aGUg
cmVzdCBvZiB0aGUgdGV4dC4NCg0KSnVzdCB0cnlpbmcgbm90IHRvIGdldCBmaXJlZCBmb3IgYSBz
dHVwaWQgcmVhc29uIDspDQoNCg==
