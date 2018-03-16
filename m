Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeCPK2I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:28:08 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:52787
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751938AbeCPK2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:28:05 -0400
From: "A.s. Dong" <aisheng.dong@nxp.com>
To: Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
Thread-Index: AQHTvQz2YhmgOP+1hkyYZfneeN1cTKPSqJ3g
Date: Fri, 16 Mar 2018 10:28:01 +0000
Message-ID: <AM3PR04MB306ED8D196C18858B5B368480D70@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1521190471-25242-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1521190471-25242-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB355;7:FQnrmkaPytxbGHBVrPItsK50v1hCe41Xb3lGlCCK9e0lZEo5HZ6ss+8YfIm48t3GZjekrxN0WRNurgcIQELUVfTyhHiLNiPDcV6Fv7tUpDD4LINgt2fjtH/jRAkfQCV8BEIcd4Z1phOzLYNTiw6rv8pVMvS1GGXfFNDVAwyv8WABHgmqEf6Vz2/+VgRsFR9C9hUy3sQdQQIwIgJjo+J5CBSc246pKI7LyT4jJnq55PrHkViGZ7hjYZzFkBP6OlPJ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5197660-ff5a-48ca-7624-08d58b289889
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB355;
x-ms-traffictypediagnostic: AM3PR04MB355:
x-microsoft-antispam-prvs: <AM3PR04MB355682E383E722B92BA530280D70@AM3PR04MB355.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB355;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB355;
x-forefront-prvs: 0613912E23
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(199004)(13464003)(189003)(2950100002)(3660700001)(105586002)(6246003)(4326008)(25786009)(6436002)(54906003)(229853002)(110136005)(66066001)(33656002)(55016002)(53936002)(9686003)(106356001)(6506007)(53546011)(2900100001)(74316002)(102836004)(5660300001)(316002)(81156014)(76176011)(81166006)(8936002)(8676002)(7736002)(305945005)(14454004)(68736007)(26005)(3846002)(6116002)(7696005)(5250100002)(478600001)(86362001)(97736004)(2201001)(99286004)(3280700002)(2906002)(2501003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB355;H:AM3PR04MB306.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: icgmOYuuzVb6leJtlY76OPqT+UpUIZoduf0o7u/6MvExZ8jcAyzjCeDyn//Ce3O5QXZLo8U77Onzf55o4Yf6Otonn7KSytADkBT0Ierqi8PEif5m27u/YZVsR77pdUQs1Zj7C3I+zTMR/YCCuHRD6rNrzkn065d506q8UzBQ7G4ia2nnyF3h5WOrmkZtc5sEeeOL3TTtdb3MfhIzBFZwRyR/DFocboWawYBiu5vbWfvM0CIDSAnacbRC9vgLe7n097BA0lAZx/zMYQ7MOU8RMRkGHh4dSARTmC+u+adCfPMce8eIjlpvG+lk6+MTLnNosBp2R4vLzzJmMuG8j6HXKg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5197660-ff5a-48ca-7624-08d58b289889
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2018 10:28:01.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB355
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2GASFA3017866

> -----Original Message-----
> From: Anson Huang [mailto:Anson.Huang@nxp.com]
> Sent: Friday, March 16, 2018 4:55 PM
> To: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> linux@armlinux.org.uk
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] ARM: dts: imx7d-sdb: add gpio key support
> 
> Add support for imx7d-sdb board's gpio keys:
> 
> S1(FUNC1): KEY_VOLUMEUP
> S3(FUNC2): KEY_VOLUMEDOWN
> 

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-
> sdb.dts index 7f241af..e47b5b2 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -52,6 +52,24 @@
>  		reg = <0x80000000 0x80000000>;
>  	};
> 
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		volume-up {
> +			label = "Volume Up";
> +			gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +
> +		volume-down {
> +			label = "Volume Down";
> +			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEDOWN>;
> +		};
> +	};
> +
>  	spi4 {
>  		compatible = "spi-gpio";
>  		pinctrl-names = "default";
> @@ -519,6 +537,12 @@
>  			>;
>  		};
> 
> +		pinctrl_gpio_keys: gpio_keysgrp {
> +			fsl,pins = <
> +				MX7D_PAD_SD2_RESET_B__GPIO5_IO11
> 	0x59
> +				MX7D_PAD_SD2_WP__GPIO5_IO10
> 	0x59
> +			>;
> +		};
> 
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
> --
> 2.7.4
