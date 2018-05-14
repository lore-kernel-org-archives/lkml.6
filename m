Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeENJLC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:11:02 -0400
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:15072
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751626AbeENJLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:11:00 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Bastian Stender <bst@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
Thread-Topic: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
Thread-Index: AQHT61tk/+/0R46BAU6q1UOin0CPU6Qu5tWAgAAIeeA=
Date: Mon, 14 May 2018 09:10:56 +0000
Message-ID: <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
 <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
In-Reply-To: <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1297;7:ZjGu7B/n3Mz23ZNftMln8q5+bPU75sS4KhoGnpbfYRonsOJ2CoOHXWLd3sVWq+XNz0vw29dRS4QPaGFZ85tJYUigbNS9hAMGqE2TC3lhvPG4VKW5U0rtpRy3iQtGzx+xbRY+LMxUj9QShOVEeCIiO4f6Po+XSZ2kOkw4z3g0g0v8C+9FT06GAY8cyU8wxJnKVG2+YvZbrCCwmapB2qHiVqoQIdMmcg1o0tDH0l+/y1mEkuKU7UxHURLzqszUBZHQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1297;
x-ms-traffictypediagnostic: AM3PR04MB1297:
x-microsoft-antispam-prvs: <AM3PR04MB1297C1CCBF611E1EF84950D6F59C0@AM3PR04MB1297.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(189930954265078)(185117386973197)(85827821059158)(258649278758335)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1297;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1297;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(13464003)(199004)(189003)(9686003)(3846002)(446003)(305945005)(6116002)(966005)(2900100001)(105586002)(11346002)(110136005)(102836004)(478600001)(2501003)(316002)(5250100002)(6306002)(33656002)(14454004)(45080400002)(54906003)(5660300001)(7736002)(97736004)(8936002)(66066001)(68736007)(55016002)(74316002)(7416002)(106356001)(81166006)(81156014)(8676002)(26005)(186003)(39060400002)(2906002)(59450400001)(486006)(4326008)(53936002)(3660700001)(6246003)(99286004)(44832011)(2201001)(229853002)(76176011)(86362001)(7696005)(575784001)(53546011)(3280700002)(476003)(25786009)(6436002)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1297;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mrid7Sv9XS/7M0HfanM8HwMsbsyWjDyxXlLAUY6WKulfrcvzmmJLZtdZPgwtqu+Szlcpppbfx5ScRsLrO3pFjH0TVXwp7IfsFmbSdNoEVZ0K8187qCi6V5YqFQUXNaGJDDSuMJItcng+PuYA7TJz+NoQ6Y8m5TKOAToMRTG4SNwXLJA47JZsWZiF30EMWUvn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b5ec6129-271e-41bd-615a-08d5b97a9a3f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ec6129-271e-41bd-615a-08d5b97a9a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 09:10:56.6675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1297
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E9B8bt012665



Anson Huang
Best Regards!


> -----Original Message-----
> From: Bastian Stender [mailto:bst@pengutronix.de]
> Sent: Monday, May 14, 2018 4:37 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> rjw@rjwysocki.net; viresh.kumar@linaro.org; rui.zhang@intel.com;
> edubezval@gmail.com
> Cc: devicetree@vger.kernel.org; linux-pm@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
> 
> Hi,
> 
> On 05/14/2018 10:09 AM, Anson Huang wrote:
> > This patch removes cpufreq cooling registration in thermal .probe
> > function, cpufreq cooling should be done in cpufreq driver when it is
> > ready.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> It seems you are trying to achieve something similar to a patch I sent a couple
> of month ago. Unfortunately I did not have the time to rework it yet:
> 
> 
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.kernel.org%2Fpatch%2F10059085%2F&data=02%7C01%7Canson.huang
> %40nxp.com%7C179da3635cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C636618838508978629&sdata=BcQ9tc%2BE
> CZ%2Fk4AsZFxshgmvSsPg7eRN0ASzP8LO8yBI%3D&reserved=0
> 
> Some of the comments might apply here too.
 
Ah, I did NOT notice this thread, so how to proceed, will you continue to finish your patch?
If yes, then you can just ignore/skip my patch, thanks.

Anson.

> 
> Regards,
> Bastian
> 
> > ---
> >   drivers/thermal/imx_thermal.c | 16 ----------------
> >   1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/thermal/imx_thermal.c
> > b/drivers/thermal/imx_thermal.c index c30dc21..8eedb97 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -9,7 +9,6 @@
> >
> >   #include <linux/clk.h>
> >   #include <linux/cpufreq.h>
> > -#include <linux/cpu_cooling.h>
> >   #include <linux/delay.h>
> >   #include <linux/device.h>
> >   #include <linux/init.h>
> > @@ -207,7 +206,6 @@ static struct thermal_soc_data thermal_imx7d_data
> = {
> >   struct imx_thermal_data {
> >   	struct cpufreq_policy *policy;
> >   	struct thermal_zone_device *tz;
> > -	struct thermal_cooling_device *cdev;
> >   	enum thermal_device_mode mode;
> >   	struct regmap *tempmon;
> >   	u32 c1, c2; /* See formula in imx_init_calib() */ @@ -729,22
> > +727,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >   		return -EPROBE_DEFER;
> >   	}
> >
> > -	data->cdev = cpufreq_cooling_register(data->policy);
> > -	if (IS_ERR(data->cdev)) {
> > -		ret = PTR_ERR(data->cdev);
> > -		dev_err(&pdev->dev,
> > -			"failed to register cpufreq cooling device: %d\n", ret);
> > -		cpufreq_cpu_put(data->policy);
> > -		return ret;
> > -	}
> > -
> >   	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
> >   	if (IS_ERR(data->thermal_clk)) {
> >   		ret = PTR_ERR(data->thermal_clk);
> >   		if (ret != -EPROBE_DEFER)
> >   			dev_err(&pdev->dev,
> >   				"failed to get thermal clk: %d\n", ret);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -759,7 +747,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
> >   	ret = clk_prepare_enable(data->thermal_clk);
> >   	if (ret) {
> >   		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -775,7 +762,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
> >   		dev_err(&pdev->dev,
> >   			"failed to register thermal zone device %d\n", ret);
> >   		clk_disable_unprepare(data->thermal_clk);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -811,7 +797,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
> >   		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
> >   		clk_disable_unprepare(data->thermal_clk);
> >   		thermal_zone_device_unregister(data->tz);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -831,7 +816,6 @@ static int imx_thermal_remove(struct
> platform_device *pdev)
> >   		clk_disable_unprepare(data->thermal_clk);
> >
> >   	thermal_zone_device_unregister(data->tz);
> > -	cpufreq_cooling_unregister(data->cdev);
> >   	cpufreq_cpu_put(data->policy);
> >
> >   	return 0;
> >
> 
> --
> Pengutronix e.K.
> Industrial Linux Solutions
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&data=02%7C01%7Canson.huang%40nxp.com%7C179da36
> 35cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C636618838508978629&sdata=kHHjnbmj2kV0aPlAvULXUh%2Fm%2Fp
> gbu21luMQ6jfIUgLo%3D&reserved=0
> Peiner Str. 6-8, 31137 Hildesheim, Germany Amtsgericht Hildesheim, HRA 2686
