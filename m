Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeEaA7u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:59:50 -0400
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:46874
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932475AbeEaA7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:59:47 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
Thread-Topic: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
 idle driver
Thread-Index: AQHT9+Yb0pJVGY124Emum6rx24XNYaRINSiAgADN1qCAAAHEgIAAAGKQ
Date: Thu, 31 May 2018 00:59:42 +0000
Message-ID: <AM3PR04MB1315345C3578D0644B82E8E9F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
 <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com>
In-Reply-To: <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1313;7:gUQRe3BOiWFkKfKPGEpWZYMWTAki7UW4p8SlNX7GUpi3lcJ1lBgGXZBFLs1B8i2F85GgpJC+RvyMqDn0WQ9b28IR2TjJnhYIj/wQqENzKekRx79nFX100kQzw1DRlsx25KLdyocLyeHmDfKRD6bAatMUDwshKS/kpCYoMaZSsmk7SSeGg2pPVFQIVpunfu+IiC7ocYpfZ2KiVKokTwIHCsg0JmZnHKiCTgiX5TkOShe/f2C+d8JgCQSIcVmuLvNQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1313;
x-ms-traffictypediagnostic: AM3PR04MB1313:
x-microsoft-antispam-prvs: <AM3PR04MB1313056B51392EBAE2566AC9F5630@AM3PR04MB1313.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1313;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1313;
x-forefront-prvs: 06891E23FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(39380400002)(376002)(199004)(189003)(13464003)(2906002)(25786009)(4326008)(5250100002)(39060400002)(97736004)(5660300001)(2900100001)(3280700002)(66066001)(6246003)(33656002)(106356001)(53936002)(3660700001)(9686003)(105586002)(81156014)(81166006)(6116002)(1411001)(3846002)(305945005)(74316002)(14454004)(8676002)(6506007)(68736007)(8936002)(478600001)(7736002)(6916009)(102836004)(486006)(229853002)(7696005)(53546011)(93886005)(6436002)(44832011)(316002)(99286004)(26005)(446003)(55016002)(86362001)(11346002)(476003)(76176011)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1313;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZFJFeTsbEFLB7qXuHIDDHebkNCKIlHJmFbQjHRQwrOrTcq8FDMy2hrIwBdTUaCmu7DEaKpRWsIwhDkLEY5BP60JLLN7akghYbAEW/RAGsICp9wPSL48dq3GO6vYNS6uTnIPog6jDax9dMvM9/hckLbXQAEQPtEYcsmhpxy2E1FmXOMKA2tzPkuZfDGfNVv+p
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dfe5096a-6998-4ddf-5a26-08d5c691cb8e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe5096a-6998-4ddf-5a26-08d5c691cb8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2018 00:59:42.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1313
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4V10AO6032166

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Thursday, May 31, 2018 8:57 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
> idle driver
> 
> Hi Anson,
> 
> On Wed, May 30, 2018 at 9:52 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> >> The removal of this header file seems to be an unrelated change.
> >
> > This header file is no longer needed since no " cpu_is_imx6sl()" used in this
> file.
> 
>  cpu_is_imx6sl() is not defined inside arch/arm/mach-imx/hardware.h header
> file.
 
It is in arch/arm/mach-imx/mxc.h included by hardware.h, it is added by commit
(dee5dee ARM: imx: Add basic msl support for imx6sll), so I removed it since we
no longer need it.

Anson.
