Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DA1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A08E20700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PZDldvmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfBTIMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:12:49 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:35523
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfBTIMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eCo2lnHQFudycZ1KuxF8ryYK925WytWJuI2m46eviY=;
 b=PZDldvmfKT4VzeFMWApAtUW3/b/2zZcf7lDx+Kq1B/H0Mjw4Dn0W7jgt3EyR7nj2b/+LvaubGFg2w8gdJehSHU7OTwQXtllFInHogT7z+d5aV65QH17q4auESGi1i9+lHG8R7Rg9s2sakvdsIVP7g30AxsJF9AobOGUGn01sDtc=
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com (10.171.182.161) by
 VI1PR04MB5552.eurprd04.prod.outlook.com (20.178.122.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 08:12:45 +0000
Received: from VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c08b:b438:76b7:d47b]) by VI1PR04MB4062.eurprd04.prod.outlook.com
 ([fe80::c08b:b438:76b7:d47b%5]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 08:12:45 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: ls1028a: Add Audio DT nodes
Thread-Topic: [PATCH] arm64: dts: ls1028a: Add Audio DT nodes
Thread-Index: AQHUstxGpFbfrq3ZEkaoT2cHyDz3qqXKbXmAgB4NFZA=
Date:   Wed, 20 Feb 2019 08:12:44 +0000
Message-ID: <VI1PR04MB4062E534325E82002E5DCBEEF47D0@VI1PR04MB4062.eurprd04.prod.outlook.com>
References: <20190123052135.26829-1-alison.wang@nxp.com>
 <20190201045002.GH19882@dragon>
In-Reply-To: <20190201045002.GH19882@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alison.wang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9551a4d5-a763-482e-e892-08d6970b3186
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5552;
x-ms-traffictypediagnostic: VI1PR04MB5552:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB5552;23:1her7/EHvlFLT2D9Atg5vvzagJHNIJKBNJjVXqzUQ?=
 =?us-ascii?Q?+84c178gnv7DnseWSd/qYnDNx2F72o7cRJ8SETo5XGDvXbIRN8kf/YSrWx+6?=
 =?us-ascii?Q?NDCEfS4tMcnuAfsd4gtU8AXEWKuNhf31MuAGiqmB1OkpZPwQ8/MnA3VjpzZ7?=
 =?us-ascii?Q?U4pZDAettuquSJ46gigjpicAABWswSawP3+zg/HqhYgzt29LP1jJLmAmLeY+?=
 =?us-ascii?Q?S00egDJV5CaxyYZ75loG8bKh4VQub2aWZ7xX9v6MYEyF6ikQ151TJpzRxlnp?=
 =?us-ascii?Q?m67hThGD5gC86VNA4Zph2LJtlOdNhmGI0ozhFdXNYIV8PZfta6OPA4lnG8Rz?=
 =?us-ascii?Q?ld5v8F8hPCWv8xbCfyJIu0k1MltvskiOu9nxIIYLn+afpL4nVVAnLi/xUiVm?=
 =?us-ascii?Q?2pL/5WezHlbzKK+N/YgtkJ+TaMrsK9JTh8+DjrjbQ8TNRd3TxhNZ16Mpgc9w?=
 =?us-ascii?Q?s+2uiaN1Scad3TSDSsS8FzrzI7arMuR7uhRvUpxk5OGBd/FsIY67ofGu45nt?=
 =?us-ascii?Q?BVZJoO3qHpTIPJrMZ/qcxEtkBKDfdKVs30W9Vx+iGj0dCMJ03LvAvLw/9sEI?=
 =?us-ascii?Q?bkdCZLlSN7UYbJQPU2HIkx6MaZAkTRMDcNPMrt+V+W26xa8G38MrhdG/1iPi?=
 =?us-ascii?Q?B/siz5uEoQ7DO+acA7gR+Eaek1ZDF8EDM1aQrNCx+WByunRS303zTS1OJMA9?=
 =?us-ascii?Q?cQI8vcYdzP1g5VeApgWJtWOXZYaKnw4yIcGMo/FokSbpm2sOlahRj/yiJIpe?=
 =?us-ascii?Q?hayNke5Mg98eDQUJcqBVb2kc4yAlLvx6RyJyy1BBLKm7g76ooDgefGES890x?=
 =?us-ascii?Q?hUpTpkI3wMgr5YgRFx8malvfADN1e1nYQSsOy9Fd2cULIGFj1N+nD2e17+f9?=
 =?us-ascii?Q?YGPhygre2fs8xVkxoZ4ayTeJzKMIv+sA/JX/OHhZOfLLVausJA1/kgLEDttQ?=
 =?us-ascii?Q?M6Kiq90/Wh2DPjL1F8SpoVhT39qXiQF0dIgpl4CffgYn18iaI5PJVHnCaV9d?=
 =?us-ascii?Q?oiBwXLFiL7ys2GVm1QUQjnXFdK8jRf1ihOBO92gdjxk+tsB0ixrRfR6dVzDg?=
 =?us-ascii?Q?3YJcd2x+Xciztsf4h/Ty7RQd/K0yjv+FFHIcTc1F08OMrrR3OFS9j3hknXZ8?=
 =?us-ascii?Q?GeWXHGI3bh5XCluRiEi+6q46J+2769O29yGowLJWMS5Lj6jjQ+0YuspVkRbT?=
 =?us-ascii?Q?vaTFeQIHGao5kkDRV3pHhy/5sevLrD2I57dVhg+aV6d4Iy/cQmcKAgwP1VqW?=
 =?us-ascii?Q?mdk5EByN5Ph1yrH2D4=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB555263059FADC4133C91FAD0F47D0@VI1PR04MB5552.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(136003)(39860400002)(346002)(199004)(189003)(186003)(6436002)(44832011)(97736004)(256004)(66066001)(26005)(476003)(6306002)(9686003)(71190400001)(71200400001)(5660300002)(81156014)(7736002)(478600001)(446003)(8676002)(25786009)(81166006)(11346002)(305945005)(4326008)(6246003)(6116002)(2906002)(86362001)(3846002)(8936002)(14454004)(966005)(316002)(76176011)(6506007)(102836004)(33656002)(54906003)(229853002)(53936002)(74316002)(486006)(68736007)(106356001)(55016002)(105586002)(99286004)(6916009)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5552;H:VI1PR04MB4062.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H0apMGuPI4dI865dgQkvmJF6BgVsIlgNVQz/sv+FRfq74LXXgQPot3XZzQUxx3+BuHjbs9oYwxibx2GXj53QX19M20Yvpfrj/fOvxQRLdXNZzcC7uKqfFDKIpCe1bmCB9cODCTl57CDaAzSyMZNNiRnLpZZgcofWvrsE7KewlBnx3w8BFBDxme1ancNC6cD8xQKAVIYsXh1zk8yjIHUrrygKDRb9g/0alz99rDubkhNQy1LEQZEsmyQejEQ2jWcTSjF2DMJsrzCpAyAgrvvSuMPyV8lFbzCDp1abbVm3KWd86rd5bcYXFR+vOR56bRqCeMfSoC1H/iVxcDh0NOO2I7EK2VHuBlZ/4b1Ok+AQjN2LYHjr/2q+iiEFxlLVLWbYXpNfiJmmMk/2H1njz5PpsgusGwLf/QHfwFkxfy6hA7Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9551a4d5-a763-482e-e892-08d6970b3186
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 08:12:45.0272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn,

> On Wed, Jan 23, 2019 at 01:21:35PM +0800, Alison Wang wrote:
> > This patch adds Audio DT nodes for LS1028ARDB and LS1028AQDS boards.
> >
> > Signed-off-by: Alison Wang <alison.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |   62
> ++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   63
> +++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   57
> +++++++++++++++++++
> >  3 files changed, 182 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > index 14c79f4..139728e 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> > @@ -32,6 +32,49 @@
> >  		device_type =3D "memory";
> >  		reg =3D <0x0 0x80000000 0x1 0x00000000>;
> >  	};
> > +
> > +	sys_mclk: clock-mclk {
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <25000000>;
> > +	};
> > +
> > +	reg_1p8v: regulator-1p8v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "1P8V";
> > +		regulator-min-microvolt =3D <1800000>;
> > +		regulator-max-microvolt =3D <1800000>;
> > +		regulator-always-on;
> > +	};
> > +
> > <snip>
> > +
> > +			codec: sgtl5000@a {
> > +				#sound-dai-cells =3D <0>;
> > +				compatible =3D "fsl,sgtl5000";
> > +				reg =3D <0xa>;
> > +				VDDA-supply =3D <&reg_1p8v>;
> > +				VDDIO-supply =3D <&reg_1p8v>;
> > +				clocks =3D <&sys_mclk>;
> > +				sclk-strength =3D <3>;
>=20
> What is this property?
[Alison] It is a new property. I have submitted a patch for this new proper=
ty https://lkml.org/lkml/2018/12/25/123. This patch is already merged in li=
nux-next.

For other items you mentioned, I will modify them in v2. Thanks a lot for y=
our review.


Best Regards,
Alison Wang
