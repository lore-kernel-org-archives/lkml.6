Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBBUOI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:14:08 -0500
Received: from mout.web.de ([212.227.15.4]:53584 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeBBUOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:14:04 -0500
To: kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>, Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] HSI: ssi_protocol: Adjustments for two function
 implementations
Message-ID: <14dd4865-f983-ba7d-3068-f6450a8de7ea@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:08:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JDlq3EBGET+P0eruisKifO2u/J/KyROkHVVv6Y7InRDGvCuV4e+
 FOwREX1MhzZkJO+umce7BHP2pdZRmmqU3n0V7haTVzTr8N2gbo8FGmWoUlleF0RzC2f6qWo
 bloIJn9Khjsb+5bVSNTRhbQ5lFtdVy+RFPzuvt54l2Vm15fDTAe5jVQ2ysb4l3FUXpVs4fb
 xgTV+8iQ8XQsjiLg41avA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rt+4IQ6jvHk=:BRHLeA6fWLaiKD8oLIJuIQ
 OZuv6ID5uJH3QV9HzWThT7sBS1SORbDEXEvWtvZjHwitK82b0R06vmxz/hzxgRpFdshIJKZa5
 TBK9iXdXJ3FNkF/ANpbsFahPRTS8FTbnAhDPPFs0JN7pBN+cww1NwRarKTPWtvRGPQrxqY2pZ
 S7pLRDk8t3ABaynRpEcqLkg7/Ek7sCqJJy4mcTZjhdcVQ4iIG8YcLTjH9U+ng+Lbh7X7ib+F8
 6hBszMpku7nHNtylCjGTcE9alG+88HDOlFELZZROxvl5H7mC+DOLICn8KvIHefJTMqok60zMA
 So8x2EpFnMWybLPayW6OEU4vyVQ88slfjaVE0gBLrbs+x6gZGO4rjqWTgM7ZMZ1wMEzGl+LGG
 GLFilY5FRZ/UwwUQhr1MXdN4EzZwQqbBzkeX22B8fB0mnDuEhMqEe/lKXQzT7iK5SDEcZlJER
 aygDeviBqN37h5DUSnJOEjN22jgE1kOhv4B+rMzEfKtpDIpUlUmaXehmvU9UEPzTaUAqcZqQ5
 6xr4ruufMvxL5rors2yHinsLdln4Bw/tW/2W9HpWQOBWRoRRm+kIRELDienSJITcoV9JxVEi0
 rjKySTqWXwZOhMm/Qxc2GVxHiSHDi7zDe/rtuQy7ZuyXsel+3BSFs8gforsXUBM5Fhzh0mtM6
 jOnr15miYyv4YcSowB7cm2BkE4FLIflkcV8nUBux7FsXAMTIhq+EQtWlALEwtTF9iGhmcz6WP
 Cx395nNzdppoJDuTkjBrw2P/2d5cw/jnMibayQpZV226zMbOmlYLt6CPA0OIaeL4MEAaROdhK
 Y6SvxupGz9c9qAukMf/6Pzo0eVE/xJWF4PMeuXJAh38BKQMr/M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 21:03:45 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in ssi_protocol_probe()
  Fix a typo in two comment lines

 drivers/hsi/clients/ssi_protocol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.16.1
