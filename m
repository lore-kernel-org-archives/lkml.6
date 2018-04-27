Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757311AbeD0CM5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:12:57 -0400
Received: from mail-he1eur01on0078.outbound.protection.outlook.com ([104.47.0.78]:38912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932128AbeD0CMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:12:55 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Topic: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Index: AQHT2vNvaoueJMByHUOpWSeGxuLWrqQPLInggACrfgCAAPxtMIAAHqHggACOugCAAOhKwIAA6AKAgACHWyCAAAm78A==
Date: Fri, 27 Apr 2018 02:12:49 +0000
Message-ID: <AM3PR04MB131578877377FCEB44B685E2F58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com>
 <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
 <CAOMZO5Df__UpcLXVUrW0sT24g=Kmu2132QeQSBE9aZrjcyqsCw@mail.gmail.com>
 <AM3PR04MB1315F80C9B5190F4E26DC723F58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
In-Reply-To: <AM3PR04MB1315F80C9B5190F4E26DC723F58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0791;7:jhXJ0KG684efjAlbeK+03MYvG6Ewb+3k6JfUEQAhoIGtPSMelNt/vId+pKE7Xvk2od3taAw9E92cUMcJMKXoJ6kLfnundO4oE9Hfdl/kzpwBX88islNRVKeMGSHSlNKWl7AEkwAJ5H1sk0mHaXIfUJOzdq5vuvcXyJKDfRURsdyVra30hmJSLSDXAoO2meusTtgDE5h/wNAm1TL0J8blOoUxfTPb8AZGvdrkmvTn4bmiQqada0yZtzxE4r6hlTux
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0791;
x-ms-traffictypediagnostic: AM3PR04MB0791:
x-microsoft-antispam-prvs: <AM3PR04MB0791AD3E298BB514BC1AEF04F58D0@AM3PR04MB0791.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB0791;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0791;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(39380400002)(376002)(396003)(13464003)(189003)(199004)(51914003)(3280700002)(7696005)(6916009)(229853002)(53936002)(106356001)(68736007)(6246003)(76176011)(53546011)(2906002)(55016002)(59450400001)(39060400002)(93886005)(44832011)(99286004)(3660700001)(26005)(97736004)(102836004)(9686003)(316002)(6436002)(446003)(476003)(4326008)(105586002)(74316002)(478600001)(81156014)(66066001)(6116002)(25786009)(86362001)(2940100002)(54906003)(11346002)(1411001)(33656002)(186003)(81166006)(6506007)(486006)(305945005)(3846002)(8676002)(2900100001)(5250100002)(7736002)(5660300001)(8936002)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0791;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lmVCZE3Xy9kpIQuuVse7PkB6KIZVHKx6wXc2OkiM8NpXXw79W/RUUsktsAMX+yXSwV/flSGcuMCEJ0qE4+unXbvc/3JsDdjvwLOpoUneW9z/5ibpHEUxsNRh0yIUL/cB38CA/t+mi8O8mZJzvp0e/I/hTlJGsTuAj3nWNOAJplztKD0izSnHREWZ88OTjr/7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5bfdc24c-2e1f-474d-dfe6-08d5abe46013
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfdc24c-2e1f-474d-dfe6-08d5abe46013
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 02:12:49.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0791
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3R2D0xa021782



Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Friday, April 27, 2018 9:37 AM
> To: 'Fabio Estevam' <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>;
> Andy Duan <fugang.duan@nxp.com>
> Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> 
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam@gmail.com]
> > Sent: Friday, April 27, 2018 1:29 AM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX /
> > MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open
> > list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>; Andy Duan <fugang.duan@nxp.com>
> > Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> >
> > On Thu, Apr 26, 2018 at 3:57 AM, Anson Huang <anson.huang@nxp.com>
> > wrote:
> >
> > > The 'phy-supply' is for enabling/disabling phy regulator, but here
> > > the
> > > MAX7322 IO0 is NOT for enabling/disabling PHY regulator, it is for
> > > IO voltage switch between 1.5V and 1.8V, our ENET IO can work with
> > > both 1.5V
> > and 1.8V, so any config is OK for ENET function.
> >
> > Thanks for the clarification.
> >
> > > The 1.5V/1.8V selection is a one time setting thing, that means we
> > > only need to config it once during boot up, most of i.MX platforms
> > > does NOT provide such voltage switch function for ENET IO, on this
> > > 6SX sabre auto board, it is more like a backup or validation
> > > purpose. With default
> > settings, ENET's function is NOT impacted at all.
> > >
> > > I think we can add a gpio regulator for it and let the regulator
> > > initialization set the GPIO Level for fec, such below, with "
> > > enable-active-high " present, GPIO will be at LOW and voltage is
> > > 1.5V, without
> > this property, GPIO will be HIGH and voltage will be 1.8V.
> > > +               reg_fec: fec_io_supply {
> > > +                       compatible = "regulator-gpio";
> > > +                       regulator-name = "1.8V_1.5V_FEC";
> > > +                       regulator-min-microvolt = <1500000>;
> > > +                       regulator-max-microvolt = <1800000>;
> > > +                       states = <1500000 0x0 1800000 0x1>;
> > > +                       enable-gpio = <&max7322 0
> > GPIO_ACTIVE_HIGH>;
> > > +                       vin-supply = <&sw2_reg>;
> > > +                       enable-active-high;
> >
> > If there is no consumer for this regulator, the regulator API will disable it.
> >
> > It seems you need a 'regulator-always-on;'.
> 
> GPIO regulator is slight different when regulator framework try to disable those
> unused regulator in late phase, in _regulator_do_disable, the GPIO regulator
> only got disabled when it is explicitly enabled before (ena_gpio_state is set when
> regulator is enabled), but this reg_fec is NOT getting enabled, since it only has
> voltage switch function. But I agree that we can anyway add
> 'regulator-always-on'
> to avoid any confusion, will send out new patch, thanks!
> 
>          if (rdev->ena_pin) {
>                  if (rdev->ena_gpio_state) {
>                          ret = regulator_ena_gpio_ctrl(rdev, false);
> 
> 
> Anson.

I found if I add ' regulator-always-on ', the regulator core will explicitly enable this GPIO
regulator and cause MAX7322 IO0 to be HIGH and the FEC IO will be 1.8V, since the GPIO regulator
state 1 means 1.8V, but what we want for now is 1.5V, so I think we should NOT add ' regulator-always-on ',
if anyone wants to use 1.8V IO voltage, they can enable this GPIO regulator to get 1.8V. So I think V5 patch set
is just what we want, we want to use the OFF state's voltage (1.5V) of this MAX7322 IO0 GPIO regulator. Thanks.

Anson.


> 
> >
> >
> > > +               };
> > > +
> > >
> > > Anson.
> > >
