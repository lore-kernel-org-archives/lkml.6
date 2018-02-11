Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBKBmR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 20:42:17 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:27680
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751050AbeBKBmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 20:42:15 -0500
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>
CC: "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
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
Thread-Index: AQHTkLhX5r54WgvRU02UG2FROePY6aOd9iCAgACa4PA=
Date: Sun, 11 Feb 2018 01:42:09 +0000
Message-ID: <AM3PR04MB1315240E4A77431A58AC8501F5F00@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <20180118235836.17393-1-stefan@agner.ch>
 <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
In-Reply-To: <CAOMZO5CBTTi2QMfM0yDVEMTYm06pGyasUcaLWD8wDHiVi9oshg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1153;6:TMqKOWPhLlcJCzS7Mj+A1TXyEVG1ZwPAGXUBDq9BzjRhZ+TW2wvzvZ+ajurPUb5pabbN6TyS6wYYp+yokArbhyTX9df93/wiuoYOXDSo3ntePK8QwWCSHlRJlkOZMcHB5W51btGYB0e0KkaWCRBHuNu7AIvuS2dsrGZRbgMIb98YlQ54Q7V6MuIINCafCvV45mJ5ckg8yn6BpMntgxEHeOM9/sTuQzX5mboO4myXz+9bmbEeAXOIbhkjX1mwawkqq8a4bkYZl+1QoLi1NT1CXWBEPXtrSyRXThEZ7EOwliR2ZcllIzjpgQyoCIVjZ8lH1exvTBR7mJPAwNMYillCTQCzCwK9MG4E+eDF9/iQwc7QoqaPcGVP3c5RWCVxSjQP;5:+N3jRB6HNGPzSjbA+ibI+G2S5zs3i8vTQi8+rwKKx9H+t+uW8gP9Jiqt0SfcYLzPDlGA0GJ91OVaXT8ihNG4XKfSIk2nyDov68nXDP0A2K3sPkK50MAny7cgkPcWlMFBQMCrG02f4Ly4bbTuYWh1rpcHsNbDmVMJasDzcbDvTo8=;24:N1FS2Oq1QOqiYidP8NP99Qy3t9XZYBrcJ1/6qDwuza7qK+JBVzjATv5/4W5Z4+352Y5t8OrGrg0pCiAfbJT8uX/TzFLRJ0m9SrlqPlu6DTM=;7:ot2kiDun9Q6MK+w+c57Yu/fY/MinNC2sjzwS+pZJNExC+1WW9MbD/X6Merc8Qc9NGznuYvmwurIIbu1vCVPPYm7PjNXq6BXPxJZwad2ljN+eZXObKpa93gmKPZ5mjpYhF+YNib4HUhIuPmO+/xhPt8A3zZf9dxAmi5Am/3SYNDR9l9LJzyoMYQpaJCYgdR+WXY183FDi6HxYiJMwXpnjHp1yeuX0/NOnbaIOTir1aMdZ7IZo6G0fnYE1gw483RVi
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec9d1139-a701-4de5-7043-08d570f0aa2a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB1153;
x-ms-traffictypediagnostic: AM3PR04MB1153:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB115359CEA63034CFC35A9287F5F00@AM3PR04MB1153.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1153;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1153;
x-forefront-prvs: 058043A388
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(39380400002)(366004)(199004)(13464003)(189003)(305945005)(7736002)(102836004)(2906002)(105586002)(74316002)(106356001)(5660300001)(7416002)(2900100001)(53546011)(97736004)(6506007)(33656002)(26005)(6246003)(68736007)(66066001)(25786009)(81166006)(81156014)(8676002)(229853002)(8936002)(99286004)(4326008)(5250100002)(6116002)(3846002)(7696005)(39060400002)(55016002)(2950100002)(6436002)(9686003)(186003)(54906003)(86362001)(3280700002)(53936002)(3660700001)(76176011)(478600001)(316002)(110136005)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1153;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: zgGDpvoTkKEobEGRVR5N6KYs+WNbCHLbWYcbdsxaeHL7ffcPQ6BN82wZyG84ZJ9Mux3ElEfC6yoNxR0azE8XzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9d1139-a701-4de5-7043-08d570f0aa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2018 01:42:09.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1B1gL6h027716



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Sunday, February 11, 2018 12:26 AM
> To: Stefan Agner <stefan@agner.ch>; Anson Huang <anson.huang@nxp.com>
> Cc: rjw@rjwysocki.net; viresh kumar <viresh.kumar@linaro.org>;
> linux-pm@vger.kernel.org; Marcel Ziswiler <marcel.ziswiler@toradex.com>;
> max.oss.09@gmail.com; linux-kernel <linux-kernel@vger.kernel.org>; Octavian
> Purdila <octavian.purdila@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Shawn Guo <shawnguo@kernel.org>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] cpufreq: imx6q: support frequencies >528MHz for
> i.MX6UL/ULL
> 
> Hi Anson,
> 
> On Thu, Jan 18, 2018 at 9:58 PM, Stefan Agner <stefan@agner.ch> wrote:
> > Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
> > Use PLL1 sys clock for all operating points higher than 528MHz.
> >
> > Note: For higher operating points VDD_SOC_IN needs to be 125mV higher
> > than the ARM set-point (see datasheet). Specifically, the i.MX6UL/ULL
> > EVK boards have an external DC regulator which needs adjustment. The
> > regulator adjustment is not covered with this change.
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
> > b/drivers/cpufreq/imx6q-cpufreq.c index 628fe899cb48..840f6386c780
> > 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy
> *policy, unsigned int index)
> >                  */
> >                 clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
> >                 clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> > -               if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> > -                       clk_set_parent(secondary_sel_clk, pll2_bus_clk);
> > -               else
> > -                       clk_set_parent(secondary_sel_clk,
> pll2_pfd2_396m_clk);
> > -               clk_set_parent(step_clk, secondary_sel_clk);
> > -               clk_set_parent(pll1_sw_clk, step_clk);
> > +               if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
> > +                       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
> > +                               clk_set_parent(secondary_sel_clk,
> pll2_bus_clk);
> > +                       else
> > +                               clk_set_parent(secondary_sel_clk,
> pll2_pfd2_396m_clk);
> > +                       clk_set_parent(step_clk, secondary_sel_clk);
> > +                       clk_set_parent(pll1_sw_clk, step_clk);
> > +               }

For cpufreq > 528MHz, ARM PLL needs to be set_rate, I did NOT see where sets ARM PLL rate?

Anson.

> >         } else {
> >                 clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> >                 clk_set_parent(pll1_sw_clk, step_clk);
> 
> Could you please help reviewing this patch?
> 
> Thanks
