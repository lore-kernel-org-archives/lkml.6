Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeBXBsF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:48:05 -0500
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:55507
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752095AbeBXBsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:48:03 -0500
From: Anson Huang <anson.huang@nxp.com>
To: Anson Huang <anson.huang@nxp.com>,
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
Subject: RE: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Topic: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Index: AQHTnlmbaqk54iO0oU6gCFO0NY5C6KOy5iBg
Date: Sat, 24 Feb 2018 01:47:55 +0000
Message-ID: <AM3PR04MB13157BFB099476F807FEB346F5C30@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
 <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB449;7:S8+urBQIXloctTew1Lns4dEHmhMqYn3FyCcxcikRHa1qxjgtiDST8y3riTj9DSZKpYlMA0ss1iCKwOHK41NdOLts5e6h2QAtZMrypzhDE4NyiOvF3wQjloDVX38cTXvSiilzgiaj36jZbQAb4oBjMGWL1vRNAPV7Y6dfJfwpyNLKDtQbTu3B8gWrcGUEW61M5MfFuvVtK5OCTzq6w9w++BL9RHcPwzinpl6Pj2yDSpIiWet+yqOibytbIXndrEAW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8ebd3b3-1364-432f-5ce8-08d57b28a044
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB449;
x-ms-traffictypediagnostic: AM3PR04MB449:
x-microsoft-antispam-prvs: <AM3PR04MB449C51125F9C1F7AF6C1313F5C30@AM3PR04MB449.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231206)(944501161)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB449;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB449;
x-forefront-prvs: 0593E261C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(396003)(39860400002)(346002)(13464003)(189003)(199004)(4326008)(2906002)(39060400002)(110136005)(6436002)(7416002)(105586002)(76176011)(478600001)(59450400001)(86362001)(106356001)(81156014)(6506007)(97736004)(575784001)(6246003)(26005)(9686003)(2201001)(81166006)(6306002)(53936002)(102836004)(53546011)(2900100001)(55016002)(33656002)(8676002)(6116002)(53946003)(3660700001)(3846002)(3280700002)(2501003)(66066001)(45080400002)(8936002)(966005)(54906003)(5660300001)(2950100002)(99286004)(14454004)(5250100002)(25786009)(305945005)(7696005)(229853002)(316002)(7736002)(74316002)(68736007)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB449;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZbrEOZzoW/TMFuDUpsU0waBF2OEyJEDwrapATJhp/wb6m+1ruKhLd5a25k4Pruoxr/MdPwW5pURXIsBAaEEqPiACbdO1pGN8rAtTR4on9IXzOiK6ylrEgPg1zh7mSZ962826HN3ZLUa6U4iDQ1GyqAl1skDTADsPTRjMIxHxUs8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ebd3b3-1364-432f-5ce8-08d57b28a044
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2018 01:47:55.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1O1mBEO006006

Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Anson Huang
> Sent: Monday, February 5, 2018 4:12 PM
> To: rui.zhang@intel.com; edubezval@gmail.com; robh+dt@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; kernel@pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; linux@armlinux.org.uk
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org
> Subject: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
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
> ---
> changes since V2:
> 	Add bindind doc changes in this patch according to review comments.
>  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
>  drivers/thermal/imx_thermal.c                      | 314
> ++++++++++++++++-----
>  2 files changed, 254 insertions(+), 69 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 28be51a..79f97bc 100644
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
> +  - "fsl,imx7-tempmon" for i.MX7S/D.
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
> index e7d4ffc..c95fa82 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -31,34 +31,58 @@
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
> -#define OCOTP_MEM0			0x0480
> -#define OCOTP_ANA1			0x04e0
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
> +#define IMX6_OCOTP_MEM0				0x0480
> +#define IMX6_OCOTP_ANA1				0x04e0
> +#define IMX7_OCOTP_TESTER3			0x0440
> +#define IMX7_OCOTP_ANA1				0x04f0
> 
>  /* The driver supports 1 passive trip point and 1 critical trip point */  enum
> imx_thermal_trip { @@ -76,17 +100,114 @@ enum imx_thermal_trip {
> 
>  #define TEMPMON_IMX6Q			1
>  #define TEMPMON_IMX6SX			2
> +#define TEMPMON_IMX7			3
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
> +static struct thermal_soc_data thermal_imx7_data = {
> +	.version = TEMPMON_IMX7,
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
> @@ -112,30 +233,41 @@ static void imx_set_panic_temp(struct
> imx_thermal_data *data,
>  			       int panic_temp)
>  {
>  	struct regmap *map = data->tempmon;
> +	const struct thermal_soc_data *soc_data = data->socdata;
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
> +	if (data->socdata->version == TEMPMON_IMX7)
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
> @@ -143,16 +275,18 @@ static int imx_get_temp(struct thermal_zone_device
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
> @@ -164,22 +298,28 @@ static int imx_get_temp(struct thermal_zone_device
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
> +	if (data->socdata->version == TEMPMON_IMX7)
> +		*temp = (n_meas - data->c1 + 25) * 1000;
> +	else
> +		*temp = data->c2 - n_meas * data->c1;
> 
>  	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
>  	if (data->socdata->version == TEMPMON_IMX6Q) { @@ -223,21 +363,26
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
> @@ -359,6 +504,15 @@ static int imx_init_calib(struct platform_device *pdev,
> u32 val)
>  	}
> 
>  	/*
> +	 * On i.MX7, we only use the calibration data at 25C to get the temp,
> +	 * Tmeas = ( Nmeas - n1) + 25; n1 is the fuse value for 25C.
> +	 */
> +	if (data->socdata->version == TEMPMON_IMX7) {
> +		data->c1 = (val >> 9) & 0x1ff;
> +		return 0;
> +	}
> +
> +	/*
>  	 * Sensor data layout:
>  	 *   [31:20] - sensor value @ 25C
>  	 * Use universal formula now and only need sensor value @ 25C @@
> -426,6 +580,7 @@ static void imx_init_temp_grade(struct platform_device
> *pdev, u32 val)
> 
>  static int imx_init_from_tempmon_data(struct platform_device *pdev)  {
> +	const struct imx_thermal_data *data = platform_get_drvdata(pdev);
>  	struct regmap *map;
>  	int ret;
>  	u32 val;
> @@ -438,7 +593,11 @@ static int imx_init_from_tempmon_data(struct
> platform_device *pdev)
>  		return ret;
>  	}
> 
> -	ret = regmap_read(map, OCOTP_ANA1, &val);
> +	if (data->socdata->version == TEMPMON_IMX7)
> +		ret = regmap_read(map, IMX7_OCOTP_ANA1, &val);
> +	else
> +		ret = regmap_read(map, IMX6_OCOTP_ANA1, &val);
> +
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
>  		return ret;
> @@ -447,7 +606,11 @@ static int imx_init_from_tempmon_data(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
> 
> -	ret = regmap_read(map, OCOTP_MEM0, &val);
> +	/* use OTP for thermal grade */
> +	if (data->socdata->version == TEMPMON_IMX7)
> +		ret = regmap_read(map, IMX7_OCOTP_TESTER3, &val);
> +	else
> +		ret = regmap_read(map, IMX6_OCOTP_MEM0, &val);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
>  		return ret;
> @@ -500,6 +663,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int
> irq, void *dev)  static const struct of_device_id of_imx_thermal_match[] = {
>  	{ .compatible = "fsl,imx6q-tempmon", .data = &thermal_imx6q_data, },
>  	{ .compatible = "fsl,imx6sx-tempmon", .data = &thermal_imx6sx_data, },
> +	{ .compatible = "fsl,imx7-tempmon", .data = &thermal_imx7_data, },
>  	{ /* end */ }
>  };
>  MODULE_DEVICE_TABLE(of, of_imx_thermal_match); @@ -531,14 +695,15
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
>  	data->irq = platform_get_irq(pdev, 0); @@ -565,11 +730,17 @@ static int
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
> +	if (data->socdata->version != TEMPMON_IMX7)
> +		regmap_write(map, IMX6_MISC0 + REG_SET,
> +			IMX6_MISC0_REFTOP_SELBIASOFF);
> +	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
> +		     data->socdata->power_down_mask);
> 
>  	data->policy = cpufreq_cpu_get(0);
>  	if (!data->policy) {
> @@ -634,16 +805,20 @@ static int imx_thermal_probe(struct platform_device
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
> -669,7 +844,8 @@ static int imx_thermal_remove(struct platform_device
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
> @@ -692,8 +868,10 @@ static int imx_thermal_suspend(struct device *dev)
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
> @@ -710,8 +888,10 @@ static int imx_thermal_resume(struct device *dev)
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
> on.huang%40nxp.com%7C63511e21169d4a93a04308d56c70bc39%7Cbd8a2a2
> 207224ec7b35f1c4f0497e341%7C0%7C0%7C636534153816691645&sdata=jcU
> MYTFJkmxKUkHcfY2fu%2B%2FyFptZK51api%2Bt9vx7WSU%3D&reserved=0
