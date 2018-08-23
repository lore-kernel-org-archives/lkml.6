Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AED20936
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxRiRtDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AED20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeHWK1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:27:31 -0400
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:53152
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbeHWK1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMwLMJDWv3Mgkp3S36D+DCH2lcvhQpVdpoDcJhDvlSU=;
 b=kxRiRtDcgomQ/FR07sO8xa7kcSjXjf8Rf+2vM/Ka+0QqSXuzA64OJR9Fh1pzc4/qb+cd0ktlHBz6ulm8H8HvpoxH+py3ExJJ7OPH6j+dCMxaURK1cBVHAgX/f172WZ4bYM3jhi5lAqgyxHek/Zm7YcciXR//D5zOzQTw9TqCJIY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Thu, 23 Aug 2018 06:59:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::c0c1:51f1:411f:f13c%3]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 06:58:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6ull: correct machine model name
Thread-Topic: [PATCH] ARM: dts: imx6ull: correct machine model name
Thread-Index: AQHUOqt7Hsif6g0EuEqCRZ4HdtBZgqTM57eAgAAAP3A=
Date:   Thu, 23 Aug 2018 06:58:49 +0000
Message-ID: <DB3PR0402MB3916F5B4C327E4F08125C4DAF5370@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
 <20180823065717.ibntomnnamkdbyyq@pengutronix.de>
In-Reply-To: <20180823065717.ibntomnnamkdbyyq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3866;6:zPzhrCB9guzOD0It72+w1eVv89u/XWdpsgiGZ1kNE0Epr7AutYDHTszfISslh4dh+YliuGT1m4WTVXIv8RlQKC0CmnGWokz084XZjZhfL0e2kRKksFU2y0Y2oC5p0aCusYc2NyyxVUGedXDk1XUO8Nqe7zWTE3REjf0P1RxSxqshzpk3uy+UGNAz3R1RuGShjWDtp4rTwRzO7tpvhGUzEWbL4jybBl3XTrvgo7pl6KUa/OkXHdW+cqjlq6vnnZDBVvSSqHCqaD7P1G+89EyxIGelozIhs9uhX5FSq4bfVIA2tA+UVoXUdg0xw0TAVn/hyId8Tloz5JBui2RRXcE7jawgY9LItq5i46uz4iK93md4yXdywm2A29GJBmYfabsgrgl2xsZAVUrcL+fVd4t5AR6GgHsXSsYlhe/UlZUG9zb4tXEtJJtCdNKoWuOArmdHkHn35zc9q8i1gb/H3Mn+rw==;5:+voVtkfehNto0VyPZlhhPDD+h0zNp7IhVstX9acGeceo81apZb39FJu1sj6/IVza1HsjW+OcpACyfNSJCTyuJ/ApCeaa8WlHfNCu0Ke9POL4rJNf9dBau4wT5U4m2VkQZuPl3t1Ciy+MsKiji82fsh/dX/vfWYinHDxTQ0x7hVI=;7:RdGxXjXlejy3hzX26rRZp5XnL3DJSyvuwyo946TBQQiGcyCMqvwXCGoVUyyuHrkzAz42HC/2w9Z3CSefzZIHuOhFuR4b/IjKW1PeGJGjgKsZoJU7PlJYbpJNbr5Nm9cLi2JDa0usfn/95UtAj51yLe3mGOMhiBe7adtohLeUkcKy6h2PHoHBKCHpBsp0SttRMpUbD+MSRYMvV78TdRfWKJ1hlQj3HwKOX8KkSWNeyiWZiXahq67YgMxCXanitoWu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4361ee67-2635-4e8f-5738-08d608c5e149
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3866;
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB386690E0FE48A99ACC3BD45FF5370@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB3PR0402MB3866;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3866;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(346002)(39860400002)(189003)(199004)(13464003)(25786009)(4326008)(106356001)(105586002)(575784001)(97736004)(102836004)(86362001)(45080400002)(66066001)(53546011)(6506007)(478600001)(68736007)(99286004)(8936002)(81156014)(6246003)(81166006)(966005)(14454004)(8676002)(7696005)(76176011)(33656002)(6916009)(44832011)(6436002)(476003)(486006)(229853002)(53936002)(2900100001)(54906003)(6116002)(3846002)(14444005)(256004)(5660300001)(5250100002)(316002)(2906002)(26005)(74316002)(7736002)(186003)(305945005)(55016002)(6306002)(11346002)(446003)(9686003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3866;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yTAnb4rYQkjSqwl744zfGxJvLuqRl425IQZaP2BF6O8qNjGfopOvd8In69It9aB/aBcXoLI3fZcaEq+ObWt79eeZATkLXgyvQHvujbk4fcGooJTmgtZY0wmabzvl4ERoMBCtoNN7lGmckqzCFFAZzLPMAxfYeI0+uSZDf9ouQh/vkzyr6VYrVbh8iM8F9opTibMgMrT6IWvF8Do4IMW0nWIbC/Cd/2YL3Q2s2J/TvY9ROc+o/li8EU4/WhJ4fdHgcZY2oJN1b7EIlfTkE+Q9XNop9F6I46CdCPPGuswAcQuX8OY6in7BisN8G//0BzK4zwFDNgL587T5eUBN1mkAnev8Swv5u5frG2jXraLlZno=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4361ee67-2635-4e8f-5738-08d608c5e149
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 06:58:49.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sacha

Anson Huang
Best Regards!


> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Thursday, August 23, 2018 2:57 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx6ull: correct machine model name
>=20
> Hi Anson,
>=20
> The board name should be in the subject to let the reader know this is no
> generic i.MX6ull change.
=20
Thanks for comment, will fix it in V2 patch.

Anson.

>=20
> Sascha
>=20
> On Thu, Aug 23, 2018 at 02:30:49PM +0800, Anson Huang wrote:
> > i.MX6ULL is a lite version of i.MX6UL, its full name is i.MX6
> > UltraLiteLite, NOT UlltraLite.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > index 30ef603..0ba6454 100644
> > --- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > +++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> > @@ -45,7 +45,7 @@
> >  #include "imx6ul-14x14-evk.dtsi"
> >
> >  / {
> > -	model =3D "Freescale i.MX6 UlltraLite 14x14 EVK Board";
> > +	model =3D "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
> >  	compatible =3D "fsl,imx6ull-14x14-evk", "fsl,imx6ull";  };
> >
> > --
> > 2.7.4
> >
> >
>=20
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C59
> 4938583dae4ac0ab1208d608c5af45%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C636706042476455956&amp;sdata=3DbMBKPPTa17ALKbCF8jvTtIj
> dviMwKxXMW%2F%2F02xkzWO8%3D&amp;reserved=3D0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
