Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA6FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44E724A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44E724A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeF2Rkq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:40:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:35495 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932377AbeF2Rkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:40:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 10:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,286,1526367600"; 
   d="scan'208";a="63241797"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2018 10:40:41 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.236]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.167]) with mapi id 14.03.0319.002;
 Fri, 29 Jun 2018 10:40:40 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?iso-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
        "Moore, Robert" <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: small dmesg regression in kernel 4.17.3
Thread-Topic: small dmesg regression in kernel 4.17.3
Thread-Index: AQHUDXdECkakmC0QWk2YYx3JQkkCHqR00vWAgAFqwbCAATTCgP///vFA
Date:   Fri, 29 Jun 2018 17:40:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB35FEC@ORSMSX110.amr.corp.intel.com>
References: <8837a9e2-e614-e2bf-ed32-6d49de4dd4ed@gmx.de>
 <CAHp75VcQbj7trhupZB7wUnt4QWbsqZZDa-1WvFnSD8ciMCYF6A@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB35DC6@ORSMSX110.amr.corp.intel.com>
 <3440214.eqW5gfvlOh@aspire.rjw.lan>
In-Reply-To: <3440214.eqW5gfvlOh@aspire.rjw.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjljMTZlNDEtYmEwOC00MTA1LTk2MDUtZmY3N2I2N2I3M2E3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZVcrV2tJdlBJZXNOYUI0N0pISVlGdkdkR0x5K0NQNWF0QWNpR05wNUlLMlFlTTVnYUhrZFgrQWw0a1wvZGU2dkEifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Friday, June 29, 2018 2:32 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Toralf Förster
> <toralf.foerster@gmx.de>; Moore, Robert <robert.moore@intel.com>; ACPI
> Devel Maling List <linux-acpi@vger.kernel.org>; Linux Kernel <linux-
> kernel@vger.kernel.org>; Guenter Roeck <linux@roeck-us.net>
> Subject: Re: small dmesg regression in kernel 4.17.3
> 
> On Friday, June 29, 2018 12:13:54 AM CEST Schmauss, Erik wrote:
> >
> > > -----Original Message-----
> > > From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> > > Sent: Wednesday, June 27, 2018 10:29 AM
> > > To: Toralf Förster <toralf.foerster@gmx.de>; Schmauss, Erik
> > > <erik.schmauss@intel.com>
> > > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Linux
> > > Kernel <linux- kernel@vger.kernel.org>
> > > Subject: Re: small dmesg regression in kernel 4.17.3
> > >
> > > +Cc: Erik
> > >
> > > On Tue, Jun 26, 2018 at 8:57 PM, Toralf Förster
> > > <toralf.foerster@gmx.de>
> > > wrote:
> > > > The attached dmesg contains non printable chars 0x01 33 around
> > > > "ACPI BIOS Error (bug): Could not resolve" which is a new issue
> > > > compared to the dmesg of 4.17.2
> > > >
> > > > System is a stable hardened Gentoo Linux at a ThinkPad T440s.
> > >
> > > I bet the below commit makes this.
> > >
> > > commit 2e78935d1e27d31955ad2dad4abe6c453cf669fd
> > > Author: Erik Schmauss <erik.schmauss@intel.com>
> > > Date:   Fri Jun 1 12:06:43 2018 -0700
> > >
> > >    ACPICA: AML parser: attempt to continue loading table after error
> > >
> > >
> > Hi Andy,
> >
> > > So, it does add leading '\n' which flushes buffers followed by
> > > printing the message you see. But, I'm guessing now, kernel adds a
> > > default level since it's going to dmesg which you can see as unprintable
> symbols.
> >
> > What do you mean by a default level?
> >
> > > Personally I'm not a fan of leading '\n':s since it brings more pain
> > > than fixing something. It has special meaning (flushing buffers) and
> > > many developers forget this.
> >
> > This leading '\n' made it in Linux kernel unintentionally. It was originally
> intended as a change for acpiexec and it makes the dmesg look strange. I'll send
> out a fix.
> 
> Which would be something like the patch below I suppose?

Yes, this is what I was thinking of

Thanks,

Erik
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] ACPICA: Drop leading newlines from error messages
> 
> Commit 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table
> after error) unintentionally added leading newlines to error messages emitted by
> ACPICA which caused unexpected things to be printed to the kernel log.  Drop
> these newlines (which effectively reverts the part of commit 5088814a6e93
> adding them).
> 
> Fixes: 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table
> after error)
> Reported-by: Toralf Förster <toralf.foerster@gmx.de>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/uterror.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/uterror.c
> =================================================================
> ==
> --- linux-pm.orig/drivers/acpi/acpica/uterror.c
> +++ linux-pm/drivers/acpi/acpica/uterror.c
> @@ -182,19 +182,19 @@ acpi_ut_prefixed_namespace_error(const c
>  	switch (lookup_status) {
>  	case AE_ALREADY_EXISTS:
> 
> -		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
> +		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
>  		message = "Failure creating";
>  		break;
> 
>  	case AE_NOT_FOUND:
> 
> -		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
> +		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
>  		message = "Could not resolve";
>  		break;
> 
>  	default:
> 
> -		acpi_os_printf("\n" ACPI_MSG_ERROR);
> +		acpi_os_printf(ACPI_MSG_ERROR);
>  		message = "Failure resolving";
>  		break;
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
