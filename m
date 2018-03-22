Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCVE2F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 00:28:05 -0400
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:29312
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeCVE2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 00:28:03 -0400
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Subject: RE: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
 documentation for controller and driver
Thread-Topic: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
 documentation for controller and driver
Thread-Index: AQHTu4Idhk4n1pufpEiYEGYfTTnDrqPQaVUAgAtKUqA=
Date: Thu, 22 Mar 2018 04:27:50 +0000
Message-ID: <BY2PR02MB14116F392ED197B02FCB1384AFA90@BY2PR02MB1411.namprd02.prod.outlook.com>
References: <1521024494-30632-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <0abb517f-6360-5b45-18a8-d049f3ab7a4e@infradead.org>
In-Reply-To: <0abb517f-6360-5b45-18a8-d049f3ab7a4e@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR02MB1283;7:Upc7+il1ptJuugnhwsYaZVOKkp3U4N7bNkh+3MfVXxQE64NRYe2lKruR1P4IffL5CRzN0IyL8KCYtx2wA/fPQQUJHVRN0jpQEzSa/ebHIG5wvlfl1ZYrSNN1AgB5vJG5Pwm+n2qISkDQG+3ISLkv7G6lOvZFq6l/6I+L66Ac0tkDWnP4BUvut/FzM6bPIkpTijrohZ275m8WQr0Z+j6nyFdS68ELsa9CRPpEOvzqFbgWJkzB944nPf099h/EjYmN
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 848035d3-d6a0-4884-e811-08d58fad45cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR02MB1283;
x-ms-traffictypediagnostic: BY2PR02MB1283:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY2PR02MB128367397F8779BAED8ADA51AFA90@BY2PR02MB1283.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR02MB1283;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1283;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(199004)(189003)(13464003)(25786009)(7696005)(316002)(2201001)(8676002)(81156014)(5660300001)(81166006)(53936002)(8936002)(7416002)(54906003)(97736004)(106356001)(6306002)(9686003)(6506007)(39060400002)(55236004)(2906002)(6246003)(107886003)(55016002)(76176011)(59450400001)(3846002)(229853002)(86362001)(99286004)(478600001)(6116002)(6436002)(110136005)(53546011)(3660700001)(14454004)(3280700002)(68736007)(102836004)(105586002)(2900100001)(7736002)(305945005)(74316002)(446003)(66066001)(33656002)(4326008)(5250100002)(186003)(2950100002)(26005)(2501003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1283;H:BY2PR02MB1411.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: m1D464mosiL9/DgaNBo0Tz2kLmNRVzos1kVBK5rihwP1c1W8/ZC7Z9+vNw0VS1gwoYXwrkijcPdBg1Hg0iGKr0ipT+91h1Or+tabqhXKunV5MORtN8XKaHIBq6l5D9CmmhxQX/WiB+F7rxBC8vzYlJGhZ8Y76Xuptkt7B39ZvazgTPDUPPRlzit55EnTiz6EvfGGetMUmT4LO8kAId/JObpilDTPrUe3frQvQQdWj8f2j6IOTbpIs7RuHqish8D4lYy7/xcBDm3VAJ6pNMttF39LL8GgTl+pvuax6KHDhC+8/ggVilwYxY2kRV3hYM73XgDytMjKLJbuXgVVAR1BXg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848035d3-d6a0-4884-e811-08d58fad45cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 04:27:50.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1283
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2M4SJpJ010037

Hi Randy,

Thanks for reviewing the patch.

 I will address below mentioned comments in next version of patch.

Thanks,
Naga Sureshkumar Relli.

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: Thursday, March 15, 2018 5:27 AM
> To: nagasureshkumarrelli@gmail.com; boris.brezillon@bootlin.com;
> richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> marek.vasut@gmail.com; cyrille.pitchen@wedev4u.fr;
> miquel.raynal@bootlin.com
> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek
> <michals@xilinx.com>; Punnaiah Choudary Kalluri <punnaia@xilinx.com>; Naga
> Sureshkumar Relli <nagasure@xilinx.com>
> Subject: Re: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
> documentation for controller and driver
> 
> On 03/14/2018 03:48 AM, nagasureshkumarrelli@gmail.com wrote:
> > From: Naga Sureshkumar Relli <nagasure@xilinx.com>
> >
> > Added notes about the controller and driver
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > ---
> 
> Hi,
> 
> > ---
> >  Documentation/mtd/nand/pl353-nand.txt | 92
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/mtd/nand/pl353-nand.txt
> >
> > diff --git a/Documentation/mtd/nand/pl353-nand.txt
> > b/Documentation/mtd/nand/pl353-nand.txt
> > new file mode 100644
> > index 0000000..ac6fbd5
> > --- /dev/null
> > +++ b/Documentation/mtd/nand/pl353-nand.txt
> > @@ -0,0 +1,92 @@
> > +This documents provides some notes about the ARM pl353 smc controller
> > +used in
> 
> s/smc/SMC/
> 
> > +Zynq SOC and confined to NAND specific details.
> > +
> > +Overview of the controller
> > +==========================
> > +	The SMC (PL353) supports two memory interfaces:
> > +	Interface 0 type SRAM.
> > +	Interface 1 type NAND.
> > +	This configuration supports the following configurable options:
> > +	   . 32-bit or 64-bit AXI data width
> > +	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
> > +	   . 8-bit, or 16-bit memory data width for interface 1
> > +	   . 1-4 chip selects on each interface
> > +	   . SLC ECC block for interface 1
> > +
> > +For more information, refer the below link for TRM
> > +http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/
> > +DDI0380G_smc_pl350_series_r2p1_trm.pdf
> > +
> > +NAND memory accesses
> > +====================
> > +	. Two phase NAND accesses
> > +	. NAND command phase transfers
> > +	. NAND data phase transfers
> > +
> > +Two phase NAND accesses
> > +	The SMC defines two phases of commands when transferring data to or
> > +from NAND flash.
> > +
> > +Command phase
> > +	Commands and optional address information are written to the NAND
> flash.
> > +The command and address can be associated with either a data phase
> > +operation to write to or read from the array, or a status/ID register transfer.
> > +
> > +Data phase
> > + Data is either written to or read from the NAND flash. This data can
> > +be either data transferred to or from the array, or status/ID register
> information.
> > +
> > +NAND AXI address setup
> > +       AXI address      Command phase      Data phase
> > +	[31:24]         Chip address       Chip address
> > +	[23]            NoOfAddCycles_2    Reserved
> > +	[22]            NoOfAddCycles_1    Reserved
> > +	[21]            NoOfAddCycles_0    ClearCS
> > +	[20]            End command valid  End command valid
> > +	[19]            0                  1
> > +	[18:11]         End command        End command
> > +	[10:3]          Start command      [10] ECC Last
> > +					   [9:3] Reserved
> > +	[2:0]           Reserved           Reserved
> > +
> > +ECC
> > +===
> > +    It operates on a number of 512 byte blocks of NAND memory and can
> > +be programmed to store the ECC codes after the data in memory. For
> > +writes, the ECC is written to the spare area of the page. For reads,
> > +the result of a block ECC check are made available to the device driver.
> > +
> > +---------------------------------------------------------------------
> > +---
> > +|               n * 512 blocks                  | extra  | ecc    |     |
> > +|                                               | block  | codes  |     |
> > +---------------------------------------------------------------------
> > +---
> > +
> > +The ECC calculation uses a simple Hamming code, using 1-bit
> > +correction 2-bit detection. It starts when a valid read or write
> > +command with a 512 byte aligned address is detected on the memory
> interface.
> > +
> > +Driver details
> > +==============
> > +	The NAND driver has dependency with the pl353_smc memory
> controller
> > +driver for intializing the nand timing parameters, bus width, ECC
> > +modes,
> 
>               initializing the NAND
> 
> > +control and status information.
> > +
> > +Since the controller expects that the chipselect bit should be
> > +cleared for the last data transfer i.e last 4 data bytes, the
> > +existing nandbase page read/write routines for soft ecc and ecc none
> > +modes will not work. So, inorder
> 
>                                                                           in order
> 
> > +to make this driver work, it always updates the ecc mode as HW ECC
> > +and
> 
>                                                    ECC mode
> 
> > +implemented the page read/write functions for supporting the SW ECC.
> 
>    implements the
> 
> > +
> > +HW ECC mode:
> > +	Upto 2K page size is supported and beyond that it retuns
> 
> 	Up to                                             returns
> 
> > +-ENOSUPPORT error. If the flsh has ONDIE ecc controller then the
> 
>                              flash (?) has on-die ECC
> 
> > +priority has given to the ONDIE ecc controller. Also the current
> 
>             is               on-die ECC
> 
> > +implementation has support for upto 64 byte oob area
> 
>                                   up to            area.
> 
> > +
> > +SW ECC mode:
> > +	It supports all the pgae sizes. But since, zynq soc bootrom uses
> 
> 	                                           Zynq SOC
> 
> > +HW ECC for the devices that have pgae size <=2K so, to avoid any ecc
> > +related
> 
>                                     page      <= 2K, to avoid any ECC-related
> 
> > +issues during boot, prefer HW ECC over SW ECC.
> > +
> > +For devicetree binding information please refer the below dt binding
> > +file
> 
>                                       please refer to the below
> 
> > +Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.
> >
> 
> 
> --
> ~Randy
