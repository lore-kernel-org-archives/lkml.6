Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeBGGni (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 01:43:38 -0500
Received: from mail-db5eur01on0070.outbound.protection.outlook.com ([104.47.2.70]:39946
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753449AbeBGGng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 01:43:36 -0500
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Qiang Zhao <qiang.zhao@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v13 0/4] This patchset is to remove PPCisms for QEIC
Thread-Topic: [Patch v13 0/4] This patchset is to remove PPCisms for QEIC
Thread-Index: AQHTWdb5r/xWWLVQD0+a/tK0Q3+9u6OZCghQ
Date: Wed, 7 Feb 2018 06:43:33 +0000
Message-ID: <AM3PR04MB1185DAF02B9E5D3A5B2F387591FC0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <20171110033125.991-1-qiang.zhao@nxp.com>
In-Reply-To: <20171110033125.991-1-qiang.zhao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com;
x-originating-ip: [185.114.77.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1236;7:l+mkJAruameWFEGXe4VA0mRjjXjWn9UPC8pG0c9vc03eyjvrbCNFOIhjzXqxs9mjsYQZj3tj3yLUQRInzrCugiOiFUxlQD64c8gNwH4/ZP79f4TrRr1edSEQEMNMHbaek2ZDtp1tvx5mbUSuf0tH1wHS3O3kVPGMzAGkEHVlWrmyO77o7tongMwIo0x7jd10/iGOw2M/zGd+pLq/LoB6mdv2xPIs6klvnaLdtHL2pdWvcj0bEOKp0Z78+xGBTBnY
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(366004)(346002)(39860400002)(13464003)(199004)(189003)(54534003)(53754006)(3660700001)(6436002)(2201001)(7696005)(76176011)(97736004)(9686003)(86362001)(66066001)(68736007)(2900100001)(3280700002)(99286004)(25786009)(53936002)(106356001)(478600001)(229853002)(6246003)(105586002)(4326008)(55016002)(7736002)(305945005)(2906002)(74316002)(2501003)(81166006)(5660300001)(110136005)(8936002)(33656002)(8676002)(5250100002)(26005)(2950100002)(59450400001)(316002)(53546011)(3846002)(14454004)(6506007)(102836004)(6116002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1236;H:AM3PR04MB1185.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1480e6b9-a2a1-4056-8e54-08d56df61ba2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB1236;
x-ms-traffictypediagnostic: AM3PR04MB1236:
x-microsoft-antispam-prvs: <AM3PR04MB1236425573731F5832CD8CCF91FC0@AM3PR04MB1236.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM3PR04MB1236;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1236;
x-forefront-prvs: 0576145E86
x-microsoft-antispam-message-info: g5GMy6Bi9umDyZKUhv315EswfWLLOng8Y0PznLSt0A9l1nmDIfnN+zIq6yD0xgt7/smZc0jJSBaOLO9uk/fnXQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1480e6b9-a2a1-4056-8e54-08d56df61ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2018 06:43:33.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w176hi4Z005387

Hi all,

Is there any comments on this patchset?

Best Regards
Qiang Zhao

-----Original Message-----
From: Zhao Qiang [mailto:qiang.zhao@nxp.com] 
Sent: 2017Äê11ÔÂ10ÈÕ 11:31
To: tglx@linutronix.de; marc.zyngier@arm.com; jason@lakedaemon.net
Cc: linux-kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
Subject: [Patch v13 0/4] This patchset is to remove PPCisms for QEIC

QEIC is an interrupt controller for QE, was put under drivers/soc/fsl/qe, and now move to driver/irqchip.
And QEIC is supported more than just powerpc boards, so remove PPCisms.

changelog:
	Changes for v8:
	- use IRQCHIP_DECLARE() instead of subsys_initcall in qeic driver
	- remove include/soc/fsl/qe/qe_ic.h
	Changes for v9:
	- rebase 
	- fix the compile issue when apply the second patch, in fact, there was no compile issue 
	  when apply all the patches of this patchset
	Changes for v10:
	- simplify codes, remove duplicated codes 
	Changes for v11:
	- rebase
	Changes for v13:
	- rewrite single-bit constants to BIT(x) to make the code more readable

Zhao Qiang (4):
  irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
	Changes for v2:
		- modify the subject and commit msg
	Changes for v3:
		- merge .h file to .c, rename it with irq-qeic.c
	Changes for v4:
		- modify comments
	Changes for v5:
		- disable rename detection
	Changes for v6:
		- rebase
	Changes for v7:
		- na

  irqchip/qeic: merge qeic init code from platforms to a common function
	Changes for v2:
		- modify subject and commit msg
		- add check for qeic by type
	Changes for v3:
		- na
	Changes for v4:
		- na
	Changes for v5:
		- na
	Changes for v6:
		- rebase
	Changes for v7:
		- na
	Changes for v8:
		- use IRQCHIP_DECLARE() instead of subsys_initcall

  irqchip/qeic: merge qeic_of_init into qe_ic_init
	Changes for v2:
		- modify subject and commit msg
		- return 0 and add put node when return in qe_ic_init
	Changes for v3:
		- na
	Changes for v4:
		- na
	Changes for v5:
		- na
	Changes for v6:
		- rebase
	Changes for v7:
		- na
	Changes for v12:
		- remove unused code

  irqchip/qeic: remove PPCisms for QEIC
	Changes for v6:
		- new added
	Changes for v7:
		- fix warning
	Changes for v8:
		- remove include/soc/fsl/qe/qe_ic.h

Zhao Qiang (4):
  irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
  irqchip/qeic: merge qeic init code from platforms to a common function
  irqchip/qeic: merge qeic_of_init into qe_ic_init
  irqchip/qeic: remove PPCisms for QEIC

 MAINTAINERS                                        |   6 +
 arch/powerpc/platforms/83xx/km83xx.c               |   1 -
 arch/powerpc/platforms/83xx/misc.c                 |  16 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   1 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   1 -
 arch/powerpc/platforms/85xx/corenet_generic.c      |  10 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |  15 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  17 -
 arch/powerpc/platforms/85xx/twr_p102x.c            |  15 -
 drivers/irqchip/Makefile                           |   1 +
 drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} | 423 +++++++++++----------
 drivers/soc/fsl/qe/Makefile                        |   2 +-
 drivers/soc/fsl/qe/qe_ic.h                         | 103 -----
 include/soc/fsl/qe/qe_ic.h                         | 139 -------
 16 files changed, 231 insertions(+), 521 deletions(-)  rename drivers/{soc/fsl/qe/qe_ic.c => irqchip/irq-qeic.c} (53%)  delete mode 100644 drivers/soc/fsl/qe/qe_ic.h  delete mode 100644 include/soc/fsl/qe/qe_ic.h

--
2.14.1
