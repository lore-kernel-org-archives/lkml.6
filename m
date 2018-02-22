Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeBVR2Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:28:16 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46423 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbeBVR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:28:05 -0500
X-Google-Smtp-Source: AH8x224qmhYTkFLS8+Wd9obrR/5i8DO+qUH4tEQJajv2rd6Wo1TfKozU3RgtKmsW6XquaRP3nX51YhwIxRwUCLGPbOg=
MIME-Version: 1.0
In-Reply-To: <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com> <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 19:28:03 +0200
Message-ID: <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] pwm: add PWM modes
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>, kgene@kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        kamil@wypas.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, milo.kim@ti.com,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hwmon@vger.kernel.org, linux-input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 2:01 PM, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
> Add PWM normal and complementary modes.

> +- PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
> +channels two outputs); if not specified, the default for PWM channel will
> +be used

What DT stands for?

-- 
With Best Regards,
Andy Shevchenko
