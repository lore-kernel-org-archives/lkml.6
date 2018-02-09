Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBIR34 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:29:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:33669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeBIR3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:29:54 -0500
Message-ID: <1518197379.26824.31.camel@gmx.de>
Subject: Re: [PATCH BUGFIX V3] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Ivan Kozik <ivan@ludios.org>,
        169364@studenti.unimore.it, holger@applied-asynchrony.com,
        Serena Ziviani <ziviani.serena@gmail.com>
Date: Fri, 09 Feb 2018 18:29:39 +0100
In-Reply-To: <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
References: <20180207211920.6343-1-paolo.valente@linaro.org>
         <17c57205-7cc0-5577-0322-dc35914e50e5@kernel.dk>
         <34041F0A-F460-4736-9A6C-76D861EA0070@linaro.org>
         <b5d4a3bc8946db0a696e8398b68adba0@natalenko.name>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tyDji0ia5aSciIFCFR4UVYi47fHB4fi6hgKoHStZSj0DR21FGXx
 bezqvlR3mSKfbXaRqdGYRgLgzrzt1R/DkOgw79mij/BonT1Z09LH0ZsfgMlNf4GaXlhFv5n
 kRNncSsT6CLkJTnuxk41kMEvuZSTuJMXUewv0RSFzsXau9TqU11R1BqzshsKAC8JY1UB+kD
 VTYnIRwbYD8ColDRCj8ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3Et7xHvFhdI=:bZmOmbFj874kAyPp1uQEUn
 +sqq7liNNOCmyoxeuJg3ZzpnLqcOPyLAmw3BFPZJZrShcDxiKW78eAPvmGjZa6IdzsDe+KZUb
 f+CK3Hap28lpkcOzOKi0k22lq9+4F65dtk51Q8yNGx2MaCK02UWQV6bwBDUZqksA+dib/4Ufv
 bitSTrLF/SRMbkowq9umvU+5oIp44FRQyHPkRLdA5pq+cvFYSs+oTa3l+fqHSzB27S96B1uNp
 FKwmbf/ieIN1oCzOsnwquVt0GF22bxpAYgGNlT/c73VI7Z2ME1KNJcNl88pIEvPbdu2lY9JiK
 9MqSc7++vVgdWweayk3v7PmdJNSKnjvZfI1yN8wlDhPR5GmZ/5DNYpKNTkr9m8CbIkgMqg9Tk
 AEZGT8zmyl7rPvqnGkSyKJXqlVM9PvHx1YDD1F8Q+CEECq7poa0TWRNYB+t3np4vVqSbscDj9
 JTHz+BRDtQAU0IrSSCwjIOixwyjhwQvXwqsqziKZGGcW94qQTiMPHCOTFVpW3RPqVCahA6loc
 qFxjihoC+Wzdf9QHejd4e8y2E832I9x6MqD/7MqTfsIgdPAziwlLHM5OIuYAyqD5OfBZ7dL71
 V1XnDO2ZfmLX+tkXhrXF6HcUY8QwUyJDc1LXH/u1J6fuQhwrUcWJjDNE+WJqjUTgckIESXQfW
 yIVHO6HJEkMDq41tWec7fkr9CbPr16NVulHkiE7EnPQIaUShSvBt5cd5HbNTvY0BQX0m21OFl
 JQM6DO4TbQw/Z3b2+EhlYpQNNi9+MGPGrI3eCY54hx7qX9dyfKUV+18A2boUZHlCFo3b6iEa4
 jUDd3Mfj/RmtoHGgmS6mL8zVlbN+yFlaKuKoLa0CRIHnyFnvG0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 14:21 +0100, Oleksandr Natalenko wrote:
> 
> In addition to this I think it should be worth considering CC'ing Greg 
> to pull this fix into 4.15 stable tree.

This isn't one he can cherry-pick, some munging required, in which case
he usually wants a properly tested backport.

	-Mike
