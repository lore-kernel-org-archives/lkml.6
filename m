Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935570AbeBUQZN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:25:13 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:39142 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbeBUQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:25:11 -0500
X-Google-Smtp-Source: AH8x2248AEUdRxJk/5O2piSN4Du+8a6jpBep2ySCfjcVe6bdTIN5FlEnw5vYqCOrQoX83CLfXgQg3l1dreISh4GrEXw=
MIME-Version: 1.0
In-Reply-To: <4ba9dc3045e997d3e07218c80ed20591137cdc41.1519228823.git.gdouezangrard@gmail.com>
References: <cover.1519228823.git.gdouezangrard@gmail.com> <4ba9dc3045e997d3e07218c80ed20591137cdc41.1519228823.git.gdouezangrard@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 18:25:10 +0200
Message-ID: <CAHp75VcQ+u6knQp=85y=BbFX5CmN47woxkqx1RsUrhJwwZdHuw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] platform/x86: topstar-laptop: add Topstar
 U931/RVP7 WLAN LED workaround
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LGPHVv008340

On Wed, Feb 21, 2018 at 6:10 PM, Guillaume Douézan-Grard
<gdouezangrard@gmail.com> wrote:
> Topstar U931 laptops provide a LED synced with the WLAN adapter
> hard-blocking state. Unfortunately, some models seem to be defective,
> making impossible to hard-block the adapter with the WLAN switch and
> thus the LED is useless.
>
> An ACPI method is available to programmatically control this switch and
> it indirectly allows to control the LED.
>
> This commit registers the LED within the corresponding subsystem, making
> possible for instance to use an rfkill-based trigger to synchronize the
> LED with the device state.
>
> This workaround is enabled automatically for Topstar U931/RVP7 laptops
> based on a DMI check.

> - * ACPI driver for Topstar notebooks (hotkeys support only)
> + * Topstar Laptop ACPI Extras driver

Nope.
I think it's previous one.

-- 
With Best Regards,
Andy Shevchenko
