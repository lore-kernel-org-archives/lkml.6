Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbeDBQcz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:32:55 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49074 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbeDBQcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:32:53 -0400
Date: Mon, 2 Apr 2018 18:32:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, Mark Brown <broonie@kernel.org>,
        linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [v3,4/4] watchdog: add Gateworks System Controller support
Message-ID: <20180402163242.GC14165@lunn.ch>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net>
 <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
 <20180330181954.GA17580@roeck-us.net>
 <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The 'use case' we have been using this in for a couple years is that
> users who want to use this watchdog will enable it externally (we have
> a command in the bootloader) and if enabled the kernel driver (that
> I'm proposing here which we've been using out-of-tree) will register
> the watchdog device and the userspace watchdog process can open the
> device and start tickling it. If the watchdog is never enabled (or
> disabled via the bootloader command) the kernel driver fails to probe
> and the SoC's watchdog can be used.

Hi Tim

Is there any reason not to give the user the choice to use both
watchdogs? Normally you write drivers to expose the hardware, and then
let the users choice if they want to use it.

	Andrew
