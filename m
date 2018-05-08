Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeEHGfw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:35:52 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:53472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752214AbeEHGfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:35:50 -0400
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Julia Cartwright <julia@ni.com>
CC: "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Topic: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Thread-Index: AQHTu4GvmXFu5KnCoUisvmGJ5xXly6PvYMoAgDT38PCAAHfqAIAA5YRw
Date: Tue, 8 May 2018 06:35:46 +0000
Message-ID: <BY2PR02MB1411D166CF8D31421D183A5DAF9A0@BY2PR02MB1411.namprd02.prod.outlook.com>
References: <1521024235-30374-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <1521024274-30467-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <20180403165042.GE7654@jcartwri.amer.corp.natinst.com>
 <BY2PR02MB1411FA717E8DFB244F9B7976AF9B0@BY2PR02MB1411.namprd02.prod.outlook.com>
 <20180507165248.GK967@jcartwri.amer.corp.natinst.com>
In-Reply-To: <20180507165248.GK967@jcartwri.amer.corp.natinst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR02MB1378;7:B6yu10XkwSEINeOjJj+yu8+wva2zACmlz5kJJPivpn3QGD4KSdnTuJe727Sl/lG2nu8xAcLAjFWVZxyIs3KVPgyoSyxtUXKmTYyDShHGkMPFP3/Lg5qAXe8UI1erhybG4xl5jKH64Wi1+yy3s+XsLm3Qu+Ku3002pq3kfm4uAnkmgrrIkoimltLQp62UI7ABeW6Gb08ZAlp+Y172MNkr31//SJD4T+148pmjodPbtw+Qy2DIteH3fc7ol82i1eom
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR02MB1378;
x-ms-traffictypediagnostic: BY2PR02MB1378:
x-microsoft-antispam-prvs: <BY2PR02MB1378A0FB9709ACDC635DC5D7AF9A0@BY2PR02MB1378.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(9452136761055)(85827821059158)(192813158149592)(58145275503218)(145744241990776);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR02MB1378;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1378;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(376002)(39860400002)(396003)(346002)(54534003)(13464003)(199004)(189003)(52314003)(74316002)(8936002)(54906003)(59450400001)(6916009)(6506007)(5250100002)(53546011)(446003)(55236004)(11346002)(305945005)(93886005)(186003)(26005)(33656002)(6436002)(486006)(102836004)(476003)(229853002)(68736007)(2906002)(97736004)(86362001)(105586002)(106356001)(5660300001)(3280700002)(25786009)(3660700001)(7416002)(2900100001)(81156014)(6116002)(316002)(3846002)(39060400002)(4326008)(66066001)(6246003)(8676002)(14454004)(55016002)(76176011)(7696005)(9686003)(478600001)(53936002)(99286004)(81166006)(7736002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1378;H:BY2PR02MB1411.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4UIQ4QX4r8/UQcads0IHFTmH5Qjw9mNofCTKzyae8iNkRN3YCwTIqe4m01WfQDp50dT7wDvk8R0ztnxYyUTgEOHEyl7A4Wl0gumDDnGw/HnVOhgswmDm9HSYZoXmJC5M3UGpae7bPP1AU4P3mnAiJfiLe4ww5+PRWE8wgAwXGsNYaZDkPSAT89YlWzZGfgkp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8842a793-749c-436d-91cb-08d5b4adee48
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8842a793-749c-436d-91cb-08d5b4adee48
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 06:35:46.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1378
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w486Zv01021370



> -----Original Message-----
> From: Julia Cartwright [mailto:julia@ni.com]
> Sent: Monday, May 7, 2018 10:23 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: nagasureshkumarrelli@gmail.com; boris.brezillon@bootlin.com; rogerq@ti.com;
> lee.jones@linaro.org; alexandre.belloni@free-electrons.com; nicolas.ferre@microchip.com;
> ladis@linux-mips.org; ada@thorsis.com; linux-kernel@vger.kernel.org
> Subject: Re: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353 static
> memory controller
> 
> On Mon, May 07, 2018 at 10:12:28AM +0000, Naga Sureshkumar Relli wrote:
> > Hi Julia,
> >
> > Thanks for reviewing the patch and Sorry for my late reply. This patch
> > went to junk folder, hence I didn't catch this patch.
> >
> > From: Julia Cartwright [mailto:julia@ni.com]
> [..]
> > >
> > > It would be easier to follow if you constructed your two patchsets
> > > with git format-patch -- thread.
> > >
> >
> > I am using the same but with out --thread.
> >
> > > Or, merge them into a single patchset, especially considering the dependency between
> patches.
> >
> > But both are different patches, one for Device tree documentation and other for driver
> update.
> 
> Yes, I'm not proposing you merge _patches_ but _patchsets_.  You have two patchsets, one for
> the SMC driver, and another for the NAND.  Given that they depend on one another, it's
> helpful for reviewers if you sent them all together, with a cover letter which describes the
> entire patchset, changelog, it's dependencies, revision changelog, etc.
> 
> Something like:
> 
>    [PATCH v9 0/4] rawnand: memory: add support for PL353 static memory controller +
> NAND
>       [PATCH v9 1/4] Devicetree: Add pl353 smc controller devicetree binding information
>       [PATCH v9 2/4] memory: pl353: Add driver for arm pl353 static memory controller
>       [PATCH v9 3/4] Documentation: nand: pl353: Add documentation for controller and
> driver
>       [PATCH v9 4/4] mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface
> 
> Anyway, just with --thread enabled would be an improvement.
Ok. Got it. But both are different layers hence I sent like that.

> 
> [..]
> > > > --- a/drivers/memory/Kconfig
> > > > +++ b/drivers/memory/Kconfig
> > > > @@ -152,6 +152,13 @@ config DA8XX_DDRCTL
> > > >  	  This driver is for the DDR2/mDDR Memory Controller present on
> > > >  	  Texas Instruments da8xx SoCs. It's used to tweak various memory
> > > >  	  controller configuration options.
> > > > +config PL35X_SMC
> > > > +	bool "ARM PL35X Static Memory Controller(SMC) driver"
> > >
> > > Is there any reason why this can't be tristate?
> >
> > There is a Nand driver which uses this driver. i.e The NAND driver
> > Depends on this driver.
> 
> That's true, but it's irrelevant to question I asked.  It is perfectly valid for both the SMC and
> NAND drivers to be tristate, why are you not allowing this configuration?
Yes, I will update it in next version of patch set.

Thanks,
Naga Sureshkumar Relli
> 
>    Julia
