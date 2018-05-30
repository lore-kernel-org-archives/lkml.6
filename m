Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965156AbeE3GWJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:22:09 -0400
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:64173
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934498AbeE3GWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:22:05 -0400
From: Vishal Sagar <vsagar@xilinx.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Vishal Sagar <vishal.sagar@xilinx.com>, Hyun Kwon <hyunk@xilinx.com>,
        "laurent.pinchart@ideasonboard.com"
        <laurent.pinchart@ideasonboard.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Dinesh Kumar <dineshk@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem driver
Thread-Topic: [PATCH 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem driver
Thread-Index: AQHT937uMW8FXDmICEij2ceN0K+vCaRHIAyAgACSj6A=
Date: Wed, 30 May 2018 06:22:02 +0000
Message-ID: <CY4PR02MB2709A481A94CB673DC8C87EBA76C0@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-3-git-send-email-vishal.sagar@xilinx.com>
 <5bf470c0-8737-273e-c138-58a05d7d9a30@infradead.org>
In-Reply-To: <5bf470c0-8737-273e-c138-58a05d7d9a30@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR02MB2567;7:sQ5VPb0uSGgfdSCrYwbIbf27G6LwExj19s26+ZUqlbJgUbVZ+4HpIHQz2+PBK8jt8r2lV2gVLsbt8mUqCDL7r3yGY558Vt5Kmt+0AbRpmmdbIlQEYNrWQZhIzX+rPwvgIAb3rToaf9nMHqCSZ+1qK68DEV2wWY+/HVv+ZF0bdHGWYupoLuBwVpH1JWfaZ0vcfnX/9/ujOSQVNI7UiNk4UQLBzgN/Z3fv/U1vS4dZNWW5YVqVyxWhacpWtuAJ6vKr
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(13464003)(189003)(199004)(478600001)(6436002)(316002)(9686003)(110136005)(54906003)(33656002)(7416002)(76176011)(305945005)(81156014)(7696005)(5250100002)(81166006)(7736002)(8676002)(2201001)(25786009)(86362001)(14454004)(55016002)(53936002)(4326008)(6246003)(229853002)(486006)(446003)(6506007)(53546011)(102836004)(11346002)(26005)(55236004)(186003)(2900100001)(66066001)(105586002)(59450400001)(74316002)(106356001)(97736004)(3280700002)(3660700001)(99286004)(6116002)(2906002)(68736007)(8936002)(476003)(2501003)(5660300001)(3846002)(5890100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2567;H:CY4PR02MB2709.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR02MB2567;
x-ms-traffictypediagnostic: CY4PR02MB2567:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com;
x-microsoft-antispam-prvs: <CY4PR02MB256708FF88CFED4FF5E40909A76C0@CY4PR02MB2567.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(95692535739014)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2567;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2567;
x-forefront-prvs: 0688BF9B46
x-microsoft-antispam-message-info: z3zEeLdgZGd9xsH81f9bYODTuxfG5Vft1HFxxEJ7jkXpEsle1lIHgg4vn3EJn3rzQDDPDT6ngpbD8p3qsap39c8C6zzNF00W4Y9/ToDsjmiXV68KGW7CP8T6fpua5dGpeKoNpvzezsfyWTCL2qCZkV1IeXbWJPbimOnEVJOv5i+hdws1B1Tq8ZxYfUlxJm2b
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 989fe1cf-f7d3-4788-38e0-08d5c5f5a890
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989fe1cf-f7d3-4788-38e0-08d5c5f5a890
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 06:22:02.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2567
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4U6MJUY024576

Hi Randy,

Thanks for reviewing. 

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: Wednesday, May 30, 2018 1:29 AM
> To: Vishal Sagar <vishal.sagar@xilinx.com>; Hyun Kwon <hyunk@xilinx.com>;
> laurent.pinchart@ideasonboard.com; michal.simek@xilinx.com; linux-
> media@vger.kernel.org; devicetree@vger.kernel.org
> Cc: sakari.ailus@linux.intel.com; hans.verkuil@cisco.com;
> mchehab@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Dinesh
> Kumar <dineshk@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
> driver
> 
> On 05/29/2018 11:54 AM, Vishal Sagar wrote:
> >
> > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > ---
> >  drivers/media/platform/xilinx/Kconfig           |   12 +
> >  drivers/media/platform/xilinx/Makefile          |    1 +
> >  drivers/media/platform/xilinx/xilinx-csi2rxss.c | 1751
> +++++++++++++++++++++++
> >  include/uapi/linux/xilinx-csi2rxss.h            |   25 +
> >  include/uapi/linux/xilinx-v4l2-controls.h       |   14 +
> >  5 files changed, 1803 insertions(+)
> >  create mode 100644 drivers/media/platform/xilinx/xilinx-csi2rxss.c
> >  create mode 100644 include/uapi/linux/xilinx-csi2rxss.h
> >
> > diff --git a/drivers/media/platform/xilinx/Kconfig
> b/drivers/media/platform/xilinx/Kconfig
> > index a5d21b7..06d5944 100644
> > --- a/drivers/media/platform/xilinx/Kconfig
> > +++ b/drivers/media/platform/xilinx/Kconfig
> > @@ -8,6 +8,18 @@ config VIDEO_XILINX
> >
> >  if VIDEO_XILINX
> >
> > +config VIDEO_XILINX_CSI2RXSS
> > +       tristate "Xilinx CSI2 Rx Subsystem"
> > +       depends on VIDEO_XILINX
> > +       help
> > +         Driver for Xilinx MIPI CSI2 Rx Subsystem. This is a V4L sub-device
> > +         based driver that takes input from CSI2 Tx source and converts
> > +         it into an AXI4-Stream. It has a DPHY (whose register interface
> > +         can be enabled, an optional I2C controller and an optional Video
> 
> 	    can be enabled),
> 

Noted. I will update in next revision of patch.

> > +         Format Bridge which converts the AXI4-Stream data to Xilinx Video
> > +         Bus formats based on UG934. The driver is used to set the number
> > +         of active lanes and get short packet data.
> > +
> >  config VIDEO_XILINX_TPG
> >         tristate "Xilinx Video Test Pattern Generator"
> >         depends on VIDEO_XILINX
> 
> 
> 
> > This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be proprietary,
> privileged or copyrighted under applicable law. If you are not the intended
> recipient, do not read, copy, or forward this email message or any attachments.
> Delete this email message and any attachments immediately.
> 
> :(
> 

Sorry about that.
I will work with IT on getting this removed before sending v2 for the patches.

-- Vishal 

> --
> ~Randy
