Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89874C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E24F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="lcofbi2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E24F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeK1TYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:24:08 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:6016
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbeK1TYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohUB5qj7aY4ADIdU/8tuH7KIjzVEYeBQjpzZlx/+FGc=;
 b=lcofbi2bPBc1/GjM+LC5i76Paz4MqMaQA2jnrjc6E8RLS4fqw5/AEpaFVH2uUtKrsY/NNqcx5rQhtIqYmU2zXCCaeJ2T5FEq0xVCUIO4uR8wwyDIT7pcThHmYB6JyBkPMb2FhbHP4pkUqn+RTtGTD/VH3lwi3KPpumeZ3dTGwBQ=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB5963.eurprd04.prod.outlook.com (20.178.107.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 08:23:17 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::3ce5:c0de:372f:cd74%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 08:23:17 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Topic: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
Thread-Index: AQHUcfmhpCcckxtfbESTtrGd1QZCZaVkoxaAgABgLoA=
Date:   Wed, 28 Nov 2018 08:23:17 +0000
Message-ID: <60126654-7893-64a6-6269-1129d4fff455@ysoft.com>
References: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
 <20181128023859.GB20643@dragon>
In-Reply-To: <20181128023859.GB20643@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0006.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::19) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5963;6:/hAzsi+hDtPvr7WQShr9unl6LWVdO+UvW3fxVBk7i/655oOwLrLffKZQq4kTzgNqTCNd03/ca9/4ifaw77dywsjIQENF/if98ONYb3arNbldtfko5att1jRtgAgXQdigodAABeXUFOcE1lPTyJjICMKi6TOOyo2ID41UUlx0t9S0Z8p1mVv3RUcKMJtL2y9XXW9xJqwyRtmjh6xcSRQVysw+Duj1tlwNHqElBEr/OClDHnpYGlJ3NHyceUKq7EX3mzQQU/yFz2JacUj+lMiXGl1bu4AdnUYjygbWWG0i0tKgElSTWwih+8QxMzYXu+BkQZBD9Cqe2xp1Oj2HCs3HaJYGrq3LLWDMXWFFuQ58dOmaVo4kl1OFEIrwO0e6Avocb3Lt/Y3gIFuARLCT68Hxef3QF/LjCmUwDHMJTfZaiOoiblftYD/xIFPEFcbN8Ku9pVACSxhgHa3vmDjK4hr5GA==;5:SRCJHdfV+jSEwYDU3xzzTvPbhCD4rTUzntVuazSrrZdW6NsXiEcZnoGbj1582xoGfwgOacL++Bgn6sKfgoKnu8LsaV6sPhdRoboZMt3arxoIhSsEyCZVDjChEdmAeF2AbyOVA0BpbsdA/IITEv1+kl4d6igL8uRemQ/2tKD+AIk=;7:pzkiZr60EtaoCShEllKCiY/bhAc6cecsZSLmjmO7mh1BeQ6D09wSajgrHSkl5wxZnSneRVrwl2P9Q+jWSvJc4ZDtg1VoDaMbKlk9TO74TzR9EAPIrqn59Sao2f5T6oe4t1UCGjrKnSfXnYAv6GEgcg==
x-ms-office365-filtering-correlation-id: 912eadc6-bd96-4ca7-b724-08d6550abf83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5963;
x-ms-traffictypediagnostic: DB7PR04MB5963:
x-microsoft-antispam-prvs: <DB7PR04MB5963374BC1E30BD384A182189ED10@DB7PR04MB5963.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5963;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5963;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(396003)(376002)(346002)(366004)(199004)(189003)(51914003)(446003)(6486002)(11346002)(6436002)(68736007)(7416002)(486006)(8936002)(97736004)(81156014)(72206003)(5660300001)(81166006)(478600001)(476003)(106356001)(8676002)(36756003)(3846002)(316002)(2616005)(2906002)(6916009)(105586002)(6116002)(6512007)(54906003)(7736002)(66066001)(305945005)(31686004)(256004)(14444005)(14454004)(229853002)(25786009)(53936002)(31696002)(386003)(102836004)(6506007)(53546011)(86362001)(52116002)(4326008)(186003)(26005)(71190400001)(6246003)(71200400001)(76176011)(85182001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5963;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TVzasbJpfanlnu2ZgfyYEm+CrIfG6+kXZP14nyzkT4QZsTa7PoVM7CPYrrA/DPDDOzStXQONqVF2aujcji2ukvTSkrtH4kZna/Ebn3ZYyKfSCsL+szr83/AZ6Uxh0OFw3R/Q+vhfyOsGq8B4+4QXzGI3yD6jJvSqFi7d9MLTeYUrlB5QRQBOQD8FXSOJoEuOms8gC/kBclHSuxoHMS7QwXJlbqyFSrlR/wHfhTETcThawbFBR56JyuGY6vx9oWBTuxvD6fvOSH0fsdKjS2RsYZqDAitMwC6/31x+Tqf/TSKuBeoGUW74RRT/DI8L6z/y1BDbI+rscYrFKn60EdISOOecBTMgj/BQgKG5FN8haGA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4299AD4A7FA6994FA19EC98C17ACA36A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912eadc6-bd96-4ca7-b724-08d6550abf83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 08:23:17.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMTEuMjAxOCAwMzozOSwgU2hhd24gR3VvIHdyb3RlOg0KPiBPbiBUaHUsIE5vdiAwMSwg
MjAxOCBhdCAwMzo0MzoyNlBNICswMDAwLCBWb2vDocSNIE1pY2hhbCB3cm90ZToNCj4gLi4uDQo+
PiArJnVzZGhjMyB7DQo+PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArCXBpbmN0
cmwtMCA9IDwmcGluY3RybF91c2RoYzM+Ow0KPj4gKwlidXMtd2lkdGggPSA8ND47DQo+PiArCWNk
LWdwaW9zID0gPCZncGlvNyA4IEdQSU9fQUNUSVZFX0xPVz47DQo+PiArCXdwLWdwaW9zID0gPCZn
cGlvMiAyMiBHUElPX0FDVElWRV9ISUdIPjsNCj4+ICsJbm8tMS04LXY7DQo+PiArCWtlZXAtcG93
ZXItaW4tc3VzcGVuZDsNCj4+ICsJZW5hYmxlLXNkaW8td2FrZXVwOw0KPiANCj4gVGhpcyBwcm9w
ZXJ0eSBpcyBkZXByZWNhdGVkLiAgUGxlYXNlIHVzZSAid2FrZXVwLXNvdXJjZSIgaW5zdGVhZC4N
Cg0KT0ssIEkgd2lsbCBmaXggdGhhdC4gVGhhbmtzIGZvciB0aGUgaGVhZHMgdXAuDQoNCk1pY2hh
bA0KDQo+PiArCXZtbWMtc3VwcGx5ID0gPCZzdzJfcmVnPjsNCj4+ICsJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4+ICt9Ow0K
