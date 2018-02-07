Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeBGNIM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:08:12 -0500
Received: from esa4.dell-outbound.iphmx.com ([68.232.149.214]:34373 "EHLO
        esa4.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754016AbeBGNIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:08:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EeAQC/+Hpah2Ka6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQngQAoCoNbmEiCAokVkFUKhTsCGoJNWBQBAgEBAQEBAQIBAhA?=
 =?us-ascii?q?BAQEKCwkIKC+COCKCSgEBAQQjEUUMBAIBCBEEAQEBAgIjAwICAh8lAQgIAgQBD?=
 =?us-ascii?q?QUIihUDFbFsgieHOQ2BMYIKAQEBAQEBAQEBAQEBAQEBAQEBAQEBHYEPg2aCFYM?=
 =?us-ascii?q?/gy6Ca0QEgXYQI4JdgmUFo3Q1CZB0hH6CJ4Yni3mLEoMwiUiBPDaBc3BSgkaCZ?=
 =?us-ascii?q?YISeAGMfIEXAQEB?=
X-IPAS-Result: =?us-ascii?q?A2EeAQC/+Hpah2Ka6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ngQAoCoNbmEiCAokVkFUKhTsCGoJNWBQBAgEBAQEBAQIBAhABAQEKCwkIKC+CO?=
 =?us-ascii?q?CKCSgEBAQQjEUUMBAIBCBEEAQEBAgIjAwICAh8lAQgIAgQBDQUIihUDFbFsgie?=
 =?us-ascii?q?HOQ2BMYIKAQEBAQEBAQEBAQEBAQEBAQEBAQEBHYEPg2aCFYM/gy6Ca0QEgXYQI?=
 =?us-ascii?q?4JdgmUFo3Q1CZB0hH6CJ4Yni3mLEoMwiUiBPDaBc3BSgkaCZYISeAGMfIEXAQE?=
 =?us-ascii?q?B?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.46,473,1511848800";
   d="scan'208";a="1096115131"
X-DLP: DLP_GlobalPCIDSS
To: <pali.rohar@gmail.com>, <rjw@rjwysocki.net>
CC: <andy.shevchenko@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <dvhart@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <acelan.kao@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Thread-Topic: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Thread-Index: AQHTmsD+s/l7/GkRX0mynZ6Nxv0e5aOO5nIAgAeCdoCAAXSPUIAAh90AgAC2e4CAAAS7gIAAAhIA///Q1wA=
Date: Wed, 7 Feb 2018 13:08:08 +0000
Message-ID: <8d143fabe24f43de933dc60ce6480d00@ausx13mpc120.AMER.DELL.COM>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeFSuQYu67DdnJDjZDoaLZiPuo7ag7Lz0q6eSCDjayobw@mail.gmail.com>
 <2235169.mLvk2uMpgf@aspire.rjw.lan> <4289605.mKSTaFlacu@aspire.rjw.lan>
 <20180207095522.qhs2wns4goif76u3@pali>
In-Reply-To: <20180207095522.qhs2wns4goif76u3@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w17D8GKr003837

> -----Original Message-----
> From: Pali Rohár [mailto:pali.rohar@gmail.com]
> Sent: Wednesday, February 7, 2018 3:55 AM
> To: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; andriy.shevchenko@linux.intel.com;
> dvhart@infradead.org; platform-driver-x86@vger.kernel.org;
> acelan.kao@canonical.com; linux-kernel@vger.kernel.org
> Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI driver
> 
> On Wednesday 07 February 2018 10:47:57 Rafael J. Wysocki wrote:
> > BTW, please CC patches with ACPI material to linux-acpi.  They are less likely
> > to be overlooked by me then and the others on that list may have opinions on
> > them too.
> 
> Maybe we can update MAINTAINERS file for acpi based platform-x86 drivers
> to include linux-acpi list? Darren, Andy, any idea?
> 

I would also wonder if the intel-vbtn driver should still live in platform-x86 as it's
now pure ACPI driver with this change Andy proposed.

Btw Andy for your v2 with your fixups that were in your review branch feel free
to add:
Tested-by: Mario Limonciello <mario.limonciello@dell.com>

When you resubmit it.
