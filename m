Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeFELAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:00:44 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:22121
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751386AbeFELAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:00:42 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v4 8/8] Documentation/ABI: Add documentation mlxreg-io
 sysfs interfaces
Thread-Topic: [PATCH v4 8/8] Documentation/ABI: Add documentation mlxreg-io
 sysfs interfaces
Thread-Index: AQHT9xsmezeSaJ2pOUmbBzal9TgKEKRQ8iMAgACXbNA=
Date: Tue, 5 Jun 2018 11:00:38 +0000
Message-ID: <HE1PR0502MB3753C857729A06149F5EE35BA2660@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1527584347-167548-1-git-send-email-vadimp@mellanox.com>
 <1527584347-167548-3-git-send-email-vadimp@mellanox.com>
 <20180605015444.GB47042@localhost.localdomain>
In-Reply-To: <20180605015444.GB47042@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3707;7:Kb7c7N9XgQShF4Te8SHruvgiY3pn6JfU6jxVIoZgFF23J3/YCApTeAuHTHBynSTyDTLX/0WyjSHGBC8KqMHXlAFoaY+vBucCG/RDNN0UezATfyGNWQnwQVuFhzHP0grWSVnzPb3V/rbB2pV7Pz7a+5JvKlpLXVCXG0I/x/8dgv0FIZDy3ygqW8dXmbz15UkANPal/+MNzpIEV9Vn/RAkJtj/M8bvya+D7FYJSbZTBf0TJ9gQrfAglMMpAIJqSgTg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3707;
x-ms-traffictypediagnostic: HE1PR0502MB3707:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-microsoft-antispam-prvs: <HE1PR0502MB3707E561261600B06043CE00A2660@HE1PR0502MB3707.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(9452136761055)(85827821059158)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB3707;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3707;
x-forefront-prvs: 0694C54398
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(39860400002)(346002)(376002)(13464003)(50944005)(199004)(189003)(81166006)(81156014)(476003)(4326008)(97736004)(66066001)(8676002)(54906003)(76176011)(7696005)(6506007)(6436002)(7736002)(53546011)(305945005)(316002)(59450400001)(86362001)(2906002)(106356001)(74316002)(102836004)(229853002)(486006)(99286004)(5250100002)(8936002)(3280700002)(3660700001)(5660300001)(3846002)(68736007)(6916009)(6116002)(55016002)(446003)(33656002)(186003)(11346002)(105586002)(26005)(9686003)(25786009)(39060400002)(478600001)(2900100001)(6246003)(345774005)(53936002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3707;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZGkgRAuEXadMoCYBqOXtrY+Mweijfji/rBC8maqPUUtLaWpjIjEePhR8ahz169qpxuQSuy/S6pygMtTIBoGVqH4P5tydNImGFw95pPs1e8HolN41tog7cfaTLGb9xcXyz35Lk9Rdq8gnYjJ7ImBCmh8eY52MBUducv8CbJdGiYGSwZ62l4hG1hVJaXr158vR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9d45cdb2-c692-4198-1756-08d5cad39230
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d45cdb2-c692-4198-1756-08d5cad39230
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 11:00:38.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3707
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55B0noe004143



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Tuesday, June 05, 2018 4:55 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnulli.us;
> Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v4 8/8] Documentation/ABI: Add documentation mlxreg-io
> sysfs interfaces
> 
> On Tue, May 29, 2018 at 08:59:07AM +0000, Vadim Pasternak wrote:
> > Add documentation for mlxreg-io driver sysfs interfaces for user space
> > access to system's power resets control, reset causes monitoring,
> > programmable devices version reading and devices selection control.
> >
> > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> 
> Hi Vadim,
> 
> You mentioned that these can vary by platform, I presume that means that any
> given platform will present a subset of these attributes - but that all possible
> attributes are documented here. Is that correct?

Hi Darren,

