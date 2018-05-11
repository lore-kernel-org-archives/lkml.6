Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeEKRAf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:00:35 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:62912
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751147AbeEKRAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:00:33 -0400
From: Leo Li <leoyang.li@nxp.com>
To: Yinbo Zhu <yinbo.zhu@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Catalin Marinas )" <catalin.marinas@arm.com>,
        "Will Deacon )" <will.deacon@arm.com>,
        "Lorenzo Pieralisi )" <lorenzo.pieralisi@arm.com>
CC: Xiaobo Xie <xiaobo.xie@nxp.com>, Ran Wang <ran.wang_1@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>, Jerry Huang <jerry.huang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jiaheng Fan <jiaheng.fan@nxp.com>, Po Liu <po.liu@nxp.com>,
        Nipun Gupta <nipun.gupta@nxp.com>,
        =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>, Sumit Garg <sumit.garg@nxp.com>,
        costi <constantin.tudor@freescale.com>,
        Bogdan Purcareata <bogdan.purcareata@nxp.com>,
        "open list:CLOCKSOURCE, CLOCKEVENT DRIVERS"
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
        Andy Tang <andy.tang@nxp.com>, Ying Zhang <ying.zhang22455@nxp.com>
Subject: RE: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
Thread-Topic: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
Thread-Index: AQHT6NlaPrpxI09eQEa6QyDO5ACmJKQqwDMw
Date: Fri, 11 May 2018 17:00:28 +0000
Message-ID: <AM4PR0401MB16995DFED0376ACE0DD5E7A78F9F0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <20180511033530.7931-1-yinbo.zhu@nxp.com>
 <20180511033530.7931-3-yinbo.zhu@nxp.com>
In-Reply-To: <20180511033530.7931-3-yinbo.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com;
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2404;7:ynRnHuUIpxEPuaIYWMRrRORcTtXLZ2spTQy8/QyMZuMkvaB5qzqrVvWs0SiExKNEvBpOO2tsM7h6EQsuTqA2R0NlFzo7bjTRiy/8ufYBCArRHdjdocO4gArfU1HlKhYcSSyDBniX+6DY8zLX8+gNQm5hPjaozib7s4iP3x68ePpatQVGEqfb7gUp0g1Xm9aKFl/m2eOmfs7RkAtjxypC17DeUsLsiLfiirQN43R6UfesoZq+R1qWprU9QV3v7s0Y
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2404;
x-ms-traffictypediagnostic: AM4PR0401MB2404:
x-microsoft-antispam-prvs: <AM4PR0401MB240439FE40481093A7EF7EF88F9F0@AM4PR0401MB2404.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(101931422205132)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM4PR0401MB2404;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2404;
x-forefront-prvs: 06691A4183
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(39380400002)(13464003)(199004)(189003)(2906002)(3660700001)(74316002)(76176011)(53546011)(3280700002)(102836004)(7416002)(5250100002)(6506007)(476003)(446003)(7736002)(11346002)(26005)(97736004)(5660300001)(229853002)(54906003)(316002)(66066001)(68736007)(110136005)(99286004)(305945005)(106356001)(6436002)(105586002)(3846002)(55016002)(53936002)(7696005)(478600001)(2900100001)(14454004)(486006)(4326008)(81166006)(33656002)(6116002)(9686003)(25786009)(8676002)(86362001)(6246003)(81156014)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2404;H:AM4PR0401MB1699.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fm9IZ2v0ijt43vrUTy5CA697Bz2uYkW7xLai9n7XjSzm1tzjLrPL9UEDpj9zFiI8yNXTNfBtlaeYD/vbfF7WROrxrozvdZN427v5ujPd8aU7NB4qTQp7ewE9wchTZtTBN882no748bW6X6ahFESqcRlc8Gqk/6iKsl49VT0mqri4+ETI7EkHNf6Q9S8dstR4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c303dfb7-c5ba-48a9-3ec1-08d5b760b28b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c303dfb7-c5ba-48a9-3ec1-08d5b760b28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 17:00:28.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2404
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4BH0d3d028583



> -----Original Message-----
> From: Yinbo Zhu [mailto:yinbo.zhu@nxp.com]
> Sent: Thursday, May 10, 2018 10:35 PM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Catalin Marinas )
> <catalin.marinas@arm.com>; Will Deacon ) <will.deacon@arm.com>;
> Lorenzo Pieralisi ) <lorenzo.pieralisi@arm.com>; Leo Li <leoyang.li@nxp.com>
> Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; Ran Wang <ran.wang_1@nxp.com>;
> Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> <tglx@linutronix.de>; Shawn Guo <shawnguo@kernel.org>; Madalin-cristian
> Bucur <madalin.bucur@nxp.com>; Z.q. Hou <zhiqiang.hou@nxp.com>; Jerry
> Huang <jerry.huang@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>;
> Qiang Zhao <qiang.zhao@nxp.com>; Fabio Estevam
> <fabio.estevam@nxp.com>; Jiaheng Fan <jiaheng.fan@nxp.com>; Po Liu
> <po.liu@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>; Horia Geantã
> <horia.geanta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Sumit
> Garg <sumit.garg@nxp.com>; costi <constantin.tudor@freescale.com>;
> Bogdan Purcareata <bogdan.purcareata@nxp.com>; Meng Yi
> <meng.yi@nxp.com>; Wang Dongsheng <dongsheng.wang@nxp.com>; open
> list:CLOCKSOURCE, CLOCKEVENT DRIVERS <linux-kernel@vger.kernel.org>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-arm-kernel@lists.infradead.org; open
> list:FREESCALE SOC DRIVERS <linuxppc-dev@lists.ozlabs.org>; Andy Tang
> <andy.tang@nxp.com>; Ying Zhang <ying.zhang22455@nxp.com>
> Subject: [PATCH 3/9] soc: fsl: set rcpm bit for FTM
> 
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Set RCPM for FTM when using FTM as wakeup source. Because the RCPM
> module of each platform has different big-end and little-end mode, there
> need to set RCPM depending on the platform.
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,ftm-timer.txt    |    7 ++
>  drivers/soc/fsl/layerscape/ftm_alarm.c             |   92 ++++++++++++++++++-
>  2 files changed, 94 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> index aa8c402..15ead58 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
> @@ -3,6 +3,13 @@ Freescale FlexTimer Module (FTM) Timer  Required
> properties:
> 
>  - compatible : should be "fsl,ftm-timer"

Hi Yingbo,

This is a change that breaks backward compatibility and not acceptable.

> + Possible compatibles for ARM:
> +     "fsl,ls1012a-ftm"
> +     "fsl,ls1021a-ftm"
> +     "fsl,ls1043a-ftm"
> +     "fsl,ls1046a-ftm"
> +     "fsl,ls1088a-ftm"
> +     "fsl,ls208xa-ftm"
>  - reg : Specifies base physical address and size of the register sets for the
>    clock event device and clock source device.
>  - interrupts : Should be the clock event device interrupt.
> diff --git a/drivers/soc/fsl/layerscape/ftm_alarm.c
> b/drivers/soc/fsl/layerscape/ftm_alarm.c
> index 6f9882f..811dcfa 100644
> --- a/drivers/soc/fsl/layerscape/ftm_alarm.c
> +++ b/drivers/soc/fsl/layerscape/ftm_alarm.c

There is no such file in the mainline kernel.  So it looks like the patch set is based on some internal git repo instead of the upstream Linux kernel.  This kind of patches shouldn't be sent to the upstream mailing list for review.

Regards,
Leo
