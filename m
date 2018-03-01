Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966721AbeCAJOv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:14:51 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:40353 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966601AbeCAJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:14:48 -0500
X-Google-Smtp-Source: AG47ELv8BDYQXXzrDZjIMUfcfUTwxhRMbpAJ9uuDn4Q8v7/P0+cTpMXeOLUVNTPaZtibUZC3xI6WplvF58/Lm/1L/GE=
MIME-Version: 1.0
In-Reply-To: <20180212085314.23014-1-linus.walleij@linaro.org>
References: <20180212085314.23014-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 10:14:47 +0100
Message-ID: <CACRpkdanbnodBa335hM5DYpgeW-6pU_oB_vbbUSxR2wRS6FPsw@mail.gmail.com>
Subject: Re: [PATCH 1/3] extcon: gpio: Localize platform data
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mike Lockwood <lockwood@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 9:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Nothing in the entire kernel #includes <linux/extcon/extcon-gpio.h>
> so move the platform data declaration inside of the driver.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

No reply on these patches so far,
if you prefer I can just apply them to the GPIO
tree.

Yours,
Linus Walleij
