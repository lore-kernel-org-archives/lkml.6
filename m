Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2007C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91998214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="P4LSpDuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91998214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeLFN3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:29:00 -0500
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:15072
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbeLFN3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2KbTjpZnGdHdmRTXxSlSZscF3QiCImiVoz0UbAHVLE=;
 b=P4LSpDuUfq3AllsKv6XNFeRxxnbuC5zNLVN1ksoqzfGRbqy7Kg4HJF0ZHh4qOd5nMKmvfroN5S3nBEYDmMwGXsi3zlTql1RBcfO87VICSaGJ14Epf3SbIaCKf0p76nLQAHP2LQFZi05c6cxe9rS4LWhslcJF84/xy/WRYN8A004=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4826.eurprd04.prod.outlook.com (20.176.233.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Thu, 6 Dec 2018 13:28:56 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%2]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 13:28:56 +0000
From:   =?iso-8859-2?Q?Vok=E1=E8_Michal?= <Michal.Vokac@ysoft.com>
To:     Pavel Machek <pavel@ucw.cz>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@savoirfairelinux.com" 
        <vivien.didelot@savoirfairelinux.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "buytenh@marvell.com" <buytenh@marvell.com>,
        "buytenh@wantstofly.org" <buytenh@wantstofly.org>,
        "nico@marvell.com" <nico@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dsa device tree bindings: fix typo and wrong example
Thread-Topic: [PATCH] dsa device tree bindings: fix typo and wrong example
Thread-Index: AQHUjWRWcVT0YcYLJkG+RBJHfCdDSKVxtHsA
Date:   Thu, 6 Dec 2018 13:28:56 +0000
Message-ID: <819595ee-9f3e-b7a2-6139-1ba265137f62@ysoft.com>
References: <20181115195111.GA9946@amd> <20181206130051.GA22343@amd>
 <20181206130513.GE22343@amd>
In-Reply-To: <20181206130513.GE22343@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0011.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::24) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4826;6:OIHSKjVFCEy1Kb/KBfy+ULBXYQV+Id3rGil+vk++IXb/zi1ZHvnc3p7nSyuf7jBUZZMxubV0MWSJYeL2G1S4BJZLq2+rMMzKI/L8Bhf6tjIcGYSDNB/B5pom7Ds0wuOhu5QBn8c9X+izxKq5Iw5HSovnM1vPCM0S0PxZVHssGqWLoJVY4NmAAgz1uoZBE1Xk4IJwWFcApIlwpZo0WygiMdt9b0Vexv7RLdAhCyW3MDbnYDoKV2diw7w1mvRT/XYTfT9dT2KCOQjV5JTl/s8dbMEwjAknsDQZB5f5jVOXoOEntpRwc9ZPiJMZi3X1Mer9oJicOno7Uq9rH6IRKAuDgHovx+Z9L4idAaPqMHTVwH2Yl8FUxpSPpHk4kdjkeRanR5s2QVlRg3Q/TsdkzL8usTFDNkQE36bqkWDqie4we5v7mNcKTqcykcJMywGHqpLVUnPC85AVC69AMxT9OYqkdQ==;5:CTVc80WJGdnLF4K8bLfBxJMqHxEKzmKXDCWiq59hKz9nTgEoBJ0LOsLnLIMJ5nBPU06G38qxrUNxB81YSFnBbKpX706u7nI/u3hiRk6sUynWB+BH8hIYNqU+jMsvqZXlRMjJ/KAk2sqJ7TB+OIEgDYSM6SKJORaeaWQLyobeGXM=;7:oHnbXyypwQV1MZlV1RpQMVewoHDksLe7YrP0RwG9DOFV1tFouB989nvi/VoScdMJ8ZwBSi7wpRuV1T7EjdKAhs2JYMBozNDO/MpSQSbIQk7J1dfy+ykTDFAAVEVbzb0mxDeeHMQ/MiAc8I6HMRom9A==
x-ms-office365-filtering-correlation-id: 9d099697-7ccd-465d-8e1c-08d65b7ec5a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4826;
x-ms-traffictypediagnostic: DB7PR04MB4826:
x-microsoft-antispam-prvs: <DB7PR04MB482603266D0F6BE98EAF642B9EA90@DB7PR04MB4826.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4826;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4826;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(376002)(366004)(346002)(189003)(199004)(31686004)(6512007)(5660300001)(52116002)(8676002)(26005)(14454004)(3846002)(71190400001)(6246003)(53936002)(39060400002)(2906002)(102836004)(386003)(6506007)(76176011)(86362001)(2201001)(66066001)(2501003)(256004)(53546011)(6116002)(186003)(71200400001)(229853002)(25786009)(36756003)(68736007)(31696002)(106356001)(7736002)(105586002)(2616005)(11346002)(486006)(476003)(8936002)(305945005)(446003)(478600001)(97736004)(81166006)(6436002)(7416002)(316002)(99286004)(110136005)(81156014)(4326008)(54906003)(72206003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4826;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +5rMzSNt1yRnAFmvUC9ptXNvUrfFYcFBRY6llJK+iWQhm0RYBlDOt0/xgYCTmKEfN/luW7POKk/tc0MhfgMan/03/3iPH1v7OYoB5NLzdWrf458ceMP43+O84C1RUbVZZvY1Ca8Kj4CqtzqDiLVyAUqRBTW2TRV0007bUfw29dbzJRndYJAIr0mbJywjg7VOZbqkUEfvfSGt2gQS2oILPiBlHay5LnPZiufsjxTJHFMbVyJHZBYG7krzeQlti386Y1cC58kSjdjF7RKg7phRQcqcqtfmcDdQN4sXtNZotbw1YkGMouieRu6HGFTQr3/tKvn+NCKlnidX3tHa6PVcQ6OApFxR3ogSVQ64qWexNHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <33BB954C3F89E8419D2B3D9B82071881@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d099697-7ccd-465d-8e1c-08d65b7ec5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 13:28:56.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.12.2018 14:05, Pavel Machek wrote:
>     =20
> Fix typo and fix compatible value that is not actually permitted by the
> description in the example.

Ahoj Pavle, I think the subject should be more like:

	"dt-bindings: net: dsa: ..."

BR, Michal

>    =20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Docu=
mentation/devicetree/bindings/net/dsa/marvell.txt
> index feb007af13cb..abf1be036ac5 100644
> --- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
> @@ -41,7 +41,7 @@ Optional properties:
>   - mdio			: Container of PHY and devices on the switches MDIO
>   			  bus.
>   - mdio?		: Container of PHYs and devices on the external MDIO
> -			  bus. The node must contains a compatible string of
> +			  bus. The node must contain a compatible string of
>   			  "marvell,mv88e6xxx-mdio-external"
>  =20
>   Example:
> @@ -80,7 +80,7 @@ Example:
>   		#interrupt-cells =3D <2>;
>  =20
>   		switch0: switch@0 {
> -			compatible =3D "marvell,mv88e6390";
> +			compatible =3D "marvell,mv88e6190";
>   			reg =3D <0>;
>   			reset-gpios =3D <&gpio5 1 GPIO_ACTIVE_LOW>;
>  =20
>=20
>=20

