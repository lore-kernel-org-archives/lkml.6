Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeBJVFt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:05:49 -0500
Received: from mout.web.de ([212.227.15.3]:53949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752391AbeBJVFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:05:47 -0500
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] GPIO-OMAP: Adjustments for omap_gpio_probe()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Date: Sat, 10 Feb 2018 22:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IfcijycqUwS2Lx433aRFZNdPlFS9si7L1UHz1OMHiOTFZRl0FK9
 KUR3jsQiKGOSv2jClKT2a+IW3Nh2T0QqUiN4n8sEEF1IlYtPlfTbzUSViyye4fA6Jti/Ygl
 hkTBTlUtRQzIv81t67lfunxiFvs/Eym5OUVKNRtMgCBpgB/ey8IhAorpOZXcolyObYuZc3a
 xXOc/4uufaGs9Bpzhi5Cg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jf7hTUwQNNg=:xJM/Rwnv+8cWQoAOYuX5y9
 GhMUd4AJS6pAa8I471iki2ZfSZg1Lt6jj7eoNoJJQIDR4b4ygKiLgtjSVToU2bQAxY2Gsqjcq
 5BAj0ag8GRvERAOxzyJapIqBstCBSbqv3eWokYJCzxLtG10Ex5goUaCDJQv/LGzH8O2xgwHqB
 KFUhxVmm+Xjgj9WGLT3iYHE/2g+jNwLcSSxbSfOIiWG073MivIdigiaCF6a3QwYZ3lHYWGYoo
 PUSsWB1WbfLgqtztxAcvYHFe8w+mG1i/28l73Rzf/2piabr7zoslXdOHcNqHocDxSi7plS0lj
 WN/m5mMzPhFAnOCuR3X0JMhfxUDKLH9jUguuFwL009yqvcO64LF4aL65O/FCitSbcPcqmf3Ak
 msluR/zkrbCS5xSrmnHQhvkhCs5ddZqQrqBQysLlzYHVNHaHK/wd1GXVQE3dTQl2zWRDS6ryA
 0255Ox0HA9G4qDZtOF5xVerKLVJbiXO5Dkx4YM3maX1Rw8txXbVqfULsIrnzmdvLsn/YdiH08
 mTPDfvW0AEdpMf2PAKcG/Ef4pthFRn53Uo2q6bsi2NkavDCkYe+eI8QtJig9NU2sWwxaTAJ5a
 /zJFW3vpnM8ieKnQ5QcJOPBFDkSa4flPt9tkJXaXzlDJOp1dMGOFMbC2BH+ZWEVInvs6JskX1
 CSAkLn0DrKuDAe8C5Q0bEYFsawfkTplOEHtqZcGauLIEGRsFdGih48Ue4lfyMPU2Y/aNlsg+O
 H8ujMhi3V1Dk+Cvv93vtJbEG+YIW1zsyczQ2aycb+4Zgue+vhFkUS3yFdHThN1fISv2wCN5En
 jv/dQOW7uSuWjFiiw4VdZVrvJxDftWD0GOvzq+wttqnNjyIbmM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:56:54 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/gpio/gpio-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.16.1
