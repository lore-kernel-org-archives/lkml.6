Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeEHPiW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 11:38:22 -0400
Received: from mail-bl2nam02on0048.outbound.protection.outlook.com ([104.47.38.48]:22624
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755113AbeEHPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 11:38:18 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Thread-Topic: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
Thread-Index: AQHT5exoi/22xDkBE0+o4Ny8pzDRlKQkzTYAgABqFoCAAMGUEA==
Date: Tue, 8 May 2018 15:38:14 +0000
Message-ID: <BN6PR12MB18094F5327A8DA2F560383E6F79A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
 <1525688013-9928-2-git-send-email-akshu.agrawal@amd.com>
 <BN6PR12MB1809A66A78024F2E519A1A34F79B0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <82d294fc-d108-a32a-1ada-2763f40dac01@amd.com>
In-Reply-To: <82d294fc-d108-a32a-1ada-2763f40dac01@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com;
x-originating-ip: [76.1.164.143]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1138;7:+khmTbOtac3sBiLER+/u3ww1FW0jGYWEpsilv6G7ObNPicNL5eVANFg2NaMRWqd8mSpub+dJBH9j5aE/pdBb9BOCcr+zMV+5kHrcnzHN8pTYfGcvUJAW+bLeXAsTry5FjffUuE+5SB4E/EqngtZBghgR4hm/28uJ/XFJYK/AApPu19wbm+PFzEMfJN9F0Kh6SZWY9VrssNevhoXrnJ+1sBw8hQI9ZeBRqsFTkvXjQSDoNCAq+gPjvROrQD8FBsN1;20:eBpjN0VqLh5i7zp+MxFIXvxE0/kBHdiD9+LHqtc7Z/4dgla2SMf/xc3r9X142vJmj8ana7XYY1M+fWJsoVOQL68EvJEXzQdwLccxZl8rYC9bsO6eISlwPlOukzfFZZcL9Y7DWRcvpz10y6qxwPU2Co9LmizKIkGnt3ryHLGupPd22KjaQ03ujhlnyV2q3vk9gPjxTHTUo4tvIRiDiogBNm+QCMUNEN8kFlXcYqkcdv1IR5bqnz2vsduoDoLcnUNU
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(189003)(13464003)(199004)(486006)(3280700002)(476003)(3660700001)(11346002)(97736004)(86362001)(66066001)(6636002)(229853002)(6436002)(478600001)(25786009)(72206003)(105586002)(106356001)(14454004)(5250100002)(446003)(33656002)(81166006)(81156014)(8676002)(4326008)(9686003)(59450400001)(3846002)(6116002)(54906003)(93886005)(76176011)(53936002)(99286004)(6862004)(68736007)(8936002)(2900100001)(26005)(6506007)(55016002)(102836004)(316002)(53546011)(5660300001)(7696005)(6246003)(305945005)(7736002)(2906002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1138;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1138;
x-ms-traffictypediagnostic: BN6PR12MB1138:
x-microsoft-antispam-prvs: <BN6PR12MB1138C56E869E3A965E2EA0D9F79A0@BN6PR12MB1138.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1138;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1138;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: xEqPPgyVEPIoO+9tOgG4lGIJ9OmGkxWTF8Mr3VdHLQnfa79RRHY1aPhUoANootJ7a+hspV09b45kMoVvoxeyXPG+9tC2s+EVUZ/x//tvk2i2S+/ND45YRNGNoAV1cZ+lAnKtEkKbw6Y5cdaWcu+a8xdHsTVMqPZ/7LUqIQoEI20fr/JdtvYEYygoynm8ZVhc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fdf65d9c-24d4-4aab-67df-08d5b4f9b6cc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf65d9c-24d4-4aab-67df-08d5b4f9b6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 15:38:14.7936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w48FcSUN023280

> -----Original Message-----
> From: Agrawal, Akshu
> Sent: Tuesday, May 8, 2018 12:04 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: djkurtz@chromium.org; mturquette@baylibre.com; sboyd@kernel.org;
> Koenig, Christian <Christian.Koenig@amd.com>; airlied@redhat.com; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
> acpi@vger.kernel.org
> Subject: Re: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
> 
> 
> 
> On 5/8/2018 3:14 AM, Deucher, Alexander wrote:
> >> -----Original Message-----
> >> From: Agrawal, Akshu
> >> Sent: Monday, May 7, 2018 6:14 AM
> >> Cc: djkurtz@chromium.org; Agrawal, Akshu <Akshu.Agrawal@amd.com>;
> >> Deucher, Alexander <Alexander.Deucher@amd.com>;
> >> mturquette@baylibre.com; sboyd@kernel.org; Koenig, Christian
> >> <Christian.Koenig@amd.com>; airlied@redhat.com; Liu, Shaoyun
> >> <Shaoyun.Liu@amd.com>; linux-kernel@vger.kernel.org; linux-
> >> clk@vger.kernel.org; rjw@rjwysocki.net; lenb@kernel.org; linux-
> >> acpi@vger.kernel.org
> >> Subject: [PATCH v4 1/2] clk: x86: Add ST oscout platform clock
> >>
> >> Stoney SoC provides oscout clock. This clock can support 25Mhz and
> >> 48Mhz of frequency.
> >> The clock is available for general system use.
> >>
> >> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> >> ---
> >> v2: config change, added SPDX tag and used clk_hw_register_.
> >> v3: Fix kbuild warning for checking of NULL pointer
> >> v4: unregister clk_hw in driver remove, add .suppress_bind_attrs
> >>  drivers/clk/x86/Makefile             |  3 +-
> >>  drivers/clk/x86/clk-st.c             | 85
> >> ++++++++++++++++++++++++++++++++++++
> >>  include/linux/platform_data/clk-st.h | 17 ++++++++
> >>  3 files changed, 104 insertions(+), 1 deletion(-)  create mode
> >> 100644 drivers/clk/x86/clk-st.c  create mode 100644
> >> include/linux/platform_data/clk-st.h
> >>
> >> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> >> index 1367afb..00303bc 100644
> >> --- a/drivers/clk/x86/Makefile
> >> +++ b/drivers/clk/x86/Makefile
> >> @@ -1,3 +1,4 @@
> >> +obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
> >> +obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)	+= clk-st.o
> >>  clk-x86-lpss-objs		:= clk-lpt.o
> >>  obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
> >> -obj-$(CONFIG_PMC_ATOM)		+= clk-pmc-atom.o
> >> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c new
> >> file mode
> >> 100644 index 0000000..8a7795c
> >> --- /dev/null
> >> +++ b/drivers/clk/x86/clk-st.c
> >> @@ -0,0 +1,85 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >
> > Should this be MIT?  The original license was MIT.
> >
> > Alex
> >
> 
> We are adding SPDX tag, while license remains same GPL-2.0
> 
> What I have read is this is "to provide license identifiers inside the source
> code that could be easily parsed by machines and would allow checking for
> license compliance of an open source project easier."

My point as just that the original license on the file that you first sent out was MIT so the SPDX tag should be MIT rather than GPL.  E.g.,
SPDX-License-Identifier: MIT

Alex
