Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCMGNd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:13:33 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:23200
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751406AbeCMGN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:13:29 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Leonard Crestez <leonard.crestez@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V6 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Topic: [PATCH V6 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Index: AQHTscqq4xyFSkSO00aA33YZSwaleqPNv7XQ
Date: Tue, 13 Mar 2018 06:13:24 +0000
Message-ID: <AM3PR04MB13158EE8C129D6AEC605A106F5D20@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
 <1519955970-11365-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1519955970-11365-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: rui.zhang@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB323;7:BztK7WeEf4hHvPbbOTKbbWXcnj/fx4sInLLQM0QI5r9MkbAtvszrBY18fTqLIL67uBRXPHcqboOQq6WrGr+uRr4Uh9PmEZn6DIxJtzce3fcrC5DVsEftdF4LVpd2ZekUfVeLLUzfIfbkX8FiZHvbZ3S6HiLmOay/iY5+QWSBcMut/7z0d6rd98quFc9WyCpSRrhgw0cpf5DEu4D/iVWBiNFlGvPtr/U56nluAfy+AAXU0fceUor3xFLE/ON7qb3H
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15e458e0-431b-412f-dfe3-08d588a987c0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB323;
x-ms-traffictypediagnostic: AM3PR04MB323:
x-microsoft-antispam-prvs: <AM3PR04MB3236D720FE17912ACBE1708F5D20@AM3PR04MB323.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB323;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB323;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39380400002)(39860400002)(376002)(199004)(189003)(13464003)(6116002)(68736007)(7736002)(7696005)(102836004)(6306002)(9686003)(53936002)(26005)(99286004)(575784001)(86362001)(2900100001)(3280700002)(2201001)(106356001)(53946003)(76176011)(74316002)(81156014)(316002)(81166006)(5660300001)(8676002)(305945005)(7416002)(6346003)(229853002)(478600001)(54906003)(110136005)(39060400002)(8936002)(3846002)(966005)(25786009)(14454004)(2906002)(33656002)(2501003)(45080400002)(3660700001)(59450400001)(105586002)(66066001)(6246003)(6436002)(4326008)(5250100002)(55016002)(2950100002)(53546011)(6506007)(97736004)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB323;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-microsoft-antispam-message-info: SH9mP8pypXqoTfFiFG7a/TEGfgUKT1PUtWsZsEQeUIEJZnB9hjFHJsLmr/xad2k579cCiJsUVcy8UgbJvFVWUYvqo4nzoGV74iTqkvVmIb+oKr9ZQunpRrTh803twUfNvL2Alie/BR8n5py5B+N2V3F9llKlazu78dAsIdbXgRA10v99nF3RN2dm2L6nYLl+nZT7dxXb0/xMHqk00xodW9Hz7oE90oEcGn6WaAdoEuIpU6ZOeM3I1+qbCZEOkRZ7xtV/bild8g1gKOgGJRojaVLn2kEiFposf644VeJVTnKg43buJ+87rGPFI3JezYXWeR0WOR6HReOmlnll3kl79A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e458e0-431b-412f-dfe3-08d588a987c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 06:13:25.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2D6DelY022421

Ping...

@rui.zhang@intel.com, can you help review this patch?

Anson Huang
Best Regards!


> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Anson Huang
> Sent: Friday, March 2, 2018 10:00 AM
> To: Leonard Crestez <leonard.crestez@nxp.com>; rui.zhang@intel.com;
> edubezval@gmail.com; robh+dt@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; linux@armlinux.org.uk
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org
> Subject: [PATCH V6 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> This patch adds i.MX7 thermal sensor support, most of the i.MX7 thermal sensor
> functions are same with
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
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> changes since V5:
> 	no code change, just add Reviewed-by.
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
>  drivers/thermal/imx_thermal.c                      | 295
> ++++++++++++++++-----
>  2 files changed, 239 insertions(+), 65 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 28be51a..38bffcc 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -1,8 +1,13 @@
>  * Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
> 
>  Required properties:
> -- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for
> i.MX6SX.
> -  i.MX6SX has two more IRQs than i.MX6Q, one is IRQ_LOW and the other is
> IRQ_PANIC,
> +- compatible : must be one of following:
> +  - "fsl,imx6q-tempmon" for i.MX6Q,
> +  - "fsl,imx6sx-tempmon" for i.MX6SX,
> +  - "fsl,imx7d-tempmon" for i.MX7S/D.
> +- interrupts : the interrupt output of the controller:
> +  i.MX6Q has one IRQ which will be triggered when temperature is higher
> +than high threshold,
> +  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW
> +and the other is IRQ_PANIC,
>    when temperature is below than low threshold, IRQ_LOW will be triggered,
> when temperature
>    is higher than panic threshold, system will auto reboot by SRC module.
>  - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index a67781b..569d41b 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -31,35 +31,57 @@
>  #define REG_CLR		0x8
>  #define REG_TOG		0xc
> 
> -#define MISC0				0x0150
> -#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
> -#define MISC1				0x0160
> -#define MISC1_IRQ_TEMPHIGH		(1 << 29)
> +/* i.MX6 specific */
> +#define IMX6_MISC0				0x0150
> +#define IMX6_MISC0_REFTOP_SELBIASOFF		(1 << 3)
> +#define IMX6_MISC1				0x0160
> +#define IMX6_MISC1_IRQ_TEMPHIGH			(1 << 29)
>  /* Below LOW and PANIC bits are only for TEMPMON_IMX6SX */
> -#define MISC1_IRQ_TEMPLOW		(1 << 28)
> -#define MISC1_IRQ_TEMPPANIC		(1 << 27)
> -
> -#define TEMPSENSE0			0x0180
> -#define TEMPSENSE0_ALARM_VALUE_SHIFT	20
> -#define TEMPSENSE0_ALARM_VALUE_MASK	(0xfff <<
> TEMPSENSE0_ALARM_VALUE_SHIFT)
> -#define TEMPSENSE0_TEMP_CNT_SHIFT	8
> -#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff <<
> TEMPSENSE0_TEMP_CNT_SHIFT)
> -#define TEMPSENSE0_FINISHED		(1 << 2)
> -#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
> -#define TEMPSENSE0_POWER_DOWN		(1 << 0)
> -
> -#define TEMPSENSE1			0x0190
> -#define TEMPSENSE1_MEASURE_FREQ		0xffff
> -/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
> -#define TEMPSENSE2			0x0290
> -#define TEMPSENSE2_LOW_VALUE_SHIFT	0
> -#define TEMPSENSE2_LOW_VALUE_MASK	0xfff
> -#define TEMPSENSE2_PANIC_VALUE_SHIFT	16
> -#define TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
> +#define IMX6_MISC1_IRQ_TEMPLOW			(1 << 28)
> +#define IMX6_MISC1_IRQ_TEMPPANIC		(1 << 27)
> +
> +#define IMX6_TEMPSENSE0				0x0180
> +#define IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT	20
> +#define IMX6_TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << 20)
> +#define IMX6_TEMPSENSE0_TEMP_CNT_SHIFT		8
> +#define IMX6_TEMPSENSE0_TEMP_CNT_MASK		(0xfff << 8)
> +#define IMX6_TEMPSENSE0_FINISHED		(1 << 2)
> +#define IMX6_TEMPSENSE0_MEASURE_TEMP		(1 << 1)
> +#define IMX6_TEMPSENSE0_POWER_DOWN		(1 << 0)
> +
> +#define IMX6_TEMPSENSE1				0x0190
> +#define IMX6_TEMPSENSE1_MEASURE_FREQ		0xffff
> +#define IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT	0
> 
>  #define OCOTP_MEM0			0x0480
>  #define OCOTP_ANA1			0x04e0
> 
> +/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
> +#define IMX6_TEMPSENSE2				0x0290
> +#define IMX6_TEMPSENSE2_LOW_VALUE_SHIFT		0
> +#define IMX6_TEMPSENSE2_LOW_VALUE_MASK		0xfff
> +#define IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT	16
> +#define IMX6_TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
> +
> +/* i.MX7 specific */
> +#define IMX7_ANADIG_DIGPROG			0x800
> +#define IMX7_TEMPSENSE0				0x300
> +#define IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT	18
> +#define IMX7_TEMPSENSE0_PANIC_ALARM_MASK	(0x1ff << 18)
> +#define IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT	9
> +#define IMX7_TEMPSENSE0_HIGH_ALARM_MASK		(0x1ff << 9)
> +#define IMX7_TEMPSENSE0_LOW_ALARM_SHIFT		0
> +#define IMX7_TEMPSENSE0_LOW_ALARM_MASK		0x1ff
> +
> +#define IMX7_TEMPSENSE1				0x310
> +#define IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT	16
> +#define IMX7_TEMPSENSE1_MEASURE_FREQ_MASK	(0xffff << 16)
> +#define IMX7_TEMPSENSE1_FINISHED		(1 << 11)
> +#define IMX7_TEMPSENSE1_MEASURE_TEMP		(1 << 10)
> +#define IMX7_TEMPSENSE1_POWER_DOWN		(1 << 9)
> +#define IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT	0
> +#define IMX7_TEMPSENSE1_TEMP_VALUE_MASK		0x1ff
> +
>  /* The driver supports 1 passive trip point and 1 critical trip point */  enum
> imx_thermal_trip {
>  	IMX_TRIP_PASSIVE,
> @@ -72,17 +94,114 @@ enum imx_thermal_trip {
> 
>  #define TEMPMON_IMX6Q			1
>  #define TEMPMON_IMX6SX			2
> +#define TEMPMON_IMX7D			3
> 
>  struct thermal_soc_data {
>  	u32 version;
> +
> +	u32 sensor_ctrl;
> +	u32 power_down_mask;
> +	u32 measure_temp_mask;
> +
> +	u32 measure_freq_ctrl;
> +	u32 measure_freq_mask;
> +	u32 measure_freq_shift;
> +
> +	u32 temp_data;
> +	u32 temp_value_mask;
> +	u32 temp_value_shift;
> +	u32 temp_valid_mask;
> +
> +	u32 panic_alarm_ctrl;
> +	u32 panic_alarm_mask;
> +	u32 panic_alarm_shift;
> +
> +	u32 high_alarm_ctrl;
> +	u32 high_alarm_mask;
> +	u32 high_alarm_shift;
> +
> +	u32 low_alarm_ctrl;
> +	u32 low_alarm_mask;
> +	u32 low_alarm_shift;
>  };
> 
>  static struct thermal_soc_data thermal_imx6q_data = {
>  	.version = TEMPMON_IMX6Q,
> +
> +	.sensor_ctrl = IMX6_TEMPSENSE0,
> +	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
> +	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
> +
> +	.measure_freq_ctrl = IMX6_TEMPSENSE1,
> +	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
> +	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
> +
> +	.temp_data = IMX6_TEMPSENSE0,
> +	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
> +	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
> +	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
> +
> +	.high_alarm_ctrl = IMX6_TEMPSENSE0,
> +	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
> +	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
>  };
> 
>  static struct thermal_soc_data thermal_imx6sx_data = {
>  	.version = TEMPMON_IMX6SX,
> +
> +	.sensor_ctrl = IMX6_TEMPSENSE0,
> +	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
> +	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
> +
> +	.measure_freq_ctrl = IMX6_TEMPSENSE1,
> +	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
> +	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
> +
> +	.temp_data = IMX6_TEMPSENSE0,
> +	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
> +	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
> +	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
> +
> +	.high_alarm_ctrl = IMX6_TEMPSENSE0,
> +	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
> +	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
> +
> +	.panic_alarm_ctrl = IMX6_TEMPSENSE2,
> +	.panic_alarm_mask = IMX6_TEMPSENSE2_PANIC_VALUE_MASK,
> +	.panic_alarm_shift = IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT,
> +
> +	.low_alarm_ctrl = IMX6_TEMPSENSE2,
> +	.low_alarm_mask = IMX6_TEMPSENSE2_LOW_VALUE_MASK,
> +	.low_alarm_shift = IMX6_TEMPSENSE2_LOW_VALUE_SHIFT, };
> +
> +static struct thermal_soc_data thermal_imx7d_data = {
> +	.version = TEMPMON_IMX7D,
> +
> +	.sensor_ctrl = IMX7_TEMPSENSE1,
> +	.power_down_mask = IMX7_TEMPSENSE1_POWER_DOWN,
> +	.measure_temp_mask = IMX7_TEMPSENSE1_MEASURE_TEMP,
> +
> +	.measure_freq_ctrl = IMX7_TEMPSENSE1,
> +	.measure_freq_shift = IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT,
> +	.measure_freq_mask = IMX7_TEMPSENSE1_MEASURE_FREQ_MASK,
> +
> +	.temp_data = IMX7_TEMPSENSE1,
> +	.temp_value_mask = IMX7_TEMPSENSE1_TEMP_VALUE_MASK,
> +	.temp_value_shift = IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT,
> +	.temp_valid_mask = IMX7_TEMPSENSE1_FINISHED,
> +
> +	.panic_alarm_ctrl = IMX7_TEMPSENSE1,
> +	.panic_alarm_mask = IMX7_TEMPSENSE0_PANIC_ALARM_MASK,
> +	.panic_alarm_shift = IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT,
> +
> +	.high_alarm_ctrl = IMX7_TEMPSENSE0,
> +	.high_alarm_mask = IMX7_TEMPSENSE0_HIGH_ALARM_MASK,
> +	.high_alarm_shift = IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT,
> +
> +	.low_alarm_ctrl = IMX7_TEMPSENSE0,
> +	.low_alarm_mask = IMX7_TEMPSENSE0_LOW_ALARM_MASK,
> +	.low_alarm_shift = IMX7_TEMPSENSE0_LOW_ALARM_SHIFT,
>  };
> 
>  struct imx_thermal_data {
> @@ -107,31 +226,42 @@ struct imx_thermal_data {  static void
> imx_set_panic_temp(struct imx_thermal_data *data,
>  			       int panic_temp)
>  {
> +	const struct thermal_soc_data *soc_data = data->socdata;
>  	struct regmap *map = data->tempmon;
>  	int critical_value;
> 
>  	critical_value = (data->c2 - panic_temp) / data->c1;
> -	regmap_write(map, TEMPSENSE2 + REG_CLR,
> TEMPSENSE2_PANIC_VALUE_MASK);
> -	regmap_write(map, TEMPSENSE2 + REG_SET, critical_value <<
> -			TEMPSENSE2_PANIC_VALUE_SHIFT);
> +
> +	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
> +		     soc_data->panic_alarm_mask);
> +	regmap_write(map, soc_data->panic_alarm_ctrl + REG_SET,
> +		     critical_value << soc_data->panic_alarm_shift);
>  }
> 
>  static void imx_set_alarm_temp(struct imx_thermal_data *data,
>  			       int alarm_temp)
>  {
>  	struct regmap *map = data->tempmon;
> +	const struct thermal_soc_data *soc_data = data->socdata;
>  	int alarm_value;
> 
>  	data->alarm_temp = alarm_temp;
> -	alarm_value = (data->c2 - alarm_temp) / data->c1;
> -	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_ALARM_VALUE_MASK);
> -	regmap_write(map, TEMPSENSE0 + REG_SET, alarm_value <<
> -			TEMPSENSE0_ALARM_VALUE_SHIFT);
> +
> +	if (data->socdata->version == TEMPMON_IMX7D)
> +		alarm_value = alarm_temp / 1000 + data->c1 - 25;
> +	else
> +		alarm_value = (data->c2 - alarm_temp) / data->c1;
> +
> +	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
> +		     soc_data->high_alarm_mask);
> +	regmap_write(map, soc_data->high_alarm_ctrl + REG_SET,
> +		     alarm_value << soc_data->high_alarm_shift);
>  }
> 
>  static int imx_get_temp(struct thermal_zone_device *tz, int *temp)  {
>  	struct imx_thermal_data *data = tz->devdata;
> +	const struct thermal_soc_data *soc_data = data->socdata;
>  	struct regmap *map = data->tempmon;
>  	unsigned int n_meas;
>  	bool wait;
> @@ -139,16 +269,18 @@ static int imx_get_temp(struct thermal_zone_device
> *tz, int *temp)
> 
>  	if (data->mode == THERMAL_DEVICE_ENABLED) {
>  		/* Check if a measurement is currently in progress */
> -		regmap_read(map, TEMPSENSE0, &val);
> -		wait = !(val & TEMPSENSE0_FINISHED);
> +		regmap_read(map, soc_data->temp_data, &val);
> +		wait = !(val & soc_data->temp_valid_mask);
>  	} else {
>  		/*
>  		 * Every time we measure the temperature, we will power on the
>  		 * temperature sensor, enable measurements, take a reading,
>  		 * disable measurements, power off the temperature sensor.
>  		 */
> -		regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
> -		regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_MEASURE_TEMP);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> +			    soc_data->power_down_mask);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> +			    soc_data->measure_temp_mask);
> 
>  		wait = true;
>  	}
> @@ -160,22 +292,28 @@ static int imx_get_temp(struct thermal_zone_device
> *tz, int *temp)
>  	if (wait)
>  		usleep_range(20, 50);
> 
> -	regmap_read(map, TEMPSENSE0, &val);
> +	regmap_read(map, soc_data->temp_data, &val);
> 
>  	if (data->mode != THERMAL_DEVICE_ENABLED) {
> -		regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_MEASURE_TEMP);
> -		regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_POWER_DOWN);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> +			     soc_data->measure_temp_mask);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> +			     soc_data->power_down_mask);
>  	}
> 
> -	if ((val & TEMPSENSE0_FINISHED) == 0) {
> +	if ((val & soc_data->temp_valid_mask) == 0) {
>  		dev_dbg(&tz->device, "temp measurement never finished\n");
>  		return -EAGAIN;
>  	}
> 
> -	n_meas = (val & TEMPSENSE0_TEMP_CNT_MASK) >>
> TEMPSENSE0_TEMP_CNT_SHIFT;
> +	n_meas = (val & soc_data->temp_value_mask)
> +		>> soc_data->temp_value_shift;
> 
>  	/* See imx_init_calib() for formula derivation */
> -	*temp = data->c2 - n_meas * data->c1;
> +	if (data->socdata->version == TEMPMON_IMX7D)
> +		*temp = (n_meas - data->c1 + 25) * 1000;
> +	else
> +		*temp = data->c2 - n_meas * data->c1;
> 
>  	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>  	if (data->socdata->version == TEMPMON_IMX6Q) { @@ -219,21 +357,26
> @@ static int imx_set_mode(struct thermal_zone_device *tz,  {
>  	struct imx_thermal_data *data = tz->devdata;
>  	struct regmap *map = data->tempmon;
> +	const struct thermal_soc_data *soc_data = data->socdata;
> 
>  	if (mode == THERMAL_DEVICE_ENABLED) {
>  		tz->polling_delay = IMX_POLLING_DELAY;
>  		tz->passive_delay = IMX_PASSIVE_DELAY;
> 
> -		regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
> -		regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_MEASURE_TEMP);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> +			     soc_data->power_down_mask);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> +			     soc_data->measure_temp_mask);
> 
>  		if (!data->irq_enabled) {
>  			data->irq_enabled = true;
>  			enable_irq(data->irq);
>  		}
>  	} else {
> -		regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_MEASURE_TEMP);
> -		regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_POWER_DOWN);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
> +			     soc_data->measure_temp_mask);
> +		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
> +			     soc_data->power_down_mask);
> 
>  		tz->polling_delay = 0;
>  		tz->passive_delay = 0;
> @@ -355,6 +498,15 @@ static int imx_init_calib(struct platform_device *pdev,
> u32 ocotp_ana1)
>  	}
> 
>  	/*
> +	 * On i.MX7D, we only use the calibration data at 25C to get the temp,
> +	 * Tmeas = ( Nmeas - n1) + 25; n1 is the fuse value for 25C.
> +	 */
> +	if (data->socdata->version == TEMPMON_IMX7D) {
> +		data->c1 = (ocotp_ana1 >> 9) & 0x1ff;
> +		return 0;
> +	}
> +
> +	/*
>  	 * The sensor is calibrated at 25 °C (aka T1) and the value measured
>  	 * (aka N1) at this temperature is provided in bits [31:20] in the
>  	 * i.MX's OCOTP value ANA1.
> @@ -492,6 +644,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int
> irq, void *dev)  static const struct of_device_id of_imx_thermal_match[] = {
>  	{ .compatible = "fsl,imx6q-tempmon", .data = &thermal_imx6q_data, },
>  	{ .compatible = "fsl,imx6sx-tempmon", .data = &thermal_imx6sx_data, },
> +	{ .compatible = "fsl,imx7d-tempmon", .data = &thermal_imx7d_data, },
>  	{ /* end */ }
>  };
>  MODULE_DEVICE_TABLE(of, of_imx_thermal_match); @@ -523,14 +676,15
> @@ static int imx_thermal_probe(struct platform_device *pdev)
> 
>  	/* make sure the IRQ flag is clear before enabling irq on i.MX6SX */
>  	if (data->socdata->version == TEMPMON_IMX6SX) {
> -		regmap_write(map, MISC1 + REG_CLR, MISC1_IRQ_TEMPHIGH |
> -			MISC1_IRQ_TEMPLOW | MISC1_IRQ_TEMPPANIC);
> +		regmap_write(map, IMX6_MISC1 + REG_CLR,
> +			IMX6_MISC1_IRQ_TEMPHIGH | IMX6_MISC1_IRQ_TEMPLOW
> +			| IMX6_MISC1_IRQ_TEMPPANIC);
>  		/*
>  		 * reset value of LOW ALARM is incorrect, set it to lowest
>  		 * value to avoid false trigger of low alarm.
>  		 */
> -		regmap_write(map, TEMPSENSE2 + REG_SET,
> -			TEMPSENSE2_LOW_VALUE_MASK);
> +		regmap_write(map, data->socdata->low_alarm_ctrl + REG_SET,
> +			     data->socdata->low_alarm_mask);
>  	}
> 
>  	data->irq = platform_get_irq(pdev, 0); @@ -557,11 +711,17 @@ static int
> imx_thermal_probe(struct platform_device *pdev)
>  	}
> 
>  	/* Make sure sensor is in known good state for measurements */
> -	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
> -	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_MEASURE_TEMP);
> -	regmap_write(map, TEMPSENSE1 + REG_CLR,
> TEMPSENSE1_MEASURE_FREQ);
> -	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
> -	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_POWER_DOWN);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
> +		     data->socdata->power_down_mask);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
> +		     data->socdata->measure_temp_mask);
> +	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
> +		     data->socdata->measure_freq_mask);
> +	if (data->socdata->version != TEMPMON_IMX7D)
> +		regmap_write(map, IMX6_MISC0 + REG_SET,
> +			IMX6_MISC0_REFTOP_SELBIASOFF);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> +		     data->socdata->power_down_mask);
> 
>  	data->policy = cpufreq_cpu_get(0);
>  	if (!data->policy) {
> @@ -626,16 +786,20 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
>  		 data->temp_passive / 1000);
> 
>  	/* Enable measurements at ~ 10 Hz */
> -	regmap_write(map, TEMPSENSE1 + REG_CLR,
> TEMPSENSE1_MEASURE_FREQ);
> +	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
> +		     data->socdata->measure_freq_mask);
>  	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
> -	regmap_write(map, TEMPSENSE1 + REG_SET, measure_freq);
> +	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
> +		     measure_freq << data->socdata->measure_freq_shift);
>  	imx_set_alarm_temp(data, data->temp_passive);
> 
>  	if (data->socdata->version == TEMPMON_IMX6SX)
>  		imx_set_panic_temp(data, data->temp_critical);
> 
> -	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
> -	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_MEASURE_TEMP);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
> +		     data->socdata->power_down_mask);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> +		     data->socdata->measure_temp_mask);
> 
>  	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
>  			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread, @@
> -661,7 +825,8 @@ static int imx_thermal_remove(struct platform_device
> *pdev)
>  	struct regmap *map = data->tempmon;
> 
>  	/* Disable measurements */
> -	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_POWER_DOWN);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> +		     data->socdata->power_down_mask);
>  	if (!IS_ERR(data->thermal_clk))
>  		clk_disable_unprepare(data->thermal_clk);
> 
> @@ -684,8 +849,10 @@ static int imx_thermal_suspend(struct device *dev)
>  	 * temperature will be read as the thermal sensor is powered
>  	 * down.
>  	 */
> -	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_MEASURE_TEMP);
> -	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_POWER_DOWN);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
> +		     data->socdata->measure_temp_mask);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> +		     data->socdata->power_down_mask);
>  	data->mode = THERMAL_DEVICE_DISABLED;
>  	clk_disable_unprepare(data->thermal_clk);
> 
> @@ -702,8 +869,10 @@ static int imx_thermal_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  	/* Enabled thermal sensor after resume */
> -	regmap_write(map, TEMPSENSE0 + REG_CLR,
> TEMPSENSE0_POWER_DOWN);
> -	regmap_write(map, TEMPSENSE0 + REG_SET,
> TEMPSENSE0_MEASURE_TEMP);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
> +		     data->socdata->power_down_mask);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> +		     data->socdata->measure_temp_mask);
>  	data->mode = THERMAL_DEVICE_ENABLED;
> 
>  	return 0;
> --
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=02%7C01%7Cans
> on.huang%40nxp.com%7C06aac542a9cb445ee0f308d57fe1cbba%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636555530125162768&sdata=GP4
> UyKpDXyRkmwSIZY9Sb%2BDxO9sPAWCk0O%2FZPYRA0P4%3D&reserved=0
