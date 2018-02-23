Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeBWPUr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:20:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:27237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeBWPUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:20:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="36923949"
Message-ID: <1519399242.10722.112.camel@linux.intel.com>
Subject: Re: [PATCH] Revert "gpio: winbond: fix ISA_BUS_API dependency"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org
Date: Fri, 23 Feb 2018 17:20:42 +0200
In-Reply-To: <CAK8P3a3-NTzY3x5xM_d8Bxm-s+SF0L8d60vd-FOHccVxXo_AVg@mail.gmail.com>
References: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
         <CAK8P3a3-NTzY3x5xM_d8Bxm-s+SF0L8d60vd-FOHccVxXo_AVg@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 16:19 +0100, Arnd Bergmann wrote:
> On Fri, Feb 23, 2018 at 3:55 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:


>  I would really like to avoid mixing
> 'select' and 'depends on' here, as that will likely cause other
> circular
> dependencies in the future.

Agree. And it doesn't make sense to do in a separate changes.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
