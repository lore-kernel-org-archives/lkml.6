Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967111AbeBNKRC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:17:02 -0500
Received: from mout.web.de ([212.227.17.11]:52115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966996AbeBNKRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:17:00 -0500
To: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Geliang Tang <geliangtang@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] Ux500 crypto: Adjustments for ux500_cryp_probe()
Message-ID: <20dcb583-5455-b5b9-94df-db9d1e21931f@users.sourceforge.net>
Date: Wed, 14 Feb 2018 11:16:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QQFbUL/cFhAtIqZYkAJ4uXehXphoo1pBSrt2FfwKk5rRQTT0Hpm
 ZUsx8eyFw44mDkGZfrDcbeCHnvqSJ/Mr7ytPXSyabuWqbXTXex1DQW/WJSQy/N9DNiBomZW
 HefUAMZMmg1hK1QX7u5rd4lzCR4z69pLHtvN41wWJukdhq0FcGDAViB2pJUyLA8INnk5nm/
 Y6A9MEP6HVUCW7fA614Zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pK4uRHxcRvs=:p1UcldihEOO7sEErWwcKAx
 wlptlIsMyRITlVTkvBImZ1Yii4TFFu6ZVQRxqbaEYe1vb5DY0qDlXIeEimmbIDH6yv+7jWe2U
 qnI45ShxVbStSLAyBj3L8ObdQrZVj1vp6W1aPTAk9t01Rr9S7LdvbSl12IpcjAEUv404qOEPQ
 9y6uRE7FuT29M3Ic/f/4vY1njaR727KBZWblXlls2bCdtL0NWrkc4IovJLNXr6CEWJY/6E49H
 OqF79b9D1zIBBm/21HxKjVE9vnS9c3RkbNqSJCxzmHUx0BKsqK7VQGI0RgkB8nTkhV99z63Ba
 YA2RlR0NwWEnDvdvKEIBrlLacModuR1zSZBZezfwkHOXC0ZF/PZjGf6iJ2XIyebblDFfzMy5n
 ivSQs9MqHJdnruXJ/XRh7skGKAIJQz0Kj6Tvr+8XgNpMdrGPYPh616B72MktPR6kujiKIZSwy
 ssDSQLGdqqH54isDaBBGig6NHbj8UK4JIKWv77T1SPHkCgF7U5WkChDh1r3u/QPAvmRUMXwwu
 S7vK4WKrm/gYzYoK0S/i6QxluTpiOaLZHMlU96pFKsIWNY2/MtN4uswbiC81JnqPrpCcWFdTo
 bAUwRv1wrzsazVKN+Ebn48tT8hE8XgsxXPlCdnIev3E527yj/CS7KYlMWrbkjTQHcj40Kk2Xi
 K3zjCbuHMW1E5kXrApK779lJH4h7y52N4lVkyx6qtVVyQ6tDEx7phWaHZLPGscXvwZCAqMeBP
 igo+j42dtyg0bExtuw1lFiV3Kb5uht3YRjw7IO6iZQs9q7blfY8IV3x6UNf0u87qNgl8dLgzZ
 zyfhI8xITF4MK17KOdMR6cKalcR6+1uQX+0pFj6y0aKqrgD4W0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Feb 2018 11:12:34 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation
  Adjust two condition checks
  Adjust an error message
  Delete two unnecessary variable initialisations

 drivers/crypto/ux500/cryp/cryp_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.16.1
