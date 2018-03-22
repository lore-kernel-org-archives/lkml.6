Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCVFgv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:36:51 -0400
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:22101
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752246AbeCVFgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:36:50 -0400
From: Naga Sureshkumar Relli <nagasure@xilinx.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
CC: "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "Punnaiah Choudary Kalluri" <punnaia@xilinx.com>
Subject: RE: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
 documentation for controller and driver
Thread-Topic: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
 documentation for controller and driver
Thread-Index: AQHTu4Idhk4n1pufpEiYEGYfTTnDrqPYFcGAgAOeo/A=
Date: Thu, 22 Mar 2018 05:36:44 +0000
Message-ID: <BY2PR02MB1411BBD9FB5D17BB641D2B89AFA90@BY2PR02MB1411.namprd02.prod.outlook.com>
References: <1521024494-30632-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <20180319220811.34a99c3d@xps13>
In-Reply-To: <20180319220811.34a99c3d@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR02MB1942;7:n8FRu+zJ3X3BE2m4S/cOZTbnylNdAnc8p8s+y4SdF2h0cxy9h1YiUZ0RIUCbuDuPAQ2KEa6mkpF4Nq7M/pf2wNAQY+VfD6OpR/PKSID6FAH9pLofRDf0JvtaQ84g2T4wKTDZQ7nYD64jtBSTHtMAt5ccepK5FTk7tITMf0SFSCP0dtI5iDwrtQe+NS3TR2uArR2U9lmRSmrywccMgDJ0k5YkpKm25eReWoOfZehVxEPFsxP8MwLGH1M8fhXNO6cp
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f6a28df-d70c-4905-33de-08d58fb6e61f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR02MB1942;
x-ms-traffictypediagnostic: BY2PR02MB1942:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY2PR02MB1942BB28DFBD755F5121FE97AFA90@BY2PR02MB1942.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR02MB1942;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1942;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(366004)(39860400002)(346002)(189003)(199004)(13464003)(6506007)(55236004)(53546011)(229853002)(3660700001)(39060400002)(76176011)(2501003)(4326008)(26005)(7696005)(9686003)(8676002)(6246003)(6116002)(66066001)(86362001)(74316002)(5250100002)(2906002)(102836004)(305945005)(59450400001)(446003)(186003)(8936002)(5660300001)(3846002)(81156014)(81166006)(25786009)(2900100001)(68736007)(110136005)(54906003)(7736002)(14454004)(2950100002)(6436002)(97736004)(106356001)(7416002)(478600001)(6306002)(55016002)(99286004)(53936002)(107886003)(316002)(966005)(33656002)(3280700002)(105586002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1942;H:BY2PR02MB1411.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9haYPd1fldbaPHwwa9e6oK/wTt1LW7Nlf4DjSrOXz/yrlsfbSu0dHjb/LDqPCyjgDZ2gIyhuJxKbYZIn/NhIxvzEHiZVpQhNVBC/VVCucoMk3G6jwfHD8wywC3mV/6Yjq1+nGLNQwnuTs9X3sbRxPYCCaq2VYia3ZljgWXvS/BiEY3sj3MmiX2bQEGH70xmL0WW+cxl6Kv9k3XJciL+cjOcWv9/E0XWPdv5eyQ0TMCBpucNFHJagzL0l3Jq1aKyDc9KYkW5uQoe+nwj/KL7CqrKN+OV7R0yNmGF6D1T+PHhobswYj8bxWcg11/Ou/MjjV264SPl2OByuFOieVlXw3w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6a28df-d70c-4905-33de-08d58fb6e61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 05:36:44.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1942
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2M5b8lU024610

Hi Miquel,

Thanks for reviewing the patch series.
Please see my comments below.

> -----Original Message-----
> From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> Sent: Tuesday, March 20, 2018 2:38 AM
> To: nagasureshkumarrelli@gmail.com
> Cc: boris.brezillon@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com;
> cyrille.pitchen@wedev4u.fr; linux-mtd@lists.infradead.org; linux-
> kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>; Punnaiah
> Choudary Kalluri <punnaia@xilinx.com>; Naga Sureshkumar Relli
> <nagasure@xilinx.com>
> Subject: Re: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
> documentation for controller and driver
> 
> Hi naga,
> 
> On Wed, 14 Mar 2018 16:18:14 +0530, <nagasureshkumarrelli@gmail.com>
> wrote:
> 
> > From: Naga Sureshkumar Relli <nagasure@xilinx.com>
> >
> > Added notes about the controller and driver
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > ---
> > Changes in v8
> >  - None
> > Changes in v7:
> > - None
> > Changes in v6:
> > - None
> > Changes in v5:
> > - Fixed the review comments
> > Changes in v4:
> > - None
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
> > +used in Zynq SOC and confined to NAND specific details.
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
> 
> I think it is better to do not break the links?
I will correct it in next patch.
> 
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
>                               ^NAND
> 
> > +control and status information.
> > +
> > +Since the controller expects that the chipselect bit should be
> > +cleared for the
> 
>                                          ^chip select   ^ would? is?
Will correct in next patch.
> 
> > +last data transfer i.e last 4 data bytes, the existing nandbase page
> 
> What is nandbase?
It is just nand page read/write, I will correct it,
> 
> > +read/write routines for soft ecc and ecc none modes will not work.
> > +So, inorder
> 
> s/ecc/ECC/                                                   in order^
> 
> > +to make this driver work, it always updates the ecc mode as HW ECC
> > +and can
> 
> s/ecc/ECC/
I will update.
> 
> > +implemented the page read/write functions for supporting the SW ECC.
> 
> s/can implemented/implements/?
Will correct in next patch.

> 
> I don't understand this paragraph, can you explain it please? I am not sure to
> understand the limitation nor how you address it.
There is a limitation in SMC, that we must set ECC LAST on last data phase access, 
to tell ECC block not to expect any data further.
Ex:  When number of ECC STEP are 4, then till 3 we will write to flash using SMC with HW ECC enabled.
And for the last ECC STEP, we will subtract 4bytes from page size, and will initiate a transfer.
And the remaining 4 as one more transfer with ECC_LAST bit set in NAND Data phase register to notify
ECC block not to expect any more data. The last block should be align with end of 512 byte block.
Because of this limitation, we are not using core routines.
> 
> > +
> > +HW ECC mode:
> > +	Upto 2K page size is supported and beyond that it retuns -ENOSUPPORT
> > +error. If the flsh has ONDIE ecc controller then the
> 
>     ^ -ENOTSUPP              ^flash   ^on-die ECC
> 
Will correct in next patch.
> > +priority has given to the ONDIE ecc controller. Also the current
> 
>             ^ is given?      ^on-die ECC
> 
Will correct in next patch.
> > +implementation has support for upto 64 byte oob area
> 
>                                   ^up to 64 bytes of OOB data.
> 
Will correct in next patch.
> > +
> > +SW ECC mode:
> > +	It supports all the pgae sizes. But since, zynq soc bootrom uses
> 
>                             ^ page                 ^Zync SOC
> 
Will correct in next patch.
> > +HW ECC for the devices that have pgae size <=2K so, to avoid any ecc
> > +related
> 
>                                     ^ page <= 2K,               ECC^
> 
Will correct in next patch.
> > +issues during boot, prefer HW ECC over SW ECC.
> 
> I suppose this means that if no ECC mode is given ie. no nand-ecc-mode in the
> DT, the driver will use HW ECC by default, right?
Yes.
> 
> > +
> > +For devicetree binding information please refer the below dt binding
> > +file Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.
> 
> This file does not exist in my tree.
Actually this driver has dependency with SMC driver.
Recently I sent one more patch series, there we will find all these.
This is for drivers/memory/
Since SMC controller has two interfaces, Nand and Nor.
So we have two drivers, one main driver is SMC and the second is NAND driver.
https://www.spinics.net/lists/kernel/msg2748832.html
https://www.spinics.net/lists/kernel/msg2748834.html
https://www.spinics.net/lists/kernel/msg2748840.html

> 
> 
> Thanks for contributing this driver,
> Miquèl
> 
> --
> Miquel Raynal, Bootlin (formerly Free Electrons) Embedded Linux and Kernel
> engineering https://bootlin.com

Thanks,
Naga Sureshkumar Relli.
