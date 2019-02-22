Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45810C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC96C2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="s/k7gbIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBVWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:43:30 -0500
Received: from mail-eopbgr820100.outbound.protection.outlook.com ([40.107.82.100]:15494
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfBVWn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-os-amperecomputing-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1JAbes9OCmibZbdGqBigpi5YSYQJ3R8NHyfstfrAP0=;
 b=s/k7gbITM6xZd6VkYdum2Ozy0XmnMrymGGGSvyB9RNBYIXzjUYqJgU0wm7Hijw1XaZtY5NDdKsnXQHlTaqihYuAHRo99wbU1DZlpiEwl5LVftvPt70Tdc9X2j37+Yn0fCin3HjQr9PmVMtIlOqfCWsv8pO1KE/R4Aoy1J5xhQNs=
Received: from BYAPR01MB4664.prod.exchangelabs.com (20.177.227.140) by
 BYAPR01MB5544.prod.exchangelabs.com (20.179.88.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Fri, 22 Feb 2019 22:43:23 +0000
Received: from BYAPR01MB4664.prod.exchangelabs.com
 ([fe80::6879:4bf7:794:c869]) by BYAPR01MB4664.prod.exchangelabs.com
 ([fe80::6879:4bf7:794:c869%3]) with mapi id 15.20.1622.018; Fri, 22 Feb 2019
 22:43:23 +0000
From:   Khuong Dinh <khuong@os.amperecomputing.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Ampere email address
Thread-Topic: [PATCH v2] MAINTAINERS: Update Ampere email address
Thread-Index: AQHUuD8Bl3rwJw87K0qY0JPytNqJ06Xsj4WA
Date:   Fri, 22 Feb 2019 22:43:23 +0000
Message-ID: <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
References: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
In-Reply-To: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
Reply-To: Khuong Dinh <khuong@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR2201CA0044.namprd22.prod.outlook.com
 (2603:10b6:910:3e::33) To BYAPR01MB4664.prod.exchangelabs.com
 (2603:10b6:a03:90::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khuong@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ede28761-a8ff-46d0-1092-08d69917268c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR01MB5544;
x-ms-traffictypediagnostic: BYAPR01MB5544:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjAxTUI1NTQ0OzIzOlZVdldRemE5TXVNUGNQOU1NT0dqc0RQY1g2?=
 =?utf-8?B?SzQyNDZPbmU1dTY5MlBhMityZ245ZzdRUEZqc05YZmtzbGpNSUlxZGNLRHQ4?=
 =?utf-8?B?VkZFMWxjT0hXbDZSeWxrZ0lIbCtFa1hiVXQ2NHgxT1hjeHVFOTh2MWVDZVZL?=
 =?utf-8?B?bG9NMEd4SWk5N3Y0am9rWkRyelo4MW82OE4xVDZtUnZ3MThaenlJSmNKUnZl?=
 =?utf-8?B?R2VTZXVLeWh3THFzbVMzbmhobmwrNmVuNlhLR3Mzb0dPVER0UDdCUmVTOUhm?=
 =?utf-8?B?QVF5VEVBb05UM1hsRkhZNHZOcWF5OGVMaUNlczhZdDRzQ1ZNVlgxNm0yNjZk?=
 =?utf-8?B?RkJPaUxKcDFDNHArUmFYV1orVjFmQ1dXNUdUWlRwakhPUmRMaTJhM3lhdEFZ?=
 =?utf-8?B?bXNwTDVFbWVvNjZJSHI0SGdGN0dka3FXbXpoUWdsVHB4cWk0NmZBY0VXRm43?=
 =?utf-8?B?cFF5UjVxNWF3ZE9sdW10Mk1Dd3E0TTdTRTI2RnFBVzhSVDdqUzBNYlBid3lR?=
 =?utf-8?B?TWJud0hSK3Izc25rd2NzUGRDRW5mYmhlVTA0SXVxVFJtNWF4RVh6Sml0QkV0?=
 =?utf-8?B?cWhpQ0dqdFVMTWdDcm5YZWZiWXppNzI0K1dmTU9obWFFSGl4V1UzalJuRG96?=
 =?utf-8?B?MWcwbXlIMzFvWllBTlN4UFlTbDMrbEIwbmVlQlo5MW84WE5sK2NtNnNidFd3?=
 =?utf-8?B?SmpDaUhrL1V3VUFDeTRUbzJXc1BOay9lbVlVVGxvK2Z4Z0E0dERhUlZHU0sz?=
 =?utf-8?B?eERucEpJd2JUYXNwTEdVZ29vTEVPWEdSUDVzaGp2cHlBN1ZsMktWOFlraDRn?=
 =?utf-8?B?UlFMVDZzQWllOUZUUm91dE5IWHN0VnYwUTVCZXhLV3VwMzJPejMwOVdSRjV2?=
 =?utf-8?B?NUFwQUNIY3FTUVk0K2lZSkZHZjBWN2JWemFpcDVlTEY0VzhvdkRIdDFLU09t?=
 =?utf-8?B?NURkaXBrTW56RER4YVJCdHc4Y2RlaEpBVzM0NDF5clFCeWt4RVoycXEyN21p?=
 =?utf-8?B?bkxZK2dqZ2JMN2NsMFp3bjJSVWwrR0xhVzd5RTVxTHhwTXErTG16WC9DcGVK?=
 =?utf-8?B?Wjcwa0N6QVJZeDBBcXJJN0R0SndUK2NOVDRaY0tpSHllV2tGbkFpRkg4emhR?=
 =?utf-8?B?RXVJcVJxODVwTnRtS3Y2d2RVNTB1TW1uSHh1ellnNHBmZUdrMVNFQUF3L1JU?=
 =?utf-8?B?UEduNUlmbGZxRXdkMHZPUUZJa2ZrNDFPM0hwQUpOVVk1YXVPejN3VUMwUVFD?=
 =?utf-8?B?UHY1WERhREFKVmlYM2IvWHBSVXpPZ3p2NUVCNUNTWE1CMWN3Nm5QaUJNcE9a?=
 =?utf-8?B?QkJwakdiaWs1WlBEd21Ea3k4bWRoODFCK291R0gwVmJ6eUt2RWx4a3k0WHdi?=
 =?utf-8?B?L3BoODg0TEV5YUMvRVZMWUNsK3NqNDhsampIeTFVNERhTWxHRkZ2QlZpdjJU?=
 =?utf-8?B?d2VtV05jaWxxSUpVaVVQZ2xXTlBGRFZyQTVMWU0zbm9CZGdsNTNLOERwQkdD?=
 =?utf-8?B?eWtUOVlHMDN2dUZoR2hZSzh6OCtSU2o0Y0hiZlRpT2U4OVR6RmVCM0tRNUQy?=
 =?utf-8?B?K2cxeVBlWkJkR251dE5qUjhaYmNCQnMwVjQyUFE4SFRNdEJtSEhXQm1LT2lS?=
 =?utf-8?B?dnQzVTJNYkxXNTVTTFdvQ3laNGtZNlFLVUk1azlrR3JCazNXVGxKMTVuWmJm?=
 =?utf-8?B?V1AzaWpXVDV2QkFYTFA4OFhwcXVOOElEODBMeW1wUnNiSjJCU2huLzBCYkFm?=
 =?utf-8?B?MVhvRWhBNG80T0VoY1hZUHgzcGZKSmRlM1o0WXJIUjFXSGJNeUtqVEQ5RURM?=
 =?utf-8?B?MVFxVlMwbEJHOVBLd1dXUE54L1dxMFFZN3pHQnpYaVVIdU1jeFljem03L3FE?=
 =?utf-8?Q?c29/7U1nEuI=3D?=
x-microsoft-antispam-prvs: <BYAPR01MB5544FF12ECBC7F121DFFE36DE97F0@BYAPR01MB5544.prod.exchangelabs.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(366004)(346002)(396003)(376002)(189003)(199004)(66066001)(2201001)(52116002)(478600001)(6116002)(25786009)(6246003)(256004)(4326008)(3846002)(99286004)(6512007)(186003)(8676002)(26005)(14454004)(43066004)(486006)(107886003)(81156014)(14444005)(31686004)(106356001)(6506007)(386003)(53936002)(53546011)(316002)(476003)(71190400001)(76176011)(68736007)(8936002)(11346002)(102836004)(2501003)(305945005)(105586002)(6486002)(5660300002)(7736002)(86362001)(81166006)(446003)(6436002)(110136005)(229853002)(2616005)(2906002)(3450700001)(15650500001)(31696002)(97736004)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5544;H:BYAPR01MB4664.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xGYyCHHrELuRPoKREwpJ+uXvTcWXEWFYeq3ZbbC4DNL7lal9M9JkiPHYmqum95+bx5o9tB1PnWov2iJOnKGgvCSZ4+N91DcJd3HBGwsIElTTcjU/7vWS1M0aY52QrXxZ+mOZeFnooPEH/7HtgRxEWSXVuWUj18R5b3DofB03XVF15gTD7NJ+xNaSwE9vF6BNo9YEzXIcN3yrcFiwULU5PCinjQuoboumI7lD5ZTVvTiljjeYbxboDMDhkt9Q6zPVKv25GrPS7lyBbIhsWCHD/vjL1ain6Lxos4BjThOyqR7fKUbwq2p2HPy6qk+gFQJXNTwfZc1gKMkRjJt789NqCqx06+8k+2y3O1tlImkAK9dMfrBkR9tO0RpLsspvyhwc+UYWGFISif5E+FV+SbwvPMFlY9F90NGqd4O22Fjjy0M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE54EC5A6D5050458439DE854E4E350D@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede28761-a8ff-46d0-1092-08d69917268c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 22:43:22.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCiDCoCBEbyB5b3UgaGF2ZSBhbnkgZmVlZGJhY2sgZm9yIHRoaXM/DQoNCkJlc3QgcmVn
YXJkcywNCg0KS2h1b25nIERpbmgNCg0KT24gMS8yOS8yMDE5IDU6NTYgUE0sIEtodW9uZyBEaW5o
IHdyb3RlOg0KPiBUaGlzIHBhdGNoIHVwZGF0ZXMgYWxsIEFQTSBlbWFpbCBhZGRyZXNzZXMgdG8g
QW1wZXJlIG5ldyBlbWFpbA0KPiBhZGRyZXNzZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEtodW9u
ZyBEaW5oIDxraHVvbmdAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAg
IC0gVXBkYXRlIG5ldyBkb21haW4gZW1haWwgYWRkcmVzcw0KPiB2MToNCj4gICAtIEluaXRpYWwg
dmVyc2lvbg0KPiAtLS0NCj4gICBNQUlOVEFJTkVSUyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDZj
MjdjZDcuLjFjZjA4MDEgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5U
QUlORVJTDQo+IEBAIC0xMDM2LDI2ICsxMDM2LDI2IEBAIEY6CWRyaXZlcnMvbmV0L2FwcGxldGFs
ay8NCj4gICBGOgluZXQvYXBwbGV0YWxrLw0KPiAgIA0KPiAgIEFQUExJRUQgTUlDUk8gKEFQTSkg
WC1HRU5FIERFVklDRSBUUkVFIFNVUFBPUlQNCj4gLU06CUR1YyBEYW5nIDxkaGRhbmdAYXBtLmNv
bT4NCj4gK006CUtodW9uZyBEaW5oIDxraHVvbmdAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4g
ICBTOglTdXBwb3J0ZWQNCj4gICBGOglhcmNoL2FybTY0L2Jvb3QvZHRzL2FwbS8NCj4gICANCj4g
ICBBUFBMSUVEIE1JQ1JPIChBUE0pIFgtR0VORSBTT0MgRURBQw0KPiAtTToJTG9jIEhvIDxsaG9A
YXBtLmNvbT4NCj4gK006CUtodW9uZyBEaW5oIDxraHVvbmdAb3MuYW1wZXJlY29tcHV0aW5nLmNv
bT4NCj4gICBTOglTdXBwb3J0ZWQNCj4gICBGOglkcml2ZXJzL2VkYWMveGdlbmVfZWRhYy5jDQo+
ICAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VkYWMvYXBtLXhnZW5lLWVk
YWMudHh0DQo+ICAgDQo+ICAgQVBQTElFRCBNSUNSTyAoQVBNKSBYLUdFTkUgU09DIEVUSEVSTkVU
IChWMikgRFJJVkVSDQo+IC1NOglJeWFwcGFuIFN1YnJhbWFuaWFuIDxpc3VicmFtYW5pYW5AYXBt
LmNvbT4NCj4gLU06CUtleXVyIENodWRnYXIgPGtjaHVkZ2FyQGFwbS5jb20+DQo+ICtNOglJeWFw
cGFuIFN1YnJhbWFuaWFuIDxpeWFwcGFuQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ICtNOglL
ZXl1ciBDaHVkZ2FyIDxrZXl1ckBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiAgIFM6CVN1cHBv
cnRlZA0KPiAgIEY6CWRyaXZlcnMvbmV0L2V0aGVybmV0L2FwbS94Z2VuZS12Mi8NCj4gICANCj4g
ICBBUFBMSUVEIE1JQ1JPIChBUE0pIFgtR0VORSBTT0MgRVRIRVJORVQgRFJJVkVSDQo+IC1NOglJ
eWFwcGFuIFN1YnJhbWFuaWFuIDxpc3VicmFtYW5pYW5AYXBtLmNvbT4NCj4gLU06CUtleXVyIENo
dWRnYXIgPGtjaHVkZ2FyQGFwbS5jb20+DQo+IC1NOglRdWFuIE5ndXllbiA8cW5ndXllbkBhcG0u
Y29tPg0KPiArTToJSXlhcHBhbiBTdWJyYW1hbmlhbiA8aXlhcHBhbkBvcy5hbXBlcmVjb21wdXRp
bmcuY29tPg0KPiArTToJS2V5dXIgQ2h1ZGdhciA8a2V5dXJAb3MuYW1wZXJlY29tcHV0aW5nLmNv
bT4NCj4gK006CVF1YW4gTmd1eWVuIDxxdWFuQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ICAg
UzoJU3VwcG9ydGVkDQo+ICAgRjoJZHJpdmVycy9uZXQvZXRoZXJuZXQvYXBtL3hnZW5lLw0KPiAg
IEY6CWRyaXZlcnMvbmV0L3BoeS9tZGlvLXhnZW5lLmMNCj4gQEAgLTEwNjMsNyArMTA2Myw3IEBA
IEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvYXBtLXhnZW5lLWVuZXQu
dHh0DQo+ICAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9hcG0teGdl
bmUtbWRpby50eHQNCj4gICANCj4gICBBUFBMSUVEIE1JQ1JPIChBUE0pIFgtR0VORSBTT0MgUE1V
DQo+IC1NOglUYWkgTmd1eWVuIDx0dG5ndXllbkBhcG0uY29tPg0KPiArTToJS2h1b25nIERpbmgg
PGtodW9uZ0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiAgIFM6CVN1cHBvcnRlZA0KPiAgIEY6
CWRyaXZlcnMvcGVyZi94Z2VuZV9wbXUuYw0KPiAgIEY6CURvY3VtZW50YXRpb24vcGVyZi94Z2Vu
ZS1wbXUudHh0DQo+IEBAIC0xMTYzOSw3ICsxMTYzOSw3IEBAIEY6CURvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvYWx0ZXJhLXBjaWUudHh0DQo+ICAgRjoJZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLWFsdGVyYS5jDQo+ICAgDQo+ICAgUENJIERSSVZFUiBGT1IgQVBQTElF
RE1JQ1JPIFhHRU5FDQo+IC1NOglUYW5tYXkgSW5hbWRhciA8dGluYW1kYXJAYXBtLmNvbT4NCj4g
K006CVRvYW4gTGUgPHRvYW5Ab3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj4gICBMOglsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnDQo+ICAgTDoJbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+ICAgUzoJTWFpbnRhaW5lZA0KPiBAQCAtMTE4MTcsNyArMTE4MTcsNyBAQCBGOglE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2FsdGVyYS1wY2llLW1zaS50eHQN
Cj4gICBGOglkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtYWx0ZXJhLW1zaS5jDQo+ICAgDQo+
ICAgUENJIE1TSSBEUklWRVIgRk9SIEFQUExJRURNSUNSTyBYR0VORQ0KPiAtTToJRHVjIERhbmcg
PGRoZGFuZ0BhcG0uY29tPg0KPiArTToJVG9hbiBMZSA8dG9hbkBvcy5hbXBlcmVjb21wdXRpbmcu
Y29tPg0KPiAgIEw6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gICBMOglsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gICBTOglNYWludGFpbmVkDQo+IEBAIC0xNDc2
Myw3ICsxNDc2Myw3IEBAIFM6CU1haW50YWluZWQNCj4gICBGOglkcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX2R3LmMNCj4gICANCj4gICBTWU5PUFNZUyBERVNJR05XQVJFIEFQQiBHUElPIERS
SVZFUg0KPiAtTToJSG9hbiBUcmFuIDxob3RyYW5AYXBtLmNvbT4NCj4gK006CUhvYW4gVHJhbiA8
aG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KPiAgIEw6CWxpbnV4LWdwaW9Admdlci5rZXJu
ZWwub3JnDQo+ICAgUzoJTWFpbnRhaW5lZA0KPiAgIEY6CWRyaXZlcnMvZ3Bpby9ncGlvLWR3YXBi
LmMNCg==
