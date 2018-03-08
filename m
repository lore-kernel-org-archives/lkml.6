Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeCHHb6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 02:31:58 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:47022 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751107AbeCHHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 02:31:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GQAAAA5qBah2Oa6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmfygKjWWNeYICgRaHHY0MghUKhSoCgwohNBgBAgEBAQEBAQI?=
 =?us-ascii?q?BAhABAQEKCwkIKC6COCKCSgEBAQQ6PwwEAgEIEQQBAR8JByElCQgCBAENBQiEe?=
 =?us-ascii?q?QMVrXqEDAGDIA2BMIIdhTCCLoM8gy2CaoI+hWQEjW+MLzEJjTGDLY5rijKHFYE?=
 =?us-ascii?q?sHoILcIMSgkGBUAE2dwGKY4EXAQEB?=
X-IPAS-Result: =?us-ascii?q?A2GQAAAA5qBah2Oa6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mfygKjWWNeYICgRaHHY0MghUKhSoCgwohNBgBAgEBAQEBAQIBAhABAQEKCwkIK?=
 =?us-ascii?q?C6COCKCSgEBAQQ6PwwEAgEIEQQBAR8JByElCQgCBAENBQiEeQMVrXqEDAGDIA2?=
 =?us-ascii?q?BMIIdhTCCLoM8gy2CaoI+hWQEjW+MLzEJjTGDLY5rijKHFYEsHoILcIMSgkGBU?=
 =?us-ascii?q?AE2dwGKY4EXAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.47,440,1515477600";
   d="scan'208";a="1225842219"
X-DLP: DLP_GlobalPCIDSS
To: <kai.heng.feng@canonical.com>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>, <dvhart@infradead.org>, <andy@infradead.org>,
        <tiwai@suse.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 1/2] dell-led: Change dell-led.h to dell-common.h
Thread-Topic: [PATCH 1/2] dell-led: Change dell-led.h to dell-common.h
Thread-Index: AQHTtqzP7PbkVIWvQUuDHcRV+9vB7KPF8ZBg
Date: Thu, 8 Mar 2018 07:31:54 +0000
Message-ID: <50d4e281b7644399bc85aa16a1eacb8f@ausx13mpc124.AMER.DELL.COM>
References: <20180308071207.19850-1-kai.heng.feng@canonical.com>
In-Reply-To: <20180308071207.19850-1-kai.heng.feng@canonical.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w287W3WX005741

> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Thursday, March 8, 2018 3:12 PM
> To: mjg59@srcf.ucam.org; pali.rohar@gmail.com; dvhart@infradead.org;
> andy@infradead.org; Limonciello, Mario <Mario_Limonciello@Dell.com>;
> tiwai@suse.com
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; alsa-
> devel@alsa-project.org; Kai-Heng Feng <kai.heng.feng@canonical.com>
> Subject: [PATCH 1/2] dell-led: Change dell-led.h to dell-common.h
> 
> This header will be used for more than just led. Change it to a more
> generic name.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

> ---
>  drivers/platform/x86/dell-laptop.c          | 2 +-
>  include/linux/{dell-led.h => dell-common.h} | 4 ++--
>  sound/pci/hda/dell_wmi_helper.c             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename include/linux/{dell-led.h => dell-common.h} (61%)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index c52c6723374b..8ba820e6c3d0 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -29,7 +29,7 @@
>  #include <linux/mm.h>
>  #include <linux/i8042.h>
>  #include <linux/debugfs.h>
> -#include <linux/dell-led.h>
> +#include <linux/dell-common.h>
>  #include <linux/seq_file.h>
>  #include <acpi/video.h>
>  #include "dell-rbtn.h"
> diff --git a/include/linux/dell-led.h b/include/linux/dell-common.h
> similarity index 61%
> rename from include/linux/dell-led.h
> rename to include/linux/dell-common.h
> index 92521471517f..37e4b614dd74 100644
> --- a/include/linux/dell-led.h
> +++ b/include/linux/dell-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __DELL_LED_H__
> -#define __DELL_LED_H__
> +#ifndef __DELL_COMMON_H__
> +#define __DELL_COMMON_H__
> 
>  int dell_micmute_led_set(int on);
> 
> diff --git a/sound/pci/hda/dell_wmi_helper.c b/sound/pci/hda/dell_wmi_helper.c
> index 1b48a8c19d28..56050cc3c0ee 100644
> --- a/sound/pci/hda/dell_wmi_helper.c
> +++ b/sound/pci/hda/dell_wmi_helper.c
> @@ -4,7 +4,7 @@
>   */
> 
>  #if IS_ENABLED(CONFIG_DELL_LAPTOP)
> -#include <linux/dell-led.h>
> +#include <linux/dell-common.h>
> 
>  enum {
>  	MICMUTE_LED_ON,
> --
> 2.15.1
