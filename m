Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeBBRaf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:30:35 -0500
Received: from mout.web.de ([212.227.15.4]:56646 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753091AbeBBRUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:20:31 -0500
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] I2C-DaVinci: Adjustments for davinci_i2c_probe()
Message-ID: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:UBGxOdIPfaXAs3LQx8EVmKgrtjp5oZsoxqz+bSVjaXRLKVmkCVS
 PDKEmUdPChgF0x4+nqsXxZFZlM448zALEgcujW0D0u+Su0haP+KgI7wGpqmoO4iWrDNUGKa
 Pm3Fyr5ZZFQVZazJP9BNQgOAwWaUwMz5//5OWYq+r4qR1V8AHF4AT9ImhGiXNAiR1beYSQ+
 smb4M4nd/5rqbRDJuYWVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HgrEEVXBKjI=:C5qmWBxyAajn4LuvhPX9Us
 9PgAZtWzBv+/Xf1z6qRPyRYLiPcRyHp3oqZYtMv4qOB86cTXNLroBHBEecaTXC5z4NsLIuy/n
 WSbQKNqx9MmdpnAJo7qK+Z/vbQlhPA8XSFNjLM+U1jvQDvtaXwuJ8xSURvhDu43G3v4Zucavv
 RbHmZ8Qy5opcX680uaunB1h2pp9ndQw9hLbc64xdOFLZNQ/KAv+zI0wceMAmc8h/LpOhwwuzY
 rpxvWHgAZ09jikuIuUOh8UiwItn7L1pMCx489RxTuS4u95ixvDiJwSxK3DR0qSpXlyw2Lmivo
 m1TnEporhk5z0LNeAQXOr2oaHIrYAJuFFVC8T1USnpoe2j12C+6zRRM9n2lJw+DgflKyyFl58
 1QhRiLQ30smwAxT2jLsPqluDpoHJCmNc1Qp7x4JHZckQcvsHFA3HHO85Vikx8AJvJV9uTQXbD
 byRGFGfZVWNbt1oemYM13jhYnMEBo7qkLjGhtwXvHilkhoz85vVE84VaNbXUVth8dumNg7iJS
 jaU3UvAwHUg81Sy+wfm7Q1BbkSRULC7AefgVuUPhzzekVpOf1AC0sc1OUH90tmAx9cbgy0BME
 FTSsYvOZ4fUhK8rCDbYp8qDM6reH9TdQxgxI5bl8fsRIeyMLrgMznhlmICl5iGbPNIl9mBKLt
 pQyII33CK9HjhjX++HjrJ42xtOUoNrSEtfcN8fNRoJxPSkPIQBKMnr04azLFNmxAlhzE87GuA
 fba2/oqZ03lWiVMe9Q0qEk4HrtsvFD507Q4gAXxjCqW81r8zZDUDIKNdUrs76nCFDlxLefMaj
 tQoEvI/k7kuw+/v9lN4FppRhUlxUy3lWsMfBmO+9tYbLO0Rnz4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:16:14 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/i2c/busses/i2c-davinci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.1
