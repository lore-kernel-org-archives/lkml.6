Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935352AbeBMNcc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:32:32 -0500
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:35760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935174AbeBMNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:32:31 -0500
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Stefan Agner <stefan@agner.ch>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] MAINTAINERS: add Freescale pin controllers
Thread-Topic: [PATCH v2] MAINTAINERS: add Freescale pin controllers
Thread-Index: AQHTpBMKNXeeThGruUuuMxSmHqfPqaOiVVdQ
Date: Tue, 13 Feb 2018 13:32:26 +0000
Message-ID: <AM3PR04MB306CC7D8349BD66C47BDD0180F60@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <20180212150549.8622-1-stefan@agner.ch>
In-Reply-To: <20180212150549.8622-1-stefan@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0822;7:HSiBc8pscqHvOZ3Z0mbtRLv9HNmv8IpOkyxkCkNDeOhXmLe83CPSSCwbB859ZoJ9AVhQCl4zC3s15+BHJKmltvlzrP+R0n9JJnZNDBjcgfx4cKJSD3ih/ncjT6PvC4UX8Um2DbQol8SF0FF+z6eX6fF1LkwtEzhagXqbVPtUwe424VL/BNyVFxbL4s94OjTK6AfWSbLsTSbpSp4XJwHNVgRnUTMY5Cl+VfNOpgX9lDR+R+DSukcKBgFlSHZY43SI
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39860400002)(376002)(346002)(396003)(13464003)(189003)(199004)(229853002)(54906003)(81166006)(25786009)(6506007)(53546011)(2906002)(55016002)(3846002)(102836004)(99286004)(2950100002)(6116002)(478600001)(8936002)(76176011)(106356001)(8676002)(186003)(81156014)(26005)(316002)(110136005)(33656002)(4326008)(3660700001)(5660300001)(105586002)(66066001)(2201001)(6436002)(97736004)(575784001)(53936002)(86362001)(74316002)(6246003)(5250100002)(9686003)(14454004)(7736002)(2501003)(305945005)(2900100001)(7696005)(68736007)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0822;H:AM3PR04MB306.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b082ba5-b931-4b0c-946e-08d572e63945
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB0822;
x-ms-traffictypediagnostic: AM3PR04MB0822:
x-microsoft-antispam-prvs: <AM3PR04MB0822C175EC23164B0BABB6B680F60@AM3PR04MB0822.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB0822;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0822;
x-forefront-prvs: 0582641F53
x-microsoft-antispam-message-info: UzzFt6biUHuuaHPkg7PW0qLld0X8KLBLy8d75Nyemn5GsODafMUYqQzQAV4EiLPD2aReahmgzOy4x1qgKTIPNw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b082ba5-b931-4b0c-946e-08d572e63945
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2018 13:32:27.0449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0822
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1DDWjD4031038

Hi Stefan,

> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Monday, February 12, 2018 11:06 PM
> To: linus.walleij@linaro.org; A.s. Dong <aisheng.dong@nxp.com>; Fabio
> Estevam <fabio.estevam@nxp.com>; shawnguo@kernel.org;
> kernel@pengutronix.de
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Stefan Agner <stefan@agner.ch>
> Subject: [PATCH v2] MAINTAINERS: add Freescale pin controllers
> 
> Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer and
> the Pengutronix kernel team as reviewer.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks for sending this.
Besides Joe's comments, I'm fine with it.
So:
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82ad0eabce4f..df60ca7c3355 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
>  S:	Supported
>  F:	drivers/pinctrl/pinctrl-at91-pio4.*
> 
> +PIN CONTROLLER - FREESCALE
> +M:	Dong Aisheng <aisheng.dong@nxp.com>
> +M:	Fabio Estevam <festevam@gmail.com>
> +M:	Shawn Guo <shawnguo@kernel.org>
> +M:	Stefan Agner <stefan@agner.ch>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pinctrl/freescale/*
> +F:	Documentation/devicetree/bindings/pinctrl/fsl,*
> +
>  PIN CONTROLLER - INTEL
>  M:	Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> --
> 2.16.1
