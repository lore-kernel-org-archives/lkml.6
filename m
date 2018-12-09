Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600C1C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A5620672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUKZszo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A5620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLIO0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:26:40 -0500
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:42112
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeLIO0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnf1zQkMWNUYqRXqqcv4aF6W7b0nAWY7Of4XS97j5rI=;
 b=dUKZszo9Gwi35MYk3eugcF3pe0S7tlLNyy/2Cptq0R6BVmSpn0oZHr5LJc9C+1ibZjbRlUxf1wOA8y0yl9xtPhVX5gglxQC1vN6P248OaR77/vw0PBK8AsTb0f6ebViPRoh2aHFkL066S5UwFl0qZW4rk9lALRBF0R8OlBJXGN4=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3910.eurprd04.prod.outlook.com (52.133.29.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Sun, 9 Dec 2018 14:26:09 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%4]) with mapi id 15.20.1404.025; Sun, 9 Dec 2018
 14:26:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 4/6] MAINTAINERS: add i.MX8 DT path to i.MX architecture
Thread-Topic: [PATCH v5 4/6] MAINTAINERS: add i.MX8 DT path to i.MX
 architecture
Thread-Index: AQHUj8sg6oMVnX7IAEu+p0UQ2ghn8A==
Date:   Sun, 9 Dec 2018 14:26:09 +0000
Message-ID: <1544365552-30270-5-git-send-email-abel.vesa@nxp.com>
References: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544365552-30270-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3910;6:arpZoswgFsm/buNFbwmRQuR/SbHa5/lIlmXEhmPnljThK9PnZUEOshfney5ADewjT3jx1fRXMVyRZWXj55vcCzjp2t8iA9rTCstEUYb4A+hL1EuOibHKhflFaiZWA/4o+wFtwCU+Q+wA2fPmo6qn3jO3mkM2CKlsSlxc3WH2G+unVhucfOyTXMOTDK7jrjiLFt1KtJGh0+C83BskVHo7+DWJmaZ47FlwwsFfEQ2za4aJh5Xi+S0G520g3JR5WPD9rZu2ZC57x6gJDM/ZPNmA8MtZwUKcbGwt3oJkJPbzAi05qY5zT8uhFt/YvcE4dIQRCb5hKc1YbcwLTdDpe3Or99QoFoWdRpXDC3+aF587DkiLnD1KhLnQML5qJkT4Sm0zftJt6kq2Vl9I0RRCVVhK2X28PjjG80I8VgvLU3Vie8HX7G1saIf5w1OcEW8ijolTP+8L2TLylnEvG2R0lzNjWA==;5:ei5dTsl0Y1sxiKWdmitEY/PRiKCEqmiM+DdAc+U63WFj7o1fk9YdVx0t20J+6Pb3KiicA3KKxS5XkfQNzGUCDNzGiqUsV1/NNS99lPTQkJyz+Kqk1MpPNp4p+HLdL1+xjIokVUH6rNo8lDKQijTzW6FSL33WMpuizqGN4dS95XM=;7:b8Dqt9PdK0iChaMLCgj39B82sixaQ10MSAn2l2mCyK9aL3jgWhz1BL7WM5c90VbfEEHicFPqQeCBkxFyF7KWMDc83xut9NI+2NZnRZ0wwVM0YaQklRMcfM95sWp6JixKeYymR6llYCuh7ZqutLZNcg==
x-ms-office365-filtering-correlation-id: bcd85004-8724-4dd4-3056-08d65de24308
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3910;
x-ms-traffictypediagnostic: AM6PR0402MB3910:
x-microsoft-antispam-prvs: <AM6PR0402MB3910407C2777FE1B8109B408F6A40@AM6PR0402MB3910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3910;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3910;
x-forefront-prvs: 0881A7A935
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(26005)(446003)(5660300001)(25786009)(11346002)(71190400001)(2906002)(106356001)(105586002)(54906003)(3846002)(7736002)(44832011)(305945005)(2501003)(6116002)(476003)(486006)(2616005)(66066001)(97736004)(8676002)(4326008)(53936002)(99286004)(6436002)(81166006)(110136005)(6486002)(186003)(81156014)(68736007)(6512007)(386003)(6506007)(478600001)(86362001)(256004)(14454004)(36756003)(76176011)(71200400001)(102836004)(8936002)(52116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3910;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NBHl6yIf8gIwc3zBLohlJ+qfBnxSePtNreJaeyD+IPDsjM5Rcm+oCKf166/YZZ1PHVkVzo2JC56Cd68nou3TmvCQe2HAfnuxfBITm2fxvQbYCL0XWSWWE7302W3qtprCDitayPKaIc3sVKtqsBEypqcrDl4BDrEZWvHdvaO/UArYTwJjbJCgcQXj1gM9Rst+pMI3zoEED+rE3a16NAs0IPjW42wB2ypoFszjQuSX6H+a8cWzFyGBp5TXuCNKYpLd8jyf2yWcWIwrJeF7fHqYEkyN4N9ZLwrwzWON7+2uE1PoRby0j/aUE0D1tEFrmuyL/sSWxNwOGPwilkNqe8mNTvGSm0kyOwqDtJM3yWa2JpI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd85004-8724-4dd4-3056-08d65de24308
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2018 14:26:09.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Shawn agreed to take patches for the i.MX8 parts through his tree.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3625a8d..b41ebff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,6 +1530,7 @@ F:	arch/arm/mach-imx/
 F:	arch/arm/mach-mxs/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
+F:	arch/arm64/boot/dts/freescale/imx*
 F:	drivers/clk/imx/
 F:	drivers/firmware/imx/
 F:	drivers/soc/imx/
--=20
2.7.4

