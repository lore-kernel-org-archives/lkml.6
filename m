Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F7BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6719C241A7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6719C241A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeGEGVn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:21:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:27309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeGEGVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:21:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 23:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,310,1526367600"; 
   d="scan'208";a="64550116"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2018 23:21:40 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 23:21:40 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 14:21:38 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
Thread-Topic: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
Thread-Index: AdQR2tXMedaVc6BRTZmr8NooN2rypwAAlMAA///NcID/+zc20A==
Date:   Thu, 5 Jul 2018 06:21:37 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D0E@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE91@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1C084@shsmsx102.ccr.corp.intel.com>
 <2029ee35-c1c6-86ab-8986-2d79eb5b4d8c@roeck-us.net>
In-Reply-To: <2029ee35-c1c6-86ab-8986-2d79eb5b4d8c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjFmODNhOWYtNDYwZi00MDM3LWE0YTktNmM3ZWY4NTYzZGI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiejJyVmtUWEpVSVlEbzlsRjBnM3JKXC9UTkhidE9UZmNFb0tSYmJhMmJvYjdlbTZmeDBUbWhwMU5DVE9jeVRTamcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roeck

Yes, this patch submitted more than 1 year ago in our internal tree, I just tested latest 4.18 kernel, even without this patch, there is no error.
So I am ok to reject this patch.

Thanks
Tim

-----Original Message-----
From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
Sent: Monday, July 2, 2018 9:17 PM
To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: change ITCO_WDT type from tristate to bool

On 07/02/2018 01:18 AM, Tian, Baofeng wrote:
> From: "Tian, Baofeng" <baofeng.tian@intel.com 
> <mailto:baofeng.tian@intel.com>>
> Subject: [PATCH] watchdog: change ITCO_WDT type from tristate to bool
> 
> tristate will allow kernel config it to M and build ko file, this will 
> cause build allmodconfig errors as necessary symbols have not been 
> exported.
> change it to bool, only allow config ITCO_WDT to yes/no.
> 
> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com 
> <mailto:baofeng.tian@intel.com>>

This works today. I don't see a point changing it, and I am wary doing so.
There are systems where the iTCO watchdog doesn't work (I own one of those), even though it instantiates, and I am wary of force-loading it.

Besides, you don't explain which "necessary symbols have not been exported".
I do not plan to spend time trying to find out what those symbols are, and why this would suddenly be a problem.

Guenter

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index 
> 9af07fd..f991e93 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1049,7 +1049,7 @@ config INTEL_MID_WATCHDOG
>          To compile this driver as a module, choose M here.
> 
>   config ITCO_WDT
> -     tristate "Intel TCO Timer/Watchdog"
> +     bool "Intel TCO Timer/Watchdog"
>        depends on (X86 || IA64) && PCI
>        select WATCHDOG_CORE
>        depends on I2C || I2C=n
> --
> 2.7.4
> 

