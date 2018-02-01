Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeBALoc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:44:32 -0500
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:61660
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752038AbeBALo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:44:28 -0500
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lukas.auer@aisec.fraunhofer.de" <lukas.auer@aisec.fraunhofer.de>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "ryan.harkin@linaro.org" <ryan.harkin@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 5/5] ARM: dts: imx7s: add CAAM device node
Thread-Topic: [PATCH v3 5/5] ARM: dts: imx7s: add CAAM device node
Thread-Index: AQHTmjdQ3oHtenn+oky6hXdC30uJhg==
Date: Thu, 1 Feb 2018 11:44:23 +0000
Message-ID: <VI1PR0402MB334269ACFE0805A2E31D604B98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
 <1517364040-27607-6-git-send-email-pure.logic@nexus-software.ie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com;
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3950;7:J5Q/kEc2WcTyY9CHx9wMELRCSXikPRJt+CuOQdowSkhTxIWzXTP4PgFDbFfmw+od4Uxggu5q5quQKSiGts8ZTK9+rMCwqtJJSrv8d+v1q6sFypToFTkqbUClw0ARbVBFZ/p3lGrhZ3wQpGAawAxx7qUWh7gnN3N3DB04vnr5+2/9Y3CQm6T8qeeIeGOikybO3WyjF+y57mCrKKz37iPEeQMAgAZcOdiNFU8yIsyHjLjbyktvXw136opkypMnW+I5
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(39860400002)(366004)(396003)(189003)(199004)(53936002)(76176011)(478600001)(6436002)(6506007)(59450400001)(68736007)(53546011)(3280700002)(97736004)(3660700001)(7696005)(316002)(8936002)(110136005)(229853002)(14454004)(7416002)(8676002)(33656002)(55016002)(9686003)(6116002)(26005)(2900100001)(99286004)(86362001)(5660300001)(305945005)(106356001)(5250100002)(81156014)(7736002)(54906003)(66066001)(74316002)(105586002)(3846002)(102836004)(81166006)(25786009)(2501003)(2201001)(6246003)(186003)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3950;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0da09e50-4aa5-4a24-edcf-08d5696923fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:VI1PR0402MB3950;
x-ms-traffictypediagnostic: VI1PR0402MB3950:
x-microsoft-antispam-prvs: <VI1PR0402MB39506B0F066B1F5F82D51E3498FA0@VI1PR0402MB3950.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0402MB3950;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3950;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: p2PqQp2PMplTW0XbXAOayin+E1DwpKAmXd5fa6JAVmm4txLUZyLQ7c0aEraOmqlBInz6PYzglwWtPkWw0SWrTg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da09e50-4aa5-4a24-edcf-08d5696923fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 11:44:23.8116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3950
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11Bib08025896

On 1/31/2018 4:00 AM, Bryan O'Donoghue wrote:
> From: Rui Miguel Silva <rui.silva@linaro.org>
> 
> Add CAAM device node to the i.MX7s device tree.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: "Horia Geantã" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 82ad26e..e38c159 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -805,6 +805,37 @@
>  				status = "disabled";
>  			};
>  
> +			crypto: caam@30900000 {
> +				compatible = "fsl,sec-v4.0";
> +				fsl,sec-era = <4>;
CCBVID[CAAM_ERA] = 8.
Either remove this (optional) property and let the bootloader add it
dynamically, or provide a correct value for it.

Thanks,
Horia
