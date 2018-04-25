Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeDYFgG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:36:06 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:1189
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750921AbeDYFgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:36:04 -0400
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
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Topic: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
Thread-Index: AQHT2vNvaoueJMByHUOpWSeGxuLWrqQPLInggACrfgCAAPxtMIAAHqHg
Date: Wed, 25 Apr 2018 05:36:01 +0000
Message-ID: <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
In-Reply-To: <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1459;7:ENlSpLHjd54lHNZvcT/Zz99UmlkdecnWvOClZ6eFYsv4RVt7OeKwsy4ACM56kfiuH8GQh8IV2fPke31uFup2fLkYUVY4euWN1IBH6wS+WGEKwYD/ASZV5F6K4Qc3ffJWbe9dbZVDQ9Amlnslh++yaqY7K5L8npSpsEKtidGAa6ZJQ6mAADaD368xKEed2vXQztYylXmRaKH+oZ0DnC1pfjbuHDlZGkRMBMUzl7JRr7JtWExmdpgFGTS79OQKsNsW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1459;
x-ms-traffictypediagnostic: AM3PR04MB1459:
x-microsoft-antispam-prvs: <AM3PR04MB1459E01710E3B24534B7D228F58F0@AM3PR04MB1459.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1459;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1459;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(13464003)(189003)(199004)(11346002)(106356001)(6436002)(486006)(476003)(1411001)(446003)(3280700002)(2900100001)(6246003)(3660700001)(8676002)(81166006)(81156014)(93886005)(8936002)(97736004)(39060400002)(26005)(6506007)(316002)(102836004)(54906003)(68736007)(53936002)(86362001)(53546011)(59450400001)(44832011)(4326008)(76176011)(2940100002)(9686003)(7696005)(6916009)(25786009)(3846002)(6116002)(229853002)(74316002)(55016002)(478600001)(99286004)(7736002)(305945005)(14454004)(186003)(2906002)(105586002)(33656002)(5250100002)(5660300001)(66066001)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1459;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: H4P1dsRfHOy0oE8KgQ2GQRrsb2JsjmIWq+HQs0yNrokSK0RJlj6ajTFXN8vE0qiwvksH9J2kBRVaMkfuL8aJM9p/OfPWzrjCPq0rMcBP1mQ5zJbt4HLpKNb1a+O0x7RnNpb3dbQGFSQGI9iF6iFIonGq3HrnqJPj5vMCQ+p+r86GKokfuzLn60wYXhuWGc3m
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e4565902-5547-433a-63eb-08d5aa6e6e23
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4565902-5547-433a-63eb-08d5aa6e6e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 05:36:01.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1459
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3P5aBEx031846

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Wednesday, April 25, 2018 11:30 AM
> To: 'Fabio Estevam' <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> Hi, Fabio
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam@gmail.com]
> > Sent: Tuesday, April 24, 2018 8:23 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX /
> > MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open
> > list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> >
> > Hi Anson,
> >
> > On Mon, Apr 23, 2018 at 11:09 PM, Anson Huang <anson.huang@nxp.com>
> > wrote:
> >
> > > Ah, yes, thanks for pointing out this issue, I just removed it and
> > > the function is still working, already sent out V2 patch set, thanks.
> >
> > So now maybe it is working only because the bootloader activated this
> > GPIO, which is not good.
> >
> > I don't have access to the mx6sx sabreauto schematics to verify  where
> > &max7322 0 connects to, but it would be better to make sure that you
> > activate this pin in dts if it is needed for Ethernet, without relying on the
> bootloader.
> 
> It is working by default hardware settings, but I agree we should do it in dts, I
> found it has a lot of dependency if we want to enable the gpio reset for FEC1,
> many gpio reset patch missed in upstream kernel, need patch work for
> MAX7322 first, so I plan to remove FEC support in this patch set, and will
> upstream the MAX7322 reset patch first, then will add FEC support after
> MAX7322 patch done. Will send out V3 patch to drop fec support for now,
> thanks.
> 
> Anson.

Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's voltage,
NOT reset, and when I tested MAX7320 driver, I did NOT notice that the
CONFIG_GPIO_MAX732X is NOT enabled in imx_v6_v7_defconfig, so I thought
it is NOT working, after enabling MAX7320 driver, max7320 is working as expected,
will send out another patch set including fec driver and MAX7320 config, thanks for your patience.

Anson.

> 
> 
> 
> 
