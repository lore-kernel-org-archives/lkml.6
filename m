Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeBGB6v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:58:51 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:48402 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751558AbeBGB6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:58:49 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FsAQApXHpah8mZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQngQAyg1uYVZtiCoU7AhqCQlgUAQEBAQEBAQECAQIQAQEBCgs?=
 =?us-ascii?q?JCCgvgjgigksGIxFFEAIBCBoCJgICAkUQAgQODYots1iCJ4h4ggoBAQgBAQEBA?=
 =?us-ascii?q?SOBD4NbghWDP4MuhQZogkuCZQWkLowdiU6CDgGSNpgAgTw2gXNwgxmCZIISjWi?=
 =?us-ascii?q?BFwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FsAQApXHpah8mZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ngQAyg1uYVZtiCoU7AhqCQlgUAQEBAQEBAQECAQIQAQEBCgsJCCgvgjgigksGI?=
 =?us-ascii?q?xFFEAIBCBoCJgICAkUQAgQODYots1iCJ4h4ggoBAQgBAQEBASOBD4NbghWDP4M?=
 =?us-ascii?q?uhQZogkuCZQWkLowdiU6CDgGSNpgAgTw2gXNwgxmCZIISjWiBFwEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.46,471,1511848800";
   d="scan'208";a="1095816040"
X-DLP: DLP_GlobalPCIDSS
To: <andy.shevchenko@gmail.com>
CC: <andriy.shevchenko@linux.intel.com>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>, <acelan.kao@canonical.com>,
        <linux-kernel@vger.kernel.org>, <pali.rohar@gmail.com>,
        <rjw@rjwysocki.net>
Subject: RE: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Thread-Topic: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
Thread-Index: AQHTmsD+s/l7/GkRX0mynZ6Nxv0e5aOO5nIAgAeCdoCAAXSPUIAAh90A///SwVA=
Date: Wed, 7 Feb 2018 01:57:12 +0000
Message-ID: <cb4a91870ca24f2487302de05ce8d7f5@ausx13mpc120.AMER.DELL.COM>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com>
 <20180131213726.GB21498@fury> <1517847491.22495.36.camel@linux.intel.com>
 <c51e36664a6e4df6b641f3c684b0d189@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VeFSuQYu67DdnJDjZDoaLZiPuo7ag7Lz0q6eSCDjayobw@mail.gmail.com>
In-Reply-To: <CAHp75VeFSuQYu67DdnJDjZDoaLZiPuo7ag7Lz0q6eSCDjayobw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w171wtrH028650

>Yeah, that's fixed in the branch.
>P.S. Apologies for top-posting, wrote from phone in order to not waste time
Andy,

I tested your review branch on XPS 9365 which uses power button through 
intel-vbtn.  I confirmed it worked properly both with usage in OS and during S2I.

Thanks,
