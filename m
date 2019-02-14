Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F60BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF23222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHqhI3ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395483AbfBNRAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:00:50 -0500
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:57091
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727997AbfBNRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqU2QaaCo4DCLN8sf0RDb4h9kStbXwJiwePib+BkoFI=;
 b=hHqhI3icCocmfK/Td5dpqdeD467soVuD1hBKdItVfSOXcHxR677Me7T9k/XpZuEVXqlkJLseBjNm5JQyNtTyIlc6u0xYoryYU0gxcSzu8mfHPiqwaOJj1c7xCvv+RKZeo7NSNyQrOUSucB6EHipjGoCy+wKCDsUEX3K7ReALc7Y=
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com (20.177.49.153) by
 VI1PR04MB4606.eurprd04.prod.outlook.com (20.177.56.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.17; Thu, 14 Feb 2019 17:00:44 +0000
Received: from VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32]) by VI1PR04MB4880.eurprd04.prod.outlook.com
 ([fe80::3d48:4560:6982:4c32%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 17:00:44 +0000
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Thread-Topic: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
 external eth ports for the LS1028A RDB board
Thread-Index: AQHUw4uiFsOjRsU/BUmhwPza339npKXeCTkAgAFPZ3CAACS4AIAACB8g
Date:   Thu, 14 Feb 2019 17:00:44 +0000
Message-ID: <VI1PR04MB48800F563F0C76412090459F96670@VI1PR04MB4880.eurprd04.prod.outlook.com>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
 <1550055743-15542-3-git-send-email-claudiu.manoil@nxp.com>
 <20190213181554.GB708@lunn.ch>
 <VI1PR04MB4880C9EF6C9EBFCAA2209DD596670@VI1PR04MB4880.eurprd04.prod.outlook.com>
 <20190214162746.GI708@lunn.ch>
In-Reply-To: <20190214162746.GI708@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=claudiu.manoil@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b55bb8fc-4a10-47d5-7e3d-08d6929df572
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4606;
x-ms-traffictypediagnostic: VI1PR04MB4606:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB4606;23:KVvULlHW4YbzcePwV9KCuHgfRWOzPaQdVL7uZ0jDa?=
 =?us-ascii?Q?hlX1/sO/rzkFnmkHp8VF1+Wwxaj0YkxmxL6OyXLrVGe3l9OrudCS0zyedDId?=
 =?us-ascii?Q?Vy2OR69wUTUqYsO/WhgIm5BjyDc95K/u2yBVzVCtPhaLTNAlsk+JGK0bBBpY?=
 =?us-ascii?Q?PI5BHd5vY+oSbPPgT/2cVW8CVOguo89AqU/cGnOSiD2PLna7hjTP9xjrmjbv?=
 =?us-ascii?Q?vzZ1h3GOyLWU4OgAAzyoubLxP73NdCwPwBgwjC14s1vcZovB6YcJpz4Vet5e?=
 =?us-ascii?Q?OzXHA5m1z+r3v40Re3cuBCu3g64qsrn4vl6i8ycBPBTF9xIiRHxWCo+1Cx8f?=
 =?us-ascii?Q?2vdi7gq9sLtkcebipeUHVu6I5j7HubYaoNH9wNQmgbf4Eas2jnwfffoOeFAq?=
 =?us-ascii?Q?whVvRFqD67vFHPOpe3DcU3EHXBc/wC8bFgf5v1okIi/zArY38tpiDpbYTh9E?=
 =?us-ascii?Q?rYJBpLHmtWe5zrAmFgRD3lbUMBwFkmjB9GNQ0vcsiq72SbUhHKZ7LxtySwyx?=
 =?us-ascii?Q?TpOfd6sN9ilxOSMO9FUi30x5J8DsSI/5aNQV/3SEpFKqW0S1Tad+4iaeTTGB?=
 =?us-ascii?Q?MdHWK1T4gayouYAxfPoJ+2ts3sI2W34i8AxJowbcmvmoO9LgCrsOndjgo9x1?=
 =?us-ascii?Q?mdt3kvdmGyIsLR3Cj88ltRfTjvlqylAbA+nZxCs0cLrUpUBJF2Y0/FAd4F9r?=
 =?us-ascii?Q?050GXamvRgExUJr82adK0QkDulyR4QsLUIqkfArTEYHfRBUHMzlle6itqga+?=
 =?us-ascii?Q?oTeBz5dhrNboVFfTrsu9RzjiMjP3/xqsoZa6B6yiqAMM/+wgr/dz/MEWf93D?=
 =?us-ascii?Q?8QICv7Qzznbau2oO8WffRuu0d4F2oQagycD9M5S5Or8Tw9/wxirZtSaRFqs5?=
 =?us-ascii?Q?xZUUfTy+s1DHDmrVBKx7/cH/oeu9yCEAOMhsOHpdI/z+Xfa8DvIoVuFfYvGW?=
 =?us-ascii?Q?giqC9m68CnqRz5XrztcW/tpepnlYO+0pNXi8K13AT1YRk1/+3gJA1jAQvjdL?=
 =?us-ascii?Q?sUOZdINGhdeks3Mlf+2GYkXJurRMGis178QkPfSW9ig9OkOyMJjXMTjYBKP+?=
 =?us-ascii?Q?j3Lbz1wPV0W+VbYu6UDkFfmH11v9PN8+tYhLA7U3YvkyLZ07MH3b64iaATKL?=
 =?us-ascii?Q?9uTpeMt6n4QPscOUeQLmyUVWxS7dz//umujRAcngAwGFYFC/Qpzvzp1BoZSZ?=
 =?us-ascii?Q?TFmuW15fDqazgRnRMddCjcMrb8jQ0dsT0UHoPRpwtnMhX+ObtHok7q2AY/Sx?=
 =?us-ascii?Q?M8Zv6fXoIXno9azNjvSROXu71FKjQ4+Zs/9Ekry?=
x-microsoft-antispam-prvs: <VI1PR04MB460606167CDFA8479F4BCAB696670@VI1PR04MB4606.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(13464003)(51914003)(189003)(199004)(93886005)(97736004)(446003)(2906002)(11346002)(186003)(68736007)(4326008)(86362001)(6246003)(256004)(54906003)(8676002)(81156014)(81166006)(25786009)(26005)(74316002)(476003)(316002)(486006)(7736002)(305945005)(66066001)(99286004)(44832011)(8936002)(478600001)(76176011)(53936002)(71190400001)(229853002)(55016002)(6436002)(71200400001)(14454004)(4744005)(6916009)(106356001)(6506007)(3846002)(7696005)(9686003)(105586002)(102836004)(6116002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4606;H:VI1PR04MB4880.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2acsQ4XG54Rqx58FKbjoSY4ABZPm35/2zf3OlfJqGl+UzreK4qP0mlSpfSnsvGdox4rwRrDIDyJNWCDS8p13KzInug6uC/5q0TimZmN7rWd5UX4EWcRx57wmDS5C9/mKycyLDukXS35F3FroZLt0FR+E5PWekLUuuR/9XyTtRDLBxSGjIOCMmssEzngJk5W2jn0grU/nUvQdR/hOqKOw4e+U6Aapa03F3w3E+A16qnB3v5VPmdqzr8365kRXXua5IWofmuhiDSwq0m2EvK6Fxhvw5wXQdPpOH64s4WJTmdNmzk2kLs9j39/GK7lW4wvhv94UFCGJbV5nz8VpGViJmJJQ82jFu/5HnKSW33Ys6fKICL3h0pKerO4ckoux7bjBSGqtcdp+szKTjxD/k5tFYducmpCqvutk8jcUwHNwj3E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55bb8fc-4a10-47d5-7e3d-08d6929df572
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 17:00:44.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Thursday, February 14, 2019 6:28 PM
>To: Claudiu Manoil <claudiu.manoil@nxp.com>
>Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; David S =
.
>Miller <davem@davemloft.net>; devicetree@vger.kernel.org; Alexandru
>Marginean <alexandru.marginean@nxp.com>; linux-kernel@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; netdev@vger.kernel.org
>Subject: Re: [PATCH net-next 2/3] arm64: dts: fsl: ls1028a-rdb: Add ENETC
>external eth ports for the LS1028A RDB board
>
>> Hi Andrew,
>>
>> The extra node for mdio seems to complicate things somewhat.
>> Just adding this node seems not enough.  How to find out easily if a
>> child of a enetc port node is a mdio node?
>
>You copy somebody else code :-)
>

Provided you find the right thing to copy : ) . Thanks for the hint.
