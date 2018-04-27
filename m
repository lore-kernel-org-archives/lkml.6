Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeD0SBS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:01:18 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:47444 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751456AbeD0SBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:01:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EiAAA8ZONamMmZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQkeigKi2OMejSBQIEPjnqEGhSBZAsjC4Q+AoJPITQYAQIBAQE?=
 =?us-ascii?q?BAQECAQECEAEBAQEBCAsLBigjDII1IhFLXAEBAQEBASMCDWMBAQEEOj8MBAIBC?=
 =?us-ascii?q?BEEAQEBHgkHRgkIAgQBDQUIhQcPqzKIRoI3iBSCE4EPgwuCeoFGARIBhXMCmA0?=
 =?us-ascii?q?IhWSIXoF5imQriRGGfoElHIEacXBQgjMBDwmCJRqISIU+bwGPA4EfgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EiAAA8ZONamMmZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?keigKi2OMejSBQIEPjnqEGhSBZAsjC4Q+AoJPITQYAQIBAQEBAQECAQECEAEBA?=
 =?us-ascii?q?QEBCAsLBigjDII1IhFLXAEBAQEBASMCDWMBAQEEOj8MBAIBCBEEAQEBHgkHRgk?=
 =?us-ascii?q?IAgQBDQUIhQcPqzKIRoI3iBSCE4EPgwuCeoFGARIBhXMCmA0IhWSIXoF5imQri?=
 =?us-ascii?q?RGGfoElHIEacXBQgjMBDwmCJRqISIU+bwGPA4EfgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.49,336,1520917200";
   d="scan'208";a="244871428"
X-DLP: DLP_GlobalPCIDSS
To: <rdunlap@infradead.org>, <lkp@intel.com>
CC: <kbuild-all@01.org>, <linux-kernel@vger.kernel.org>,
        <dvhart@infradead.org>
Subject: RE: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
 `wmidev_evaluate_method'
Thread-Topic: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference
 to `wmidev_evaluate_method'
Thread-Index: AQHT3i3sh0zIZXVVT0SZUwjAGbezUKQVOWUA//+tgqA=
Date: Fri, 27 Apr 2018 18:01:14 +0000
Message-ID: <c354e68ba5f54d8e891631fae3cfa877@ausx13mpc120.AMER.DELL.COM>
References: <201804272139.CYzGSbEr%fengguang.wu@intel.com>
 <0ccd04a5-2461-61b3-93b1-90ca4e96440d@infradead.org>
In-Reply-To: <0ccd04a5-2461-61b3-93b1-90ca4e96440d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3RI1NIW009521

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: Friday, April 27, 2018 12:56 PM
> To: kbuild test robot; Limonciello, Mario
> Cc: kbuild-all@01.org; linux-kernel@vger.kernel.org; Darren Hart (VMware)
> Subject: Re: drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
> `wmidev_evaluate_method'
> 
> On 04/27/2018 06:43 AM, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   0644f186fc9d77bb5bd198369e59fb28927a3692
> > commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-
> smbios: Link all dell-smbios-* modules together
> > date:   7 weeks ago
> > config: x86_64-randconfig-b0-04271930 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/platform/x86/dell-smbios-wmi.o: In function `run_smbios_call':
> >>> drivers/platform/x86/dell-smbios-wmi.c:66: undefined reference to
> `wmidev_evaluate_method'
> >    drivers/platform/x86/dell-smbios-wmi.o: In function `dell_smbios_wmi_probe':
> >>> drivers/platform/x86/dell-smbios-wmi.c:157: undefined reference to
> `dell_wmi_get_descriptor_valid'
> >>> drivers/platform/x86/dell-smbios-wmi.c:167: undefined reference to
> `dell_wmi_get_size'
> >>> drivers/platform/x86/dell-smbios-wmi.c:171: undefined reference to
> `dell_wmi_get_hotfix'
> >>> drivers/platform/x86/dell-smbios-wmi.c:182: undefined reference to
> `set_required_buffer_size'
> >    drivers/platform/x86/dell-smbios-wmi.o: In function `init_dell_smbios_wmi':
> >>> drivers/platform/x86/dell-smbios-wmi.c:271: undefined reference to
> `__wmi_driver_register'
> >    drivers/platform/x86/dell-smbios-wmi.o: In function `exit_dell_smbios_wmi':
> >>> drivers/platform/x86/dell-smbios-wmi.c:276: undefined reference to
> `wmi_driver_unregister'
> >
> >
> > :::::: The code at line 66 was first introduced by commit
> > :::::: 1a258e670434f404a4500b65ba1afea2c2b29bba platform/x86: dell-smbios-
> wmi: Add new WMI dispatcher driver
> >
> > :::::: TO: Mario Limonciello <mario.limonciello@dell.com>
> > :::::: CC: Darren Hart (VMware) <dvhart@infradead.org>
> 
> Hi,
> 
> To anyone contemplating this build error, there is already a fix for it from
> Mario on 2018-04-20.  (Seems odd that the patch does not show up on
> https://patchwork.kernel.org/project/platform-driver-x86/list/ )
> 
> See lkml.kernel.org/r/1524246131-17621-1-git-send-email-
> mario.limonciello@dell.com
> 
> 
> --

I'm wondering if that is enough of a fix though.  This "new" build error is actually
with WMI stuff which might need adjusting too..?
