Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163712AbeCBCDS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:03:18 -0500
Received: from mail-ve1eur01on0058.outbound.protection.outlook.com ([104.47.1.58]:16614
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163935AbeCBCDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:03:12 -0500
From: Anson Huang <anson.huang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Leonard Crestez <leonard.crestez@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Topic: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
Thread-Index: AQHTsOnNQUj59u4mZ06tF0GRqe2L7aO75ReAgABODtA=
Date: Fri, 2 Mar 2018 02:03:05 +0000
Message-ID: <AM3PR04MB1315478E79B0BFEF5A22DE80F5C50@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1519859380-15878-1-git-send-email-Anson.Huang@nxp.com>
 <1519859380-15878-2-git-send-email-Anson.Huang@nxp.com>
 <20180301212253.fp4gxes57t2m2tg2@rob-hp-laptop>
In-Reply-To: <20180301212253.fp4gxes57t2m2tg2@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [192.158.241.86]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB403;7:iqZ36ly5eXDTatjOOGsXCDGhzJW+vvwoWT+sZpUUSZho/isilnAEV7gqB/fiXJMMhseUupCYSDUxMuaqEH8hvTfYyMSXBlnJjGAOgBlGRRPGM1KA/0SPSa379dQ98zDNlfZ4RNZNzwoRZ30QsLfHzlUwNJeT90grIw3Hd5TYVFX9QQxNYhLonSBvWGHuw4TVG0dKL7NmtMuxzQOKjHuKv8fddJIVqXVuuILUNJhYhH9817ma1b2JV/vN0N97+Mk4
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98b0faec-8c1b-4f11-7a03-08d57fe1bced
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB403;
x-ms-traffictypediagnostic: AM3PR04MB403:
x-microsoft-antispam-prvs: <AM3PR04MB4033B59AEC45A0CA120FFCBF5C50@AM3PR04MB403.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB403;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB403;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(189003)(13464003)(199004)(5660300001)(9686003)(2950100002)(74316002)(5250100002)(54906003)(99286004)(2900100001)(8676002)(305945005)(81166006)(106356001)(229853002)(4326008)(25786009)(68736007)(66066001)(55016002)(7696005)(81156014)(316002)(6246003)(3660700001)(8936002)(6436002)(7416002)(6916009)(7736002)(478600001)(2906002)(53546011)(6506007)(3280700002)(59450400001)(76176011)(102836004)(186003)(26005)(97736004)(14454004)(6116002)(53936002)(86362001)(105586002)(39060400002)(3846002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB403;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +eEdp9cAchW2igvipmk/qcHwgiUVTy/iXC2Hi//pH+TVuS5AdulHXna2Q2D7/S49HaN2XiF6jKnVFAwSuZ9gU2j+RVqbAHlyU5g3oXvlW64Yp+dbArkXIZNp5056NGGR2G5QoHG43rP+JgWjuKHKpNlB9cmdE1P24H2Lod54H0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0faec-8c1b-4f11-7a03-08d57fe1bced
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 02:03:05.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB403
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2224jXH012924



Anson Huang
Best Regards!


> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, March 2, 2018 5:23 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>; rui.zhang@intel.com;
> edubezval@gmail.com; mark.rutland@arm.com; shawnguo@kernel.org;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: Re: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
> 
> On Thu, Mar 01, 2018 at 07:09:40AM +0800, Anson Huang wrote:
> > This patch adds i.MX7 thermal sensor support, most of the i.MX7
> > thermal sensor functions are same with
> > i.MX6 except the registers offset/layout, so we move those registers
> > offset/layout definitions to soc data structure.
> >
> > i.MX7 uses single calibration data @25C, the calibration data is
> > located at OCOTP offset 0x4F0, bit[17:9], the formula is as below:
> >
> > Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > ---
> > changes since V4:
> > 	drop direct OCOTP register access for i.mx7d since it is a new added
> platform,
> > 	only support reading ocotp values through the ocotp nvmem driver which
> handles clock.
> >  .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
> >  drivers/thermal/imx_thermal.c                      | 295
> ++++++++++++++++-----
> >  2 files changed, 239 insertions(+), 65 deletions(-)
> 
> Please add ack/reviewed-by's when posting new versions.
> 
> Rob
Sorry for missing it, I just sent out a V6 adding Reviewed-by, thanks.

Anson. 
