Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbeBLHZB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 02:25:01 -0500
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:38171
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932396AbeBLHY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 02:24:57 -0500
From: Anson Huang <anson.huang@nxp.com>
To: Stefan Agner <stefan@agner.ch>
CC: Fabio Estevam <festevam@gmail.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Octavian Purdila <octavian.purdila@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
Thread-Topic: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
 i.MX6UL/ULL
Thread-Index: AQHTkLhX5r54WgvRU02UG2FROePY6aOd9iCAgACa4PCAAPUyAIAA/PEg
Date: Mon, 12 Feb 2018 07:24:52 +0000
Message-ID: <AM3PR04MB1315A06F706CCB9EC0699C71F5F70@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <20180118235836.17393-1-stefan@agner.ch>
 <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
 <AM3PR04MB1315240E4A77431A58AC8501F5F00@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <79baed40abbcc72920fd133bc43e378a@agner.ch>
In-Reply-To: <79baed40abbcc72920fd133bc43e378a@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB513;7:sLkhkyh6L0+VHChAG5vYVm4glESIb2zhP08zDetnWJ5i5poz2jOWe8McQAzbnQMcUHU/uTzf8YgACKkktvwzOWiGUIsah/Bfk/PY0NgWLXdXGCvSO9hfh/CF1BPY29AY58HXsvodk4Jo/Ah9KC3FDypKF0r3XwULqXvzsNj7ntNtzackUgh8xdXxsyddzPldGMqxAbFS7TBELZSjv1cYpGR7NUzQnWIeOlfxx/3Y7ZYyP69kRMGq1VUbMQ9SM5fM
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a9dde6b-7880-4362-6c56-08d571e9b56d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB513;
x-ms-traffictypediagnostic: AM3PR04MB513:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB51327FF5D705CB53CC79A22F5F70@AM3PR04MB513.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB513;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB513;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(13464003)(8676002)(81166006)(106356001)(99286004)(105586002)(81156014)(97736004)(478600001)(66066001)(74316002)(68736007)(316002)(54906003)(14454004)(33656002)(7736002)(305945005)(5250100002)(6116002)(3846002)(4326008)(7416002)(26005)(39060400002)(25786009)(3660700001)(76176011)(6916009)(102836004)(2906002)(53546011)(6506007)(6436002)(5660300001)(7696005)(3280700002)(2950100002)(53936002)(86362001)(55016002)(9686003)(186003)(6246003)(229853002)(8936002)(2900100001)(93886005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB513;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: n7unPP9k7tRTzi5HB0bZARsTZbMrkBFpmTVWY5aK28B2xwwsYZPP0huNN0OlUBDTPl6BZWJgPYhXYqr0/ewbuQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9dde6b-7880-4362-6c56-08d571e9b56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 07:24:52.6865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB513
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1C7P6gH016181



Anson Huang
Best Regards!


> -----Original Message-----
> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Monday, February 12, 2018 12:18 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>; rjw@rjwysocki.net; viresh kumar
> <viresh.kumar@linaro.org>; linux-pm@vger.kernel.org; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; max.oss.09@gmail.com; linux-kernel
> <linux-kernel@vger.kernel.org>; Octavian Purdila <octavian.purdila@nxp.com>;
> Fabio Estevam <fabio.estevam@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
> i.MX6UL/ULL
> 
> On 11.02.2018 02:42, Anson Huang wrote:
> > Anson Huang
> > Best Regards!
> >
> >
> >> -----Original Message-----
> >> From: Fabio Estevam [mailto:festevam@gmail.com]
> >> Sent: Sunday, February 11, 2018 12:26 AM
> >> To: Stefan Agner <stefan@agner.ch>; Anson Huang
> <anson.huang@nxp.com>
> >> Cc: rjw@rjwysocki.net; viresh kumar <viresh.kumar@linaro.org>;
> >> linux-pm@vger.kernel.org; Marcel Ziswiler
> >> <marcel.ziswiler@toradex.com>; max.oss.09@gmail.com; linux-kernel
> >> <linux-kernel@vger.kernel.org>; Octavian Purdila
> >> <octavian.purdila@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> >> Shawn Guo <shawnguo@kernel.org>; moderated list:ARM/FREESCALE IMX /
> >> MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>;
> >> dl-linux-imx <linux-imx@nxp.com>
> >> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
> >> i.MX6UL/ULL
> >>
> >> Hi Anson,
> >>
> >> On Thu, Jan 18, 2018 at 9:58 PM, Stefan Agner <stefan@agner.ch> wrote:
> >> > Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> >> > Use PLL1 sys clock for all operating points higher than 528MHz.
> >> >
> >> > Note: For higher operating points VDD_SOC_IN needs to be 125mV
> >> > higher than the ARM set-point (see datasheet). Specifically, the
> >> > i.MX6UL/ULL EVK boards have an external DC regulator which needs
> >> > adjustment. The regulator adjustment is not covered with this change.
> >> >
> >> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> > ---
> >> >  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
> >> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
> >> > b/drivers/cpufreq/imx6q-cpufreq.c index 628fe899cb48..840f6386c780
> >> > 100644
> >> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> >> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> >> > @@ -114,12 +114,14 @@ static int imx6q_set_target(struct
> >> > cpufreq_policy
> >> *policy, unsigned int index)
> >> >                  */
> >> >                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> >> >                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> >> > -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> >> > -                       clk_set_parent(secondary_sel_clk,
> pll2_bus_clk);
> >> > -               else
> >> > -                       clk_set_parent(secondary_sel_clk,
> >> pll2_pfd2_396m_clk);
> >> > -               clk_set_parent(step_clk, secondary_sel_clk);
> >> > -               clk_set_parent(pll1_sw_clk, step_clk);
> >> > +               if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> >> > +                       if (freq_hz >
> clk_get_rate(pll2_pfd2_396m_clk))
> >> > +                               clk_set_parent(secondary_sel_clk,
> >> pll2_bus_clk);
> >> > +                       else
> >> > +                               clk_set_parent(secondary_sel_clk,
> >> pll2_pfd2_396m_clk);
> >> > +                       clk_set_parent(step_clk, secondary_sel_clk);
> >> > +                       clk_set_parent(pll1_sw_clk, step_clk);
> >> > +               }
> >
> > For cpufreq > 528MHz, ARM PLL needs to be set_rate, I did NOT see
> > where sets ARM PLL rate?
> 
> This is done unconditionally after the if statement:
> 
> 	if (of_machine_is_compatible("fsl,imx6ul") ||
> 	    of_machine_is_compatible("fsl,imx6ull")) {
> 		/*
> 		 * When changing pll1_sw_clk's parent to pll1_sys_clk,
> 		 * CPU may run at higher than 528MHz, this will lead to
> 		 * the system unstable if the voltage is lower than the
> 		 * voltage of 528MHz, so lower the CPU frequency to one
> 		 * half before changing CPU frequency.
> 		 */
> 		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> 		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> 		if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> 			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> 				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> 			else
> 				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
> 			clk_set_parent(step_clk, secondary_sel_clk);
> 			clk_set_parent(pll1_sw_clk, step_clk);
> 		}
> 	} else {
> 		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> 		clk_set_parent(pll1_sw_clk, step_clk);
> 		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> 			clk_set_rate(pll1_sys_clk, new_freq * 1000);
> 			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> 		} else {
> 			/* pll1_sys needs to be enabled for divider rate change to work.
> */
> 			pll1_sys_temp_enabled = true;
> 			clk_prepare_enable(pll1_sys_clk);
> 		}
> 	}
> 
> 	/* Ensure the arm clock divider is what we expect */
> 	ret = clk_set_rate(arm_clk, new_freq * 1000);
> 
> 
> --
> Stefan

Thanks, I see the CLK_SET_RATE_PARENT flag is set for arm clk.

Reviewed-by: Anson Huang <Anson.Huang@nxp.com>
 
Anson.
> 
> 
> 
> >
> > Anson.
> >
> >> >         } else {
> >> >                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> >> >                 clk_set_parent(pll1_sw_clk, step_clk);
> >>
> >> Could you please help reviewing this patch?
> >>
> >> Thanks
