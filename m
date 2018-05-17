Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeEQQAR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:00:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeEQQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:00:16 -0400
Date: Thu, 17 May 2018 17:59:40 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1412187220.62585.1526572780332@email.1und1.de>
In-Reply-To: <20180517131727.29263-1-eric@anholt.net>
References: <20180517131727.29263-1-eric@anholt.net>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:I90nzdkZM7NUSEsuaRFdLxzZ8I8Qn/S0vO/TgUNyx3sQDtpPQfP
 6VQ6XT9ICxDu1Mav8hX/U37Kg9N6vS1GtrlMX9hmoftmsq/I8gXdwvZdKSR8NM0w1Rc2XKi
 8bxQY0QD9lzvHrwlk3Mh4XsBEQJM4GqqYQiJ9eBXpr2d2eOFrMielM21QmBm6agKmBqh8Ji
 wGkVoZhp8K6iGni85J99g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BiAWei0QUJE=:W+I8cSveR/1nUDgHkiNqQL
 ZqQg3laTR8F4QooH8IfNRkx2P+6sYO5xZjduIWKs03By6+HFhfMPFdbBFdinpzUGhDHBWHndJ
 fdBpUqmWYa3L6vH0BzTgVz4jcpHkHeiyaAUQnOtg0sxzd2dMUMH8tbxyw3aNZ0DUy68w3GML/
 vYxYuvN+XjvaBBy1aqcPMM2bGeS2vSbrhkQbJskifEQjnvx+j0q8UnYqGYOS+IyvigApW55nO
 jpNqynPWCeNknTcXIzLnWKVb5oF4vbpWOczKe12NnMa+1Z+Jf3Qwa5jlYK+7uOhke6CEcNPTe
 kO9nz3fwVhnaSZH3L8/zQYcMYGdKAECaF69bZRfGbF29EWsWHq5U3ZZf73tjeOA9n0G5chA9T
 hMuHKPGcr+ZWHJ6zyC1ewJ6g+6fFifUTbPcEZkxISwO53KmyJ9xFGbzeJMs8v4EMr6DfBhu5t
 aCk4Cx5CH+U4FNzbs8ezoIP5Iwxk5eHOx2+/RSt1nAm/Yrk0TXTRFZqi4OEcGvMW+R43OKzDr
 vK/hsrQrOCXEfb/L5gpnOJDb/8RmSkJEo+beNFNn7GuJc00XzVm82MBPA9B2lxinri4YKJFiz
 gpGAC/yZkSE5s1dZTdTxV99vFLXO6lJnSixPDDHPuwFmb+eBJFZswxEMdcBfU0/Me7mlQLmjV
 rCIUuhaU9sazRKnODPwpV0MoXwpwMz3oX9vp2vVvG2kmHDEQl4xECS/40rNBC3Kji44dOiZrE
 OO6lz47WWhREfwbj
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
> 
> 
> The a53 and a7 counters seem to match up, so we advertise a7 so that
> arm32 can probe.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