Thank you for review.
These are mostly all attributes, that should be exposed.
I add two extra for the coming version.

Maybe for the future system it could be slightly extended.

Also we have writable attribute for BIOS flash boot selection, which
I am still not sure we want expose.

Thanks,
Vadim.

> 
> > ---
> > v4:
> >  Comments pointed out by Greg:
> >  Add Documentation/ABI/ entries for the new sysfs files.
> > ---
> >  Documentation/ABI/stable/sysfs-driver-mlxreg-io | 51
> > +++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/ABI/stable/sysfs-driver-mlxreg-io
> >
> > diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> > b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> > new file mode 100644
> > index 0000000..fcd659e
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> > @@ -0,0 +1,51 @@
> > +What:		/sys/devices/platform/mlxplat/mlxreg-
> io/hwmon/hwmon*/
> > +
> 	cause_aux_pwr_or_ref
> > +							cause_asic_thermal
> > +
> 	cause_hotswap_or_wd
> > +							cause_fw_reset
> > +							cause_long_pb
> > +							cause_main_pwr_fail
> > +							cause_short_pb
> > +							cause_sw_reset
> 
> These property names do not seem to follow any kind of logical pattern with
> respect to abbreviation. Starting with "cause_" made me think they were event
> generators at first... Of course, who wants to be able to generate an asic
> thermal shutdown from sysfs... ;-)
> 
> The only thing that might make more sense to *me* would be to replace
> "cause" with "reset". Not required. I'll leave it to you, you may have good
> reason for the names chosen.
> 
> > +Date:		May 2018
> > +KernelVersion:	4.18
> > +Contact:	Vadim Pasternak <vadimpmellanox.com>
> > +Description:	These files show the system reset cause, as following: power
> > +		auxiliary outage or power refresh, ASIC thermal shutdown,
> > +		hotswap or watchdog, firmware reset, long press power
> button,
> > +		short press power button, software reset. Value 1 in file means
> > +		this is reset cause, 0 - otherwise. Only one of the above
> > +		causes could be 1 at the same time, representing only last
> > +		reset cause.
> > +
> > +		The files are read only.
> > +
> > +What:		/sys/devices/platform/mlxplat/mlxreg-
> io/hwmon/hwmon*/
> > +							cpld1_version
> > +							cpld2_version
> > +Date:		May 2018
> > +KernelVersion:	4.18
> > +Contact:	Vadim Pasternak <vadimpmellanox.com>
> > +Description:	These files show with which CPLD versions have been burned
> > +		on carrier and switch boards.
> > +
> > +		The files are read only.
> > +
> > +What:		/sys/devices/platform/mlxplat/mlxreg-
> io/hwmon/hwmon*/select_iio
> > +Date:		May 2018
> > +KernelVersion:	4.18
> > +Contact:	Vadim Pasternak <vadimpmellanox.com>
> > +Description:	This file allows iio devices selection.
> > +
> > +		The file is read/write.
> > +
> 
> Some description is appropriate here for what values it accepts and how it is
> intended to be used.
> 
> > +What:		/sys/devices/platform/mlxplat/mlxreg-
> io/hwmon/hwmon*/psu1_on
> > +		/sys/devices/platform/mlxplat/mlxreg-
> io/hwmon/hwmon*/psu2_on
> > +		/sys/devices/platform/mlxplat/mlxreg-
> io/hwmon/hwmon*/pwr_cycle
> > +Date:		May 2018
> > +KernelVersion:	4.18
> > +Contact:	Vadim Pasternak <vadimpmellanox.com>
> > +Description:	These files allow assert system's power cycling and PS units
> > +		on/off switching.
> 
> This Description is awkward. Consider:
> 
> These files allow asserting system power cycling and switching power supply
> units on and off.
> 
> > +		The files are write only.
> 
> Please provide usage and resulting behavior.
> 
> --
> Darren Hart
> VMware Open Source Technology Center
