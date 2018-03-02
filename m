Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935958AbeCBGln convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:41:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:45114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935880AbeCBGlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:41:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="208289115"
From: "Ooi, Joyce" <joyce.ooi@intel.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Nguyen, Dinh" <dinh.nguyen@intel.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>,
        "Ong, Hean Loong" <hean.loong.ong@intel.com>
Subject: RE: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
Thread-Topic: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
Thread-Index: AQHTpgxYeKG0yfkbQk6YdYrvrI0hPaO8Y6+g
Date: Fri, 2 Mar 2018 06:41:38 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C0450754EA0A@PGSMSX101.gar.corp.intel.com>
References: <1518664828-30883-1-git-send-email-joyce.ooi@intel.com>
In-Reply-To: <1518664828-30883-1-git-send-email-joyce.ooi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGQ5NWFkOGQtMzI3OC00NjdiLWI4YTYtY2E5OWI1YmMzNzQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJpXC9XWFRobUpTOTlNT0RERUZsQWZMVFhacDltbDF1d3hKemxRZXB0M293SXM1NkNHRCtzUFhUV0N6OUhlSmtFdCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It's been a while since I received any feedback about this patch. Are there any concerns about this patch? If no, could you please kindly ACK this patch?

Thanks.

Regards,
Joyce Ooi

> -----Original Message-----
> From: Ooi, Joyce
> Sent: Thursday, February 15, 2018 11:20 AM
> To: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; Nguyen, Dinh <dinh.nguyen@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ooi,
> Joyce <joyce.ooi@intel.com>; Vandervennet, Yves
> <yves.vandervennet@intel.com>; Ong, Hean Loong
> <hean.loong.ong@intel.com>
> Subject: [PATCH] arm64: defconfig: enable CONFIG_LEDS_TRIGGER_TIMER
> 
> Enable LED timer trigger for ARM64 to allow LEDs to be controlled via sysfs.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  arch/arm64/configs/defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 634b373..b728742 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -471,6 +471,8 @@ CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_PWM=y
>  CONFIG_LEDS_SYSCON=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_LEDS_TRIGGER_CPU=y
>  CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> --
> 1.7.1
