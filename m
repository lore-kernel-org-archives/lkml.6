Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeDYDac (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:30:32 -0400
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:18796
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeDYDaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:30:19 -0400
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
Thread-Index: AQHT2vNvaoueJMByHUOpWSeGxuLWrqQPLInggACrfgCAAPxtMA==
Date: Wed, 25 Apr 2018 03:30:11 +0000
Message-ID: <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
In-Reply-To: <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0776;7:+1fT+7XiF3L7g5+YeB+qpEHa1+g9eZbh2K6fuxWePOynQA17JzkbsoT16NkalfGYRp2pTdvWsUm52ZQQ1Eb8RlijUYlQCEPe2b/dHA7y/lWMnrU9x0v8sXUcqtVs0K/kZEBjcObHxYsW1/Op7/8Qgo4hFotGIOuxDmSk89TQnvpwuKmhJf6XB3zKvzCt14xfeju1SVEyILrPxwfRbwAMSemtsmemo6S5QjNtBBKveaVJ/XanT+jezO+uyE3mqi3x
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0776;
x-ms-traffictypediagnostic: AM3PR04MB0776:
x-microsoft-antispam-prvs: <AM3PR04MB0776C14156FA6615BAC94688F58F0@AM3PR04MB0776.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB0776;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0776;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(13464003)(189003)(199004)(54906003)(9686003)(3846002)(316002)(5660300001)(6916009)(99286004)(6116002)(26005)(1411001)(7696005)(66066001)(4326008)(59450400001)(55016002)(76176011)(14454004)(53546011)(93886005)(74316002)(106356001)(3280700002)(81166006)(33656002)(39060400002)(44832011)(25786009)(478600001)(6436002)(6246003)(229853002)(446003)(8676002)(81156014)(97736004)(102836004)(8936002)(105586002)(3660700001)(7736002)(186003)(476003)(2900100001)(6506007)(53936002)(68736007)(486006)(5250100002)(305945005)(2906002)(11346002)(86362001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0776;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vb1c5ijIPUv+6rZivgaXzxSoKEY6R4tGpjnv8yRaa7NO0FELqVjklQuU3AKkCgynt3DgAFqU5eXjjacntKA5deAtqqZN97rseRoZt/rH0MSdgl4/1k1R/TkiY3gfoer2MuLLIrY/IoaTJAhYEJ+N8txS+8TzFfIff0WprW4o6gPGMfQEvocXX3AYUERsar3A
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2b164133-2c58-427a-bb4f-08d5aa5cda58
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b164133-2c58-427a-bb4f-08d5aa5cda58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 03:30:11.8593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3P3UdBc024476

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Tuesday, April 24, 2018 8:23 PM
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
> On Mon, Apr 23, 2018 at 11:09 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > Ah, yes, thanks for pointing out this issue, I just removed it and the
> > function is still working, already sent out V2 patch set, thanks.
> 
> So now maybe it is working only because the bootloader activated this GPIO,
> which is not good.
> 
> I don't have access to the mx6sx sabreauto schematics to verify  where
> &max7322 0 connects to, but it would be better to make sure that you activate
> this pin in dts if it is needed for Ethernet, without relying on the bootloader.

It is working by default hardware settings, but I agree we should do it in dts,
I found it has a lot of dependency if we want to enable the gpio reset for FEC1,
many gpio reset patch missed in upstream kernel, need patch work for MAX7322 first, so
I plan to remove FEC support in this patch set, and will upstream the MAX7322
reset patch first, then will add FEC support after MAX7322 patch done. Will send
out V3 patch to drop fec support for now, thanks.

Anson.

 
