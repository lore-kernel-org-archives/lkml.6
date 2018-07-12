Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF94FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8299320883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ml7bRmzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8299320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeGLIyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:54:23 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:6560
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeGLIyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bCi6KOI+geLZFUsPkc49YEXQyPF+WHC0zEfOHPiviM=;
 b=ml7bRmzZ22qtwwxE78nmGPku3RhIm36y5rRKWXA7GpftvC509HohojGjcNOYuUTj0fLIaDb5ZflJ7FgBGSQ5lO65PfC9O1OPnjnf0c36RQOZhRoU9QJImNpWN8+aWUCiGKXKpdYofVTrTD4iPCLsJmEV4yNKcj2LISyi+A5RBys=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5170.eurprd04.prod.outlook.com (20.177.42.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 08:45:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 08:45:42 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
Thread-Topic: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
Thread-Index: AQHUGbd23lfjvt+DEEeYvW2J9AdjaqSLReyQ
Date:   Thu, 12 Jul 2018 08:45:42 +0000
Message-ID: <AM0PR04MB421179426785804D468A128580590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180712080725.14250-1-stefan@agner.ch>
 <20180712080725.14250-2-stefan@agner.ch>
In-Reply-To: <20180712080725.14250-2-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5170;7:ImOZ347wA+Du2bhhH5xV32sZxE1nWFbaBMhKok8lANBbFlhkCb9q3nRpdskNF7WSgJmDDZUczwRQ9c55Bolw8FVPCQfIbDAp85F6u35B5Lp0ef239J8r9YsxiMf21fJe/YfyzJknIabeq5+/W0aWFwqUQbmpgL/9Vk8zntoGoVT4M01uTntsHB2WuuSvUToRapbxhmtKO//ZVnwUV1bsFfjQdlFeQOBw5rBkm9D7JUbe6EgAiptH0HuJF5X4LCZH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 89fe7b85-8cc5-4278-2f40-08d5e7d3da44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5170;
x-ms-traffictypediagnostic: AM0PR04MB5170:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB5170302DC8F50263CBCC9D8A80590@AM0PR04MB5170.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5170;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5170;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(13464003)(8676002)(2900100001)(2501003)(6436002)(5250100002)(9686003)(53936002)(110136005)(229853002)(55016002)(316002)(446003)(256004)(11346002)(2906002)(478600001)(99286004)(476003)(54906003)(5660300001)(486006)(97736004)(14454004)(6246003)(33656002)(7736002)(305945005)(7696005)(4326008)(6116002)(3846002)(25786009)(53546011)(106356001)(105586002)(76176011)(81156014)(81166006)(186003)(102836004)(68736007)(8936002)(66066001)(2201001)(86362001)(6506007)(26005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5170;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8LPsf4Snfz1/7VdqzTWsXCXkaKc/IuA7T2gLj0YFvSwF6DTwuulDsTkP9CrPJltz72Lm/4/lp+sqfDHRpjyFtJe8vjdFIrQd2AQDwoZ5DJNJJlN7MHrESD4bmh8N7i2vJXDETUIBUTlawZMlQmUqwqPL0oHRUptn5wr2Pi0CPy+E8sZ/igbOk9vsCrOkUH6MzXDvBsgwLxv8XCVArVKwq9D1aQdtCYBwDWTHJze8uSWEzvzAp9s4fNeK2iEWDUt3zeyrTfQ6oWjZJLgIUFmwKUeCNItM9ErRca2/om9G9ii7qrWtMoUvuDKx9cYAFcZedIysKFrtg0uHAqvtB7JXAh4t79bL4hE6CRRaEEFVKo4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fe7b85-8cc5-4278-2f40-08d5e7d3da44
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 08:45:42.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Thursday, July 12, 2018 4:07 PM
> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
> <stefan@agner.ch>
> Subject: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
>=20
> Fix indent. This also makes disable/enable clock blocks look alike.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
