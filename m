Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeCIPzp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:55:45 -0500
Received: from mout.web.de ([212.227.17.11]:41379 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751146AbeCIPzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:55:43 -0500
To: kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 00/17] MFD: Adjustments for several function
 implementations
Message-ID: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Date: Fri, 9 Mar 2018 16:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:BG11NNYWAdPc2wMZX53bYOmqBZAotvc+IoWRVplFjORdQFgfZj4
 IWSoZIERiDuA/f7OyDxCJb7KlrXJaTRSkaBZ2WmTRoCELChs5gLU72QWIFkahqOYqx6xZzy
 UQBOKskFsUXQqvvDgTTsi1XZOdYFsmAJEBc73UBrDCpfbL3Kr2pHZo9lmzncqhEJqk9kQ9z
 q1qNkLYc3FIlkb6fztWfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8FJcuwl67rs=:TmrMEYr0y69+WYV6Je5YrY
 Lp5YBC2qF1cQ/Iqp22yIASmKZU3z9dEFPrRjO16+cCDHMtz7t5dqrHhnytwQSZkFKtmzFYEXi
 z62MvOHZWTqV1kOlfzl0dAXCfEC5DjbT3OMpeiu9XAEoiO6Yskqc3/Xetts2rIuawKU/bLoNa
 OM73krNaAHKM8F+6CV+3kfu0kstz0g9uoyW/YtkpH8MZrn9coqXWISznQG7AG1+K/L2pZy0Ta
 frxA8WJDUYeC/t2oBBCrRom6qtlDsP1ywDxPmX+ZVtYVs6k7sCtIAQF7dB18KKjHFG1Md2LPm
 CZLSYS+Swf6eKeQdNgK5LjQ8AKe/KeTV8NCWVx8Ck/AxFHnkT+BVQFZxzYLq7iOJNk41GUw22
 uPqR7oAWqx1L6JwZ2hyM1b4RDBNEWr6aMMPNT1nhqtda+nP0i7sKkBjDODrMIbnHsYgiaOGU5
 gmy+7ZfzJUFTA4tLpgO1ROHdYko8kQZOTPo2dNdJ48XhbH15rYrn68VCr8/Wujv4d6Pforo1g
 Cg/vqeH0QXOYOC0OBjCTsfIEpN8dnq/LehAPkB9XA21aLJaU3rJ1L3yIrtJdyaaTHt6gveBKE
 /t0fdD47XLhjDIzZJYWHqy9Nf9jMjaHCU0VLEjenFp7VgL1Cl5HzTI3quyoVzB4MflyIkP2c7
 pQzU6rm51nt2tz/UKVpMdFx5pm8deOxOSFZFDNIum88sVJV4Xk0gHBKOYSALe8EeO29JGd4P0
 caVpUcKjS3x8FiiQBnk4UpN7Kwimbk5FkpvT89QbnbpU7pDZZguK7fZr+8SHtDLcaZncDtyOA
 uUp6kbVsjoKl+nV4nTgz4pkwuJlQkpOFpf2C8Wxc3v7obCaINU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 9 Mar 2018 10:24:42 +0100

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (17):
  abx500-core: Adjustments for eight function implementations
  si476x-i2c: Delete an error message for a failed memory allocation
    in si476x_core_probe()
  sm501: Adjustments for five function implementations
  smsc-ece1099: Improve a size determination in smsc_i2c_probe()
  ti_am335x_tscadc: Delete an error message for a failed memory allocation
    in ti_tscadc_probe()
  tps65090: Delete an error message for a failed memory allocation
    in tps65090_i2c_probe()
  tps6586x: Delete an error message for a failed memory allocation
    in tps6586x_parse_dt()
  tps65910: Adjustments for four function implementations
  tps80031: Delete an error message for a failed memory allocation
    in tps80031_probe()
  twl6030-irq: Delete an error message for a failed memory allocation
    in twl6030_init_irq()
  viperboard: Delete an error message for a failed memory allocation
    in vprbrd_probe()
---

v2:
Lee Jones requested a resend for some of these patches. Thus several changes
were rebased on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c      | 25 +++++++++++--------------
 drivers/mfd/si476x-i2c.c       |  6 ++----
 drivers/mfd/sm501.c            | 30 +++++++++++++-----------------
 drivers/mfd/smsc-ece1099.c     |  3 +--
 drivers/mfd/ti_am335x_tscadc.c |  5 ++---
 drivers/mfd/tps65090.c         |  4 +---
 drivers/mfd/tps6586x.c         |  4 +---
 drivers/mfd/tps65910.c         | 18 ++++++++----------
 drivers/mfd/tps80031.c         |  4 +---
 drivers/mfd/twl6030-irq.c      |  4 +---
 drivers/mfd/viperboard.c       |  4 +---
 11 files changed, 42 insertions(+), 65 deletions(-)

-- 
2.16.2
