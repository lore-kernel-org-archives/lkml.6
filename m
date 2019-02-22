Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F6F206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="XVZe+E9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfBVXCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:02:06 -0500
Received: from mail-eopbgr780135.outbound.protection.outlook.com ([40.107.78.135]:13184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfBVXCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-os-amperecomputing-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAz6xLN9JV9UGriGBrIj3nsbhvlPfEFlsgqUfK2RtBU=;
 b=XVZe+E9ObV4RJQZSlzKBOv+iI9ZO8tN0WryiQiPIYGDPTbgFqR1mxyWDOgdWVp06Nai8WjDvSGnfofrYte5+MRZrnRYsoelZObNV21DIcK/QBG3hVV+LEL5Njp9CDBK428xZhGq5KkV85gLnBbeWQ2Aasl5NDbGTfohrR4RVxN8=
Received: from BYAPR01MB4664.prod.exchangelabs.com (20.177.227.140) by
 BYAPR01MB5413.prod.exchangelabs.com (20.179.62.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 22 Feb 2019 23:02:01 +0000
Received: from BYAPR01MB4664.prod.exchangelabs.com
 ([fe80::6879:4bf7:794:c869]) by BYAPR01MB4664.prod.exchangelabs.com
 ([fe80::6879:4bf7:794:c869%3]) with mapi id 15.20.1622.018; Fri, 22 Feb 2019
 23:02:01 +0000
From:   Khuong Dinh <khuong@os.amperecomputing.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joe@perches.com" <joe@perches.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update Ampere email address
Thread-Topic: [PATCH v2] MAINTAINERS: Update Ampere email address
Thread-Index: AQHUuD8Bl3rwJw87K0qY0JPytNqJ06XsCWmAgACKfgCAAADTgA==
Date:   Fri, 22 Feb 2019 23:02:01 +0000
Message-ID: <082eb78d-1fcf-922f-ca5c-bf620a01babe@os.amperecomputing.com>
References: <1548813357-21892-1-git-send-email-khuong@os.amperecomputing.com>
 <e9b60c35-d8f9-7feb-ee9b-781157c246b6@os.amperecomputing.com>
 <CAK8P3a1V4zgtC64yo-8wn5UCtDpT0B7nCr_XCWQ5X56k5ZSvmQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1V4zgtC64yo-8wn5UCtDpT0B7nCr_XCWQ5X56k5ZSvmQ@mail.gmail.com>
Reply-To: Khuong Dinh <khuong@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:903:152::27) To BYAPR01MB4664.prod.exchangelabs.com
 (2603:10b6:a03:90::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khuong@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 008090df-5725-4889-1398-08d69919c110
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR01MB5413;
x-ms-traffictypediagnostic: BYAPR01MB5413:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjAxTUI1NDEzOzIzOldnMjF4ZFR1c2NFQmJuV0RvSlZxYzFaakVG?=
 =?utf-8?B?NzZoOU5lWko0cldYSExvaFQwS3l3RkgzNUxVTCtoWFFDTEp2YzgyQVhobTJs?=
 =?utf-8?B?OHBzSjNKblhQNmxsbysyRTdMWnJOdVVDS3liRVVjR3VmdldpUlVJY3NOcFNG?=
 =?utf-8?B?akRZNFliL3pOMjIxU21MbEY5K2l5Y0YvYkgvWjN4blhpTFpkUmV2VjVqNHJ6?=
 =?utf-8?B?RHpqSlpmanl1TEYwVXNlb0R6aHNZay81NW5yazNKSGhMZlJ0bFJtb0NQbTcr?=
 =?utf-8?B?WEhnNDJwY2pmaWZGQ09LaWV2NUJ5ZFRHa0JYM2dyZWw5dzJROGtpTm14eloz?=
 =?utf-8?B?MGZ4QytxNEJDdmlOMXg2U0JNWHgwZDYySmUrVDZvRGRSM2NVMis5K004NG5I?=
 =?utf-8?B?aEtUMWxVbTk2aTNNVUxjU1UvVmZiQ0ZUTEtGZkcyRUlBeTNsWTlUNVFtYnpq?=
 =?utf-8?B?endkSUIzSXNoQVN5UEFNYlkveFZISGVHMUJiak5uVFE4TmsvQ0pEQVJNZE1B?=
 =?utf-8?B?dzMybDNZTlE3VkswUVQvS2JpVHdhSGw1U3R1SkVBZEIrL0JvNkM0eWphVHBU?=
 =?utf-8?B?T2xwYkN5NmVORnRLS3JJVTZ0bnpvQjhLV3huU2h4TDdDWmx0ajdjQ1M5VXQ3?=
 =?utf-8?B?bGJHRDVhZ29HZkJHd3Q4TmVLUUlnS3pkNDR5REU3M2hhdERydXhVbEQycVlC?=
 =?utf-8?B?Q0xOcFR5dG1ZWmN3Rml0RlNUMHVGNXpNbzlRbHhBbFEvR0s5NUw1azlPSUpP?=
 =?utf-8?B?VE5aMk9Gd0tWQTlLRVVZRW93U0RxeGVXZnAxTUZSMDR2Z2ZCVG1HWTdDVmF2?=
 =?utf-8?B?WlpMdkhCNXVSNUdCVFQzSHo4YWdobE1qTHJzY293eGhWajB4RDFSWWZBOEdS?=
 =?utf-8?B?TERMcnhkTkQ2YStsRGx2TTNyRnhOQ21xU2F0M2RzUTdUeElpbVJ0YXVLYVY0?=
 =?utf-8?B?QlFGcXVFTW1oSHpHNmJSNFl4Z3poWkx1VzBYNVBGMzl6NWNkajRvYXVmbVhN?=
 =?utf-8?B?VlJyUkIydEVWN1IyTUczTWYxNzE2Vy8zUHFWZ1NGaXFyL2JCNEdCTThla2Ju?=
 =?utf-8?B?NE03R0ZtUnJyVWJ2M3RYZEFqc0F5M0xMOXhzZFRNZVhweTVNK1ZtejNxamZ3?=
 =?utf-8?B?eVBXaGxyY0tYQjJEOWw4T2RjZGpWTjVZSFpoUXFvZWtmMDNTRzBRMTJKcmkr?=
 =?utf-8?B?R2lzWUN3SlZndXdlbTlmeVZreXFBYVNNS08zYXpYWVdrRzgxY0g5TXZsV1Ar?=
 =?utf-8?B?MXVtanpsMGRsQ21kdkwwcUhrZzBPN3JLZ3BxY2d4aVdSNUJtNUQxM3NxK096?=
 =?utf-8?B?VmxMTnJhalZvVmdhbjJUUEZ2MTJwb3h6YTV4aFBVWDBJeXVxMGY5d3ROQVhX?=
 =?utf-8?B?U1VmalEwWHJxWTFPVTd5REMzR2RWTUpiVDBHTzMvb2VWbGZJUkdMNlZNYWpm?=
 =?utf-8?B?OVU2RTVyN1NpSVgxL1lSRkI3cCtaaEFwc1drd2E4WG13OHhpTzg2S1k2c2RZ?=
 =?utf-8?B?bUk1L01GOVQyU2d5dFR2d3duL2J0MUFFUUo4bVZyZHduVzg0TksraUxqQlEv?=
 =?utf-8?B?L3hEVVpxNzFEVHRRbzFmUlg3ajhabEhPak53SWY1MG5XYnkxeXJRNHdqMGxv?=
 =?utf-8?B?T0pvaXUzSXpYR3JuYS9lUnlhbUh6Sll0Ykp5MlJITGpkVTgyQ29iUGo5MzZ1?=
 =?utf-8?B?YS8xWXJ3UDZqNzVqNDZtTUxmU3B2TTR1azNNTmtvaDBaN3RBdVNOTEduS0tq?=
 =?utf-8?B?a2xKQS9yMXh2aXp3dDJGSFVFNG9zelZUNW84RGNtMlF5cENRak5pZmEyVTJ0?=
 =?utf-8?B?MUVjbzgyMmFmL0cwYkdvUFRVeFAwY2NXc0wrS25XTXhQTm5uWlJNM2pyeFdz?=
 =?utf-8?B?TzVIWDZBblRaMFhreC8yTDB4bTVGbWdBejlPVnNIRkVydzVaM0xENU5PQ21F?=
 =?utf-8?Q?kbght88bsjEzEXFOqVD4hCl7wN4MgI=3D?=
x-microsoft-antispam-prvs: <BYAPR01MB5413DF3DA6EC65C47BDA52C8E97F0@BYAPR01MB5413.prod.exchangelabs.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(136003)(346002)(39840400004)(366004)(199004)(189003)(76176011)(6436002)(8936002)(105586002)(6486002)(43066004)(26005)(68736007)(106356001)(3450700001)(5660300002)(6246003)(446003)(99286004)(52116002)(3846002)(6116002)(31686004)(186003)(107886003)(102836004)(25786009)(229853002)(11346002)(476003)(316002)(53546011)(2906002)(386003)(6512007)(486006)(4326008)(97736004)(86362001)(66066001)(71200400001)(53936002)(7736002)(71190400001)(6916009)(31696002)(6506007)(54906003)(2616005)(305945005)(14454004)(256004)(478600001)(81156014)(8676002)(81166006)(558084003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5413;H:BYAPR01MB4664.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ng2Qe8SSxmItCfkuayUU6MGFbHCIQx2BsyRdw+QchkkAHFdBxHMkwooN8h0HYYqiPozKeJy5SOyhh5IUJ2YUmHDabbaf7yvf5fEk/HeiTls7nfJONqvpMgruag35KbVdPy2w7DwtdrxuFWZF+vMvkCk5ySVuqcelvLcVlEaBT0QMPV3abcR19NpP8cuRK45dSAv/PNkQZb9AVnwcYkQ2QqWl9YoAYrkcQoJvGi+d9O9shqea/Tx+kbCM9HZqAdZfET8LCNI3BSKKE+8iNaNVF6uW9c1qysOib5fQLrbaON2Ldm7LUDieRcRGfP881S38bZuHP50WJFZNSL+3+T8Qg9fn5Swoa3Tm59teVMZrcvckUfV70LROtjuucv4B8AtxD9NdjgG5jU1wMxs4t1IqgVl84Wa6DlcFPxMt1KyQFhs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AC511AA918E444A871EBB2E520F9693@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008090df-5725-4889-1398-08d69919c110
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 23:02:00.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91LCBBcm5kLg0KDQpPbiAyLzIyLzIwMTkgMjo1OSBQTSwgQXJuZCBCZXJnbWFubiB3
cm90ZToNCj4gT24gRnJpLCBGZWIgMjIsIDIwMTkgYXQgMTE6NDMgUE0gS2h1b25nIERpbmgNCj4g
PGtodW9uZ0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tPiB3cm90ZToNCj4+IEhpLA0KPj4NCj4+ICAg
ICBEbyB5b3UgaGF2ZSBhbnkgZmVlZGJhY2sgZm9yIHRoaXM/DQo+Pg0KPj4gQmVzdCByZWdhcmRz
LA0KPiBJJ3ZlIHBpY2tlZCBpdCB1cCBmb3IgdGhlIFNvQyB0cmVlIG5vdy4NCj4NCj4gICAgICAg
ICBBcm5kDQo=
