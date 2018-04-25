Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeDYMFk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:05:40 -0400
Received: from bert.emutex.com ([91.103.1.109]:54674 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753040AbeDYMFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:05:37 -0400
Date: Wed, 25 Apr 2018 13:05:30 +0100
From: Javier Arteaga <javier@emutex.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 1/3] mfd: upboard: Add UP2 platform controller
 driver
Message-ID: <20180425120530.zxodrjx3r3i6aipu@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-2-javier@emutex.com>
 <20180425095141.GL2173@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425095141.GL2173@lahna.fi.intel.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Mika, On Wed, Apr 25, 2018 at 12:51:41PM +0300, Mika Westerberg
    wrote: > On Sat, Apr 21, 2018 at 09:50:07AM +0100, Javier Arteaga wrote:
   > > +static const struct acpi_device_id upboard_acpi_match[] = { > > + { "AANT0F01",
    (kernel_ulong_t) &upboard_up2_data }, > > No space after cast so write it
    like, > > { "AANT0F01", (kernel_ulong_t)&upboard_up2_data }, [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On Wed, Apr 25, 2018 at 12:51:41PM +0300, Mika Westerberg wrote:
> On Sat, Apr 21, 2018 at 09:50:07AM +0100, Javier Arteaga wrote:
> > +static const struct acpi_device_id upboard_acpi_match[] = {
> > +	{ "AANT0F01", (kernel_ulong_t) &upboard_up2_data },
> 
> No space after cast so write it like,
> 
> 	{ "AANT0F01", (kernel_ulong_t)&upboard_up2_data },

> > +	upboard_data = (const struct upboard_data *) id->driver_data;
> 
> Ditto and to other places.

Thanks! I've fixed it for the next series now.

Actually, checkpatch did not catch this one, and I can't see an explicit
mention to this rule in coding-style.rst either. Is this worth sending a
patch to the style guide?

> Otherwise looks good to me.

Thanks for your review!
