Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeB1C2G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:28:06 -0500
Received: from mail-db5eur01on0040.outbound.protection.outlook.com ([104.47.2.40]:35955
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751926AbeB1C2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:28:02 -0500
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Topic: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Index: AQHTrU1Hf1e41usgzk6epS/AHdLi/aO5HKLg
Date: Wed, 28 Feb 2018 02:27:57 +0000
Message-ID: <AM3PR04MB306CAA99F88AE8F580422EF80C70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
 <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1519459369-29083-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB388;7:cZW6e2eGpxw/5hHHhUHI7VnfwIuAEL9CdtwGLlckQz9VU8fx3FAU2zjNNDftt+VaUOZQAa3VuJs3+OPDrB5YD4Q0Ufd58THHbfhiuTz8fJJwGpXTvD1pEjyXJuGPaA13zPfA9S+9LuIJI5ORanmMAf1WnvPsPf0LJKxRWW2IWf9ecB1ihMeLQTwud5Rn3f7MaYGex1EnQN3f5YE//c/3QWELkANYn2pgll6TsXriiNuXmjaKyGA1C04hVXw+dckW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e75cf0a-e5c8-4818-ee62-08d57e52e1ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB388;
x-ms-traffictypediagnostic: AM3PR04MB388:
x-microsoft-antispam-prvs: <AM3PR04MB38893588B03D60BBC30EE7980C70@AM3PR04MB388.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501211)(52105095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB388;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB388;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(39380400002)(346002)(13464003)(199004)(189003)(3846002)(6116002)(5660300001)(3660700001)(2906002)(3280700002)(39060400002)(68736007)(7736002)(55016002)(14454004)(81156014)(81166006)(8936002)(8676002)(2201001)(229853002)(86362001)(478600001)(4326008)(7696005)(9686003)(105586002)(74316002)(2950100002)(305945005)(66066001)(2900100001)(7416002)(53936002)(53546011)(2501003)(102836004)(25786009)(5250100002)(99286004)(26005)(33656002)(76176011)(6436002)(54906003)(110136005)(6506007)(316002)(106356001)(6246003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB388;H:AM3PR04MB306.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0rqDnW2UYCPYIcoPNA11dxWJv+dNJpt8RTsLP0VfqEbfPwKYaU/mo1KJqnowN2ApqcEjVGA8v/okq4ThfKMWECGJAUjdWqk4pA6c6dkO0EKMxD5MfLnLYVQ8vvq4hPZjBYGS/yDGNFsqkkFO7EBdp9VCCI5RVFLIJJQ65r2/btM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e75cf0a-e5c8-4818-ee62-08d57e52e1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 02:27:57.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB388
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1S2SDqg019747

> -----Original Message-----
> From: Anson Huang [mailto:Anson.Huang@nxp.com]
> Sent: Saturday, February 24, 2018 4:03 PM
> To: rui.zhang@intel.com; edubezval@gmail.com; robh+dt@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; kernel@pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; linux@armlinux.org.uk
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: [PATCH V4 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> This patch adds i.MX7 thermal sensor support, most of the i.MX7 thermal
> sensor functions are same with
> i.MX6 except the registers offset/layout, so we move those registers
> offset/layout definitions to soc data structure.
> 
> i.MX7 uses single calibration data @25C, the calibration data is located at
> OCOTP offset 0x4F0, bit[17:9], the formula is as below:
> 
> Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
