Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBBPi4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:38:56 -0500
Received: from mout.web.de ([212.227.15.3]:46619 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751472AbeBBPiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:38:51 -0500
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] I2C-Nomadik: Adjustments for nmk_i2c_probe()
Message-ID: <97f41346-6abb-1c14-f536-ad12bbcb4c60@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mNYqlgDrg3crVRk5QOwDvUykcCRowajrJ33I7gjzYIU55zzslFR
 w5XFUwLq+2tHBYTX9wH1Cc97BRfZZJd41sm6JecqDXD7a9GgN2LnXaC7zgsicYrqtTcJqsI
 fOUG/lUsCt0EXn4W/8+4b7CKjqrecm3tpnsXuvF3IEiw1kNcdvWaoYvweQbJ2wt+vHHZUJJ
 CtoSlNjVnJpCOMN01MBoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OuulaQmdjzU=:kdfWCrb/CuI8WZtC8lTkBU
 M301bLGFoAQuRJ+o6+b6vv2DsKD3xV3aPzzVW2b4BUP9DgeVSwNXagw72lV0eKLoFhVODX1u8
 z+mgLtujuZNTj9edlLzwVl2s5ECHPE5IBNwvHXTsi1UMFEqNwUQuOhmCaMbO1u5EWy7uJk3uj
 HPRC3RZ8mmEvj8U/pHv9WjrQVtZ/qXXv6dLOJX2GPj28D2WIIvopv+7fsu+j6fRip9mhCjUni
 fzNAwQLYKxa/tBsI8UiZRjjGZpuTrKrrXxeBxAOh8bFxKHAoI5hxOGemtw8AaxGyB3kXHQLrZ
 8fd6G8HRzQ6EEP3jH7uXc1ksvmmoYoB4FAc7mUheuWN0/ZkRS5QWINGU1PupBgqvvVcDFylLB
 nOXp8YNFkX+b2qnoepCW97fMAdDae9qXml1GAUayJndRu1vCy3Vnqb3Wlpd41LSQX7+qirgos
 FLb4jy7g2z5rVHs+kIQWVsGVd4Ey4s+m5wigUYo/tcrdDcA6nxGUBbmJWTrbhSm/VCJ+KVL9K
 Jrrb+sk90ev+DjgF5O68Lbz/QBfplOgt2AjjmI32nfwP5DuEHXq3Rmjufv3FR5mRJrhntBT96
 jVXvfxH8/zGvMnh/8TujoQozsJjomrMDcKeawTT09aETO0UaemgEgqELFnlpLI+Z6Cfv/Oxoe
 M8ODPsGrU50xV4dgVLQk7W9xCtIuAfuyD6qXUhepkcQbF6eP9cvvs5/Lreb7pfMHRk4aX/nBe
 BvGxpl3sU9W74UBuXXBRbzoitnN84nS9EJgIFXPBcbMKjVSsvJ83neO1+tg79X9Fclp7PPXog
 6VsuVqXavsACWzfz+AO6YVmjJTZkH8AcDG68ewpvOG+JQ9jrag=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 16:34:56 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-nomadik.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.16.1
