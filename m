Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeDZG5r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:57:47 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:31872
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751508AbeDZG5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:57:44 -0400
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
Thread-Index: AQHT2vNvaoueJMByHUOpWSeGxuLWrqQPLInggACrfgCAAPxtMIAAHqHggACOugCAAOhKwA==
Date: Thu, 26 Apr 2018 06:57:07 +0000
Message-ID: <DB5PR04MB132072FEDCAFEDF6592C6A32F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB1445;7:CXHQpJ4ALoJQkzSsA9GuUl+3PIozGa0w87xWGXwXZKEq0y+J8vthl2qP5AeTNXLOGWOhQZIYJRhrVeFl0ZgU6MBHslIz+zJXWVaTdFTdxH8yQ0ohPIN81t53Jpw30HeJCv0S1gG5khp/nzLtHANWOXeNJ2hoqUdIKpDbm3XhOwprLOFV/lpeNtId/KSGJlMkiIZWhWHesfGIKVSbjv5W7Z1JAsvboJ8CoRyq3FnuK9hCfL9aYRb8lot40cI/V7Je
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1445;
x-ms-traffictypediagnostic: DB5PR04MB1445:
x-microsoft-antispam-prvs: <DB5PR04MB14456EF61AACDF55D0CDC683F58E0@DB5PR04MB1445.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR04MB1445;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1445;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(346002)(396003)(376002)(13464003)(189003)(199004)(6116002)(44832011)(3846002)(25786009)(66066001)(8936002)(478600001)(33656002)(93886005)(99286004)(14454004)(316002)(5250100002)(5660300001)(8676002)(97736004)(86362001)(305945005)(186003)(74316002)(4326008)(81166006)(3660700001)(26005)(7736002)(486006)(106356001)(11346002)(55016002)(1411001)(2906002)(229853002)(3280700002)(105586002)(6506007)(6916009)(53936002)(476003)(6666003)(6436002)(102836004)(446003)(76176011)(68736007)(9686003)(39060400002)(6246003)(7696005)(2900100001)(54906003)(81156014)(53546011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1445;H:DB5PR04MB1320.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: AldLjyZbjdqvDB1Rr+YrZlObr8/3XV2BeH3PBD4iMTC3GB+6cw4V6rxlSikUSnoi6kWH1wRxEZIwwUGYSXLcA3a0m4qedh+rvwIV2xShoKnw3iMLj8XU8PKjgpTy2bJUjGPn24Q6Vi3GtpNLYYn9PA0AZy2mKvMBxdyqglpz74Tzw8T5ZS5jcWwMlcANIsCQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bc774282-1a89-472f-2524-08d5ab43007d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc774282-1a89-472f-2524-08d5ab43007d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 06:57:07.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1445
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3Q6vsfv007439

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Wednesday, April 25, 2018 9:47 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> Hi Anson,
> 
> On Wed, Apr 25, 2018 at 2:36 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's
> > voltage,
> 
> In this case you need to pass the 'phy-supply' property inside the fec node and
> add a regulator that is controlled via MAX7320 IO0 pin.

The 'phy-supply' is for enabling/disabling phy regulator, but here the MAX7322 IO0 is NOT for
enabling/disabling PHY regulator, it is for IO voltage switch between 1.5V and 1.8V, our ENET
IO can work with both 1.5V and 1.8V, so any config is OK for ENET function.

The 1.5V/1.8V selection is a one time setting thing, that means we only need to
config it once during boot up, most of i.MX platforms does NOT provide such voltage
switch function for ENET IO, on this 6SX sabre auto board, it is more like a backup or
validation purpose. With default settings, ENET's function is NOT impacted at all.

I think we can add a gpio regulator for it and let the regulator initialization set the GPIO
Level for fec, such below, with " enable-active-high " present, GPIO will be at LOW and voltage
is 1.5V, without this property, GPIO will be HIGH and voltage will be 1.8V.
+               reg_fec: fec_io_supply {
+                       compatible = "regulator-gpio";
+                       regulator-name = "1.8V_1.5V_FEC";
+                       regulator-min-microvolt = <1500000>;
+                       regulator-max-microvolt = <1800000>;
+                       states = <1500000 0x0 1800000 0x1>;
+                       enable-gpio = <&max7322 0 GPIO_ACTIVE_HIGH>;
+                       vin-supply = <&sw2_reg>;
+                       enable-active-high;
+               };
+

Anson.
