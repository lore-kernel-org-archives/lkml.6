Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CA8213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YP5Br7ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBZJE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:04:56 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:35232
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfBZJEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe5PK3L8ZVGvozmZBgO0jTrMUJ+rAjQFaQjNQYNyGP4=;
 b=YP5Br7ryZFYqNq4eZRzHHwpzzsa8j3v/HerQ1rFVsYDApuT92p66FyWwUPHzYpEo2IVg9IAEOGc2eo/xUUh0Htiv8T2yIzaWJfnio8V7D14O6MhrdyOrztVtZ4aqW+Ugwkx1PwoQMQx0lNtpYxWoxcdlwT5gGuWaRHYrvPWr8Mg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3986.eurprd04.prod.outlook.com (52.134.91.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 09:04:51 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 09:04:51 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Thread-Topic: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Thread-Index: AQHUwinfXUV9s79yzE6xqkNTp1E4f6Xx4FWA
Date:   Tue, 26 Feb 2019 09:04:51 +0000
Message-ID: <20190226090451.sxolgb6wiityfygk@fsr-ub1664-175>
References: <20190211165011.5114-1-l.stach@pengutronix.de>
In-Reply-To: <20190211165011.5114-1-l.stach@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e006a36d-a7c3-4d97-6ddf-08d69bc977c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3986;
x-ms-traffictypediagnostic: AM0PR04MB3986:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB3986;23:nrdxE3keAgxL0TE+MHfLeG9Ee4YktwOcrKAYErWtk?=
 =?us-ascii?Q?mj+jpXr43KWO0p30VqgbgDwJqU7u6b0Z7obPmhiSBQArEDlhOHYRnhRpg1W0?=
 =?us-ascii?Q?tT7rimfy0HgOoALClH84eUapV0GbcnKV4JcWbimnDjOUw758tiBL0zWH81uf?=
 =?us-ascii?Q?USQbodykUzxsSxmizQcWtY5HvHVpPgy/L7qYBKbOO4trUtoLBBNkqX90P+Wg?=
 =?us-ascii?Q?737YV9pC90Ba2u45NguYtC1EUIwFAOR3sjjiFW6c6PH0e0FbAK2r63yIFm8f?=
 =?us-ascii?Q?YZ6iJZc4NRCNRQYeqXXxo8AMQydQN7w38G0oAJNo33blJJhvUjmaEzxsKlkZ?=
 =?us-ascii?Q?KPcNfuOM3+FlOlERzxkw4mVNUs2+cTum5LyhsCp9/aYTeBACAhE0KtqGshHO?=
 =?us-ascii?Q?eOrf6iz1AbIaLoedqd2yQYVhaWRqMXPMmx1VN3jAKdSHt2cCAT0D1nZxl9uK?=
 =?us-ascii?Q?lNzjICVl3Xri3OETHQmfjdwJup5fJKEisr1qZulJf43SmoM+EwOTn3tR+Cai?=
 =?us-ascii?Q?dpCIOUAmHQH5V29VjasmaRohZ9aCfpe7KAsO7wWIYiWv43YVJFDrgbc0S+g0?=
 =?us-ascii?Q?9ugEixQDRH++yggaTw4Gclfs9F6Ox9LElRL675eKCqG0zCqcwYFBgLUaHp9V?=
 =?us-ascii?Q?TYb+zb0N5sxoLfgzUtGlPKhuWgELv/faoYtU4rotMU08/9Gpgyhm18JNDq5H?=
 =?us-ascii?Q?b4lp8IpCsJ9vas7S9wv1dHVIGWaLWvXsjbErsmRVpFuWQrvDxa+9pbcEeXIQ?=
 =?us-ascii?Q?4THDhqMXLOgqrSqv2fcYPJs6xS2aG/W3ZOMRWnhlskC1EcZIFm6GnKRZB+L6?=
 =?us-ascii?Q?0KxmbXiru/sk7Plx6ulDEk+35Evci/Qs+LSWLmg0KpzYFswSwzicIcQiGhZY?=
 =?us-ascii?Q?MSLX2Wb0jhRzSF0HjX5BNTUpjv2Ab+O7gxb0RaEU9JpIQnfIHGikFyAPsOId?=
 =?us-ascii?Q?bLetscrhsBR11i00ZCWvVm6SVpmajrizDCbH+Na8cELpE8wVKgy/6vY4+AbD?=
 =?us-ascii?Q?RIzLCk9bIqMFlfCIachojxUes8OCXghB6FOnkpWHTB5YOTttKpijaGy7bFzd?=
 =?us-ascii?Q?MIcbyXNDkS+oAw9ldmcgUSVUrCkYZhtV8RQcU3gXXUYLGW+e7T5f2e3Tg8lG?=
 =?us-ascii?Q?V+PuOBjx8jpeOJSMSERZPvyl1zdXP+FUCwV8CtTWb21LuwfE0W9BGMkqmoLH?=
 =?us-ascii?Q?ht4Rwdyk4l0GnE1Kv0SqQQiaBVP8Zd9RcJRmZLDoTOyjePubsGLvXG7dt2+0?=
 =?us-ascii?Q?RZhWj6W3aHqWUXhtf+Uyv3SCQDj5JTlxi1y5eAF?=
x-microsoft-antispam-prvs: <AM0PR04MB398683B4F25BFC622ED8571FF67B0@AM0PR04MB3986.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(6436002)(8936002)(6512007)(9686003)(53936002)(33716001)(6246003)(105586002)(106356001)(6916009)(25786009)(68736007)(229853002)(6486002)(97736004)(186003)(316002)(6116002)(4326008)(3846002)(54906003)(446003)(11346002)(476003)(44832011)(486006)(66066001)(86362001)(6506007)(53546011)(71200400001)(7736002)(478600001)(8676002)(2906002)(14454004)(81166006)(256004)(14444005)(5660300002)(76176011)(26005)(99286004)(81156014)(1076003)(102836004)(305945005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3986;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bm0lU8J8oKTKMCp99oWvkMO/mSW6QQHatrzBaP7mJbCizCVkjxVRQI5UJVYW1b7l5lv8UFg/W+XKRvBlUtdkG4gGZcaQtPV3QBy2QyZHsEVXgL+/vkO7En4QMe12/tdPDORc/vOtFnQ2bTsmrHKex6f8sotCXMm05jXieRc9GE4+m5mL+rf0n7fK02gNOvLhA2Bo4IOMmgVlozOddEKFjl16CqoDcBLgXM/h1+4aDlyF80EmEtuUANrJxqWxdKc0WmXEMuao0N/Z5b+fDRk1SimY3SUifCkdhuN7lI70n7ZOsmGB2ziT6z9tYG3K+xZjDrQ+aDy9Y96WqlsEgCMLXzjM2lXsVmFA+Mb78IksWDnW/vbpYboIer6lAHO5K6IVme3kpjeN2vkE+qrq+I8z76BMB2c7dTNcfGRLdyRwUKs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E4DD844524054459B74D0F53592B2D7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e006a36d-a7c3-4d97-6ddf-08d69bc977c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 09:04:51.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-11 17:50:09, Lucas Stach wrote:
> Add compatible for i.MX8MQ and add both i.MX7D/S and i.M8MQ
> to the description.

Hi Lucas,

This patchset does not apply on linux-next anymore due to the new additions
in the compatible lists (imx6ull/imx6ulz) in imx-ocotp.

Can you please resend ?

Thanks,
Abel

>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Docu=
mentation/devicetree/bindings/nvmem/imx-ocotp.txt
> index 792bc5fafeb9..bb8fb8fc6217 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
> @@ -1,7 +1,8 @@
>  Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
> =20
>  This binding represents the on-chip eFuse OTP controller found on
> -i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL and i.MX6SLL SoCs.
> +i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6SLL, i.MX7D/S
> +and i.MX8MQ SoCs.
> =20
>  Required properties:
>  - compatible: should be one of
> @@ -11,6 +12,7 @@ Required properties:
>  	"fsl,imx6ul-ocotp" (i.MX6UL),
>  	"fsl,imx7d-ocotp" (i.MX7D/S),
>  	"fsl,imx6sll-ocotp" (i.MX6SLL),
> +	"fsl,imx8mq-ocotp" (i.MX8MQ),
>  	followed by "syscon".
>  - #address-cells : Should be 1
>  - #size-cells : Should be 1
> --=20
> 2.20.1
>=20
