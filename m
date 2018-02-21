Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936726AbeBUQkB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:40:01 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33680 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeBUQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:39:57 -0500
X-Google-Smtp-Source: AH8x2250gKWQlJCjk1yCra96cEqX6m7GD77lM0giR1BLmwnmJQQe9scm7CiZ+VqMQvSZayAaF2a8rw==
Date: Wed, 21 Feb 2018 17:39:49 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] platform/x86: topstar-laptop: add Topstar
 U931/RVP7 WLAN LED workaround
Message-ID: <20180221163949.GA21098@localhost>
References: <cover.1519228823.git.gdouezangrard@gmail.com>
 <4ba9dc3045e997d3e07218c80ed20591137cdc41.1519228823.git.gdouezangrard@gmail.com>
 <CAHp75VcQ+u6knQp=85y=BbFX5CmN47woxkqx1RsUrhJwwZdHuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcQ+u6knQp=85y=BbFX5CmN47woxkqx1RsUrhJwwZdHuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 06:25:10PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 6:10 PM, Guillaume Douézan-Grard
> <gdouezangrard@gmail.com> wrote:
> > Topstar U931 laptops provide a LED synced with the WLAN adapter
> > hard-blocking state. Unfortunately, some models seem to be defective,
> > making impossible to hard-block the adapter with the WLAN switch and
> > thus the LED is useless.
> >
> > An ACPI method is available to programmatically control this switch and
> > it indirectly allows to control the LED.
> >
> > This commit registers the LED within the corresponding subsystem, making
> > possible for instance to use an rfkill-based trigger to synchronize the
> > LED with the device state.
> >
> > This workaround is enabled automatically for Topstar U931/RVP7 laptops
> > based on a DMI check.
> 
> > - * ACPI driver for Topstar notebooks (hotkeys support only)
> > + * Topstar Laptop ACPI Extras driver
> 
> Nope.
> I think it's previous one.

Previous one is still technically "hotkeys support only", but I'll
change this.

(and sorry for the license mismatch, I fix that right now...)

--
Guillaume Douézan-Grard
