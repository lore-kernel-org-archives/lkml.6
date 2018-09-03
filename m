Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108912077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kr6t4r9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108912077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeICIdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:33:03 -0400
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:59713
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbeICIdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HP7eLuaqHsWPxY9Td3GWoHrDTilw1jiNgG1vBY3A+Q=;
 b=kr6t4r9QCKnCjuBWgnE9lvEFS4sGi2SEa7bw9xoD0UxuBhT30AWcIteCXSwKUmCRGQOSz21WAVAzvalXvDFhpOvZmjseaYlexNLLHyYQYmmkT21qv6ijGR28kut9pxD/Y9BZ6TgdZVoOBU7O3gB9h4sQ+4rhLJmQJaVmby8po68=
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com (20.177.42.87) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 3 Sep 2018 04:14:41 +0000
Received: from AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::6d55:7614:9511:b658]) by AM0PR04MB5314.eurprd04.prod.outlook.com
 ([fe80::6d55:7614:9511:b658%4]) with mapi id 15.20.1080.019; Mon, 3 Sep 2018
 04:14:41 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: chipidea: imx: make MODULE_LICENCE and
 SPDX-identifier match
Thread-Topic: [PATCH] usb: chipidea: imx: make MODULE_LICENCE and
 SPDX-identifier match
Thread-Index: AQHUQuOSyx5gJLCIv0CnjbT5pJcLi6Td8z2w
Date:   Mon, 3 Sep 2018 04:14:41 +0000
Message-ID: <AM0PR04MB53146633EA4508612434DCCB8B0C0@AM0PR04MB5314.eurprd04.prod.outlook.com>
References: <20180902173650.5514-1-marcus.folkesson@gmail.com>
In-Reply-To: <20180902173650.5514-1-marcus.folkesson@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5299;6:EgWYr6FT7SBhe6ZWq5D8yEwY3rMrW7S15BrDkbiE8iEGOUq6d401zYmitqc1segVmCU9GkLfM0YFVPo1AokUJmlYkJIkyhrJKXk1RQQ1ASr2QaXIGOK5NvsasHUiEuo8Ktj6vC/fb48iqxiU9y5l1s2qwN8v45Z+bd3cYfAC49SgpXUu9+jL56fHLnzueerL8zmNFXuY8LPS7uKU3PlCZucu1mBKGm5XHmYIHyJmZ6YeXnr2h4XgcqdN5vc+erh3sX6RXdYsF5/5axSu7oNFbnscr6/OVBYyZD6tE01uyg/R/RIaHdJkAhj/3SYavyRuYh5DoOmhVuvEoyG4E21cXRctWxsMGUqg82dSDPcbUjTnUFJZjSe7rrXg1QvrhhQujlpsQ51rNI54AybfRooOKjl4+F6AISkoIcuwPgq9eZtut/okMjSty4CnXHe/yxA5syPvSSTDAMgJcWqcTwsIig==;5:wa7OoxqZ/zMPs2dWYR+MztXiNZNMHzleLwG6Z6h0XGU6LpG3ma4/bNG5elULrDnbvVmJd1ZXRm5oGfPdtPWathevKLN1VKhZF8FIL+cjkIEPew4vSVhg/R3/wSyhzR37qUJG8+C75ybXMpp1/qWls0pfqUJ7pgbVoUaj/At69V4=;7:XuAwbn8uQ8YQ2UoCfqDF0Y7IEWu8cZKBCogs8D0mzwj1gWAKACIh5zm+3SmuqMFgIfPfyU4x9eJvT1nr7HAPD7Fx34KZJ9IFSVLESwAYLkhbtYcdghq1Mbqz5aGij24/fBy7qjkitRCfnLEvoLnM++Lh5P9aP8M+tTx2NnYIo5ZZvUOdr4V4N6VA/PrgVIN1PCfj1sTsDr/VkfWyYG6FEl6Oeqx9+8fL0Q6J2MwX17oBaf89YqlgVzC6iFiBRG+x
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb477687-df5d-4167-1db1-08d61153c57f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5299;
x-ms-traffictypediagnostic: AM0PR04MB5299:
x-microsoft-antispam-prvs: <AM0PR04MB5299E963C41A7E7A83CC486F8B0C0@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(101931422205132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR04MB5299;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5299;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(7736002)(305945005)(99286004)(76176011)(33656002)(14454004)(3846002)(478600001)(7696005)(6116002)(97736004)(74316002)(54906003)(5250100002)(2906002)(110136005)(105586002)(486006)(316002)(106356001)(186003)(2900100001)(68736007)(102836004)(6506007)(26005)(229853002)(44832011)(4326008)(86362001)(11346002)(81156014)(81166006)(5660300001)(25786009)(8936002)(446003)(476003)(9686003)(66066001)(55016002)(39060400002)(53936002)(256004)(6436002)(8676002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5299;H:AM0PR04MB5314.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6Lk3Xrzsp1VCJsxYI8VQLtOJkceUmnD4sWK1+lmlVOMtkdcUeOJTUbPUBQrRhdURHG31xigGykj4eMK4lduyZ/Kf4+3VtA4I/xCw8pPufCi+YIErraJlvX6/WdgYsDcrcyEr30nagygmWKrPrqqQQ76Kbtzm7Xvj8ROMy5OKbZEh/5XniN1YZd/5nNR3KGT16ak3Gs9A9S6bYiVn6rOEDuLF9iBrA2i6Bh4p3VBfKcaVOQy22z5wdEvU73zjWr+Ve6m+x9dJuUPv6gFBFxHyJMwe1G7uXe206WMkus0ulY4mT0KIwd8TVRNLTYuWXhQF04KsfYoMf8ITW03MLtLdgPXGrFvnekHAEw6/UDNiulI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb477687-df5d-4167-1db1-08d61153c57f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 04:14:41.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> The SPDX-License-Identifier is set to GPL-2.0+, which correspond to
> MODULE_LICENSE "GPL".
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-  drivers/usb/chipidea/usbmisc_=
imx.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci=
_hdrc_imx.c
> index 19f5f5f2a48a..555d398fbfa7 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -492,7 +492,7 @@ static struct platform_driver ci_hdrc_imx_driver =3D
> {  module_platform_driver(ci_hdrc_imx_driver);
>=20
>  MODULE_ALIAS("platform:imx-usb");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("CI HDRC i.MX USB binding");
> MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>"); diff --git
> a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index 34ad5bf8acd8..d9cfa00b8a6c 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -633,6 +633,6 @@ static struct platform_driver usbmisc_imx_driver =3D
> {  module_platform_driver(usbmisc_imx_driver);
>=20
>  MODULE_ALIAS("platform:usbmisc-imx");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("driver for imx usb non-core registers");
> MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");

Greg, does this is a useful change? I am not sure.

Peter
