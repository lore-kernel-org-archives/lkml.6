Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeBVNSV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:18:21 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36620 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753702AbeBVNSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:18:18 -0500
X-Google-Smtp-Source: AH8x224SGPVrmTQ9OIUTGBm1sAQU2MQVHPUIMGtiPiwwMYpmHjCj0mTYPcy01sIk1qZ0dqp3qkQ6nMJLMaYH1+ftyZQ=
MIME-Version: 1.0
In-Reply-To: <cover.1519231939.git.gdouezangrard@gmail.com>
References: <cover.1519231939.git.gdouezangrard@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 15:18:17 +0200
Message-ID: <CAHp75VcAta71FBqkwq9hVCCK3WnCT3SJimxcp9Tm6ynfy3a6Hw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Topstar U931/RVP7 ACPI LED Workaround
To: =?UTF-8?Q?Guillaume_Dou=C3=A9zan=2DGrard?=
        <gdouezangrard@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MDIP6o023837

On Wed, Feb 21, 2018 at 6:59 PM, Guillaume Douézan-Grard
<gdouezangrard@gmail.com> wrote:
> Hi Andy,
>
> Thank you for your review. Changes since the previous submission are
> highlighted below.
>
> On Topstar U931/RVP7 Notebooks, an issue prevents the WLAN toggle key
> from being properly managed by the Embedded Controller and successfully
> disconnect the adapter. A specific ACPI method allows to toggle the WLAN
> LED state regardless.
>
> Based on a DMI check, the LED is registered within the corresponding
> subsystem, making possible to use a software-based trigger (rfkill for
> instance, to synchronize the LED with the network interface state).
>
> Thank you for your time,

All pushed to my review and testing queue, thanks!

>
> --
> Guillaume Douézan-Grard
>
>
> Changes since v4:
>
> * move module description comment change from patch 5 to 4,
> * fix SDPX identifiers mismatch.
>
>
> Changes since v3:
>
> * fix revert commit message format and wrapping,
> * update module description while actually doing the changes,
> * switch to SDPX identifiers.
>
>
> Changes since v2:
>
> * revert an older conversion from a generic module to an acpi driver
> module instead of undoing it manually,
> * separate commits for the renaming and the spliting phases,
> * DMI-based check instead of a module parameter,
> * copyright and minor fixes put at the end.
>
>
> Changes since v1:
>
> * leave devices names unchanged for ABI compatibility,
> * fix label names,
> * separate module authors definition,
> * add commit description to Patch 3.
>
>
> Guillaume Douézan-Grard (7):
>   platform/x86: topstar-laptop: revert "convert to module_acpi_driver()"
>   platform/x86: topstar-laptop: use consistent naming scheme
>   platform/x86: topstar-laptop: split ACPI events and input handling
>   platform/x86: topstar-laptop: add platform device
>   platform/x86: topstar-laptop: add Topstar U931/RVP7 WLAN LED
>     workaround
>   platform/x86: topstar-laptop: update copyright and fix some comments
>   platform/x86: topstar-laptop: replace licence text with SPDX tag
>
>  drivers/platform/x86/Kconfig          |   2 +
>  drivers/platform/x86/topstar-laptop.c | 363 +++++++++++++++++++++++++++-------
>  2 files changed, 291 insertions(+), 74 deletions(-)
>
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
