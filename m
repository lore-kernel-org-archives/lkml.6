Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCIKTZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:19:25 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:9820 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeCIKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:19:23 -0500
Subject: Re: [PATCH v2] ARM: davinci: fix the GPIO lookup for omapl138-hawk
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180301103448.27233-1-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <49351196-c0a6-8b4e-ccc9-68e81f652ca3@ti.com>
Date: Fri, 9 Mar 2018 15:48:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301103448.27233-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 March 2018 04:04 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
> mmc can correctly lookup the wp and cp gpios.
> 
> Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied for v4.16 with a note on the fact that the gpio-davinci
driver sets the chip label to davinci_gpio.0.

Thanks,
Sekhar

---8<---
ARM: davinci: fix the GPIO lookup for omapl138-hawk

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
mmc can correctly lookup the wp and cp gpios.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
[nsekhar@ti.com: add a note on where the chip label is set]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
