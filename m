Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755175AbeDTO3f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:29:35 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:37383 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754987AbeDTO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:29:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HmAAAu+NlamMmZ6ERcHQEBBQELAYQVg?=
 =?us-ascii?q?QgoCotijHaBdIEPkniBeAuEaQKCRiE0GAECAQEBAQEBAgEBAhABAQEBAQgLCwY?=
 =?us-ascii?q?oL4I1IoJNAQEBBDo0CwwEAgEIEQQBAQEeCQdGCQgCBAENBQiFBahuiD6CKYgGg?=
 =?us-ascii?q?hOEGoFBiQYCl3EIjjeMVpApgSUcggtwUIJDgi6OIG+OT4EYAQE?=
X-IPAS-Result: =?us-ascii?q?A2HmAAAu+NlamMmZ6ERcHQEBBQELAYQVgQgoCotijHaBdIE?=
 =?us-ascii?q?PkniBeAuEaQKCRiE0GAECAQEBAQEBAgEBAhABAQEBAQgLCwYoL4I1IoJNAQEBB?=
 =?us-ascii?q?Do0CwwEAgEIEQQBAQEeCQdGCQgCBAENBQiFBahuiD6CKYgGghOEGoFBiQYCl3E?=
 =?us-ascii?q?IjjeMVpApgSUcggtwUIJDgi6OIG+OT4EYAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.49,301,1520917200";
   d="scan'208";a="171509786"
X-DLP: DLP_GlobalPCIDSS
To: <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: linux-next: Tree for Apr 19 (dell smbios SMM)
Thread-Topic: linux-next: Tree for Apr 19 (dell smbios SMM)
Thread-Index: AQHT2AgwKJy6Z28GlkKE9Su24yAKO6QJt6TQ
Date: Fri, 20 Apr 2018 14:29:30 +0000
Message-ID: <43bec7e798f5491284d2c049f835d339@ausx13mpc120.AMER.DELL.COM>
References: <20180419143545.63c0c639@canb.auug.org.au>
 <6aec5528-d6f1-3e05-1ac2-6eddbd0ac64f@infradead.org>
In-Reply-To: <6aec5528-d6f1-3e05-1ac2-6eddbd0ac64f@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3KETfYv028560

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: Thursday, April 19, 2018 1:00 PM
> To: Stephen Rothwell; Linux-Next Mailing List
> Cc: Linux Kernel Mailing List; Platform Driver; Limonciello, Mario
> Subject: Re: linux-next: Tree for Apr 19 (dell smbios SMM)
> 
> On 04/18/18 21:35, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20180418:
> >
> 
> 
> I see some patches from about 1 month ago for this, but it was either
> never fixed ... or it's back.
> 
> 
> on x86_64:
> 
> WARNING: unmet direct dependencies detected for DELL_SMBIOS
>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y] && (DCDBAS [=m] ||
> DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
>   Selected by [y]:
>   - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && DMI [=y]
> && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
> && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]
> 
> 
> drivers/platform/x86/dell-smbios-smm.o: In function `dell_smbios_smm_call':
> dell-smbios-smm.c:(.text+0x7d): undefined reference to `dcdbas_smi_request'
> 
> 
> --
> ~Randy

Randy,

Would you mind posting your kernel config somewhere like a pastebin or github gist
so we can try to easily reproduce with your combination of configure options?

Thanks,
