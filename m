Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755205AbeDWNn6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:43:58 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:43375 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755010AbeDWNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:43:55 -0400
X-Google-Smtp-Source: AB8JxZq8dVJxLdayU7w3cvIpOiO4mMZOZbgDdmBIF9ub8opvZVuogJet+DKrcBaUmZMMD2x24aQJJLqUVdg7Hb0a30I=
MIME-Version: 1.0
In-Reply-To: <20180420094432.13133-2-kai.heng.feng@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com> <20180420094432.13133-2-kai.heng.feng@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Apr 2018 16:43:41 +0300
Message-ID: <CAHp75VdwtOS_B978JOXqWRnj611jMJyN7BxFr+qu+Ojdf07i2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] platform/x86: dell-*: Add interface for switchable
 graphics status query
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Takashi Iwai <tiwai@suse.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 12:44 PM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On some Dell platforms, there's a BIOS option "Enable Switchable
> Graphics". This information is useful if we want to do different things
> based on this value, e.g. disable unused audio controller that comes
> with the discrete graphics.

>  int dell_micmute_led_set(int on);
> +bool dell_switchable_gfx_is_enabled(void);

I would rather preserve existing API, i.e.
 - prototype int func(void), where return either state or negative error code.
 - naming: dell_switchable_gfx_get()

-- 
With Best Regards,
Andy Shevchenko
