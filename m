Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755185AbeBOJLP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:11:15 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44390 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeBOJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:11:11 -0500
X-Google-Smtp-Source: AH8x226/r+8wP/TipQ3KSUTc/suK0pikoJbZt2Tk9BYwn6muCssieiyNJPk9dfj1yRpYzb4Z5I80VEOEl0OvN4EjuPU=
MIME-Version: 1.0
In-Reply-To: <20180209142318.14451-1-carlo@caione.org>
References: <20180209142318.14451-1-carlo@caione.org>
From: Carlo Caione <carlo@caione.org>
Date: Thu, 15 Feb 2018 09:11:10 +0000
X-Google-Sender-Auth: bryJDLTflxKILGzlrUMptk14_MI
Message-ID: <CAOQ7t2ZHisZRPq6tKL3QNuKWQFNpVpJ-DoPdM80jMx8u7J=fBg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
To: open list <linux-kernel@vger.kernel.org>
Cc: Linux Upstreaming Team <linux@endlessm.com>, bardliao@realtek.com,
        oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Carlo Caione <carlo@endlessm.com>, Hans De Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 9, 2018 at 2:23 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
> the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
> the rt5645 driver to enable the jack detection also on non-DT platforms.

Please do not merge this yet, I'll submit a V3 soon.
Hans pointed out that on some BayTrail there is indeed an extra GPIO
but it is used to enable the external speaker amplifier. Better to
guard this by a quirk.

Cheers,

-- 
Carlo Caione
