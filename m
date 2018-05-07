Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEGDXT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:23:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:49129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbeEGDXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:23:17 -0400
Message-ID: <1525663384.5064.1.camel@gmx.de>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
Date: Mon, 07 May 2018 05:23:04 +0200
In-Reply-To: <1525660992.5105.1.camel@gmx.de>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
         <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
         <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
         <1525532191.5406.15.camel@gmx.de>
         <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
         <1525660992.5105.1.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LOuSnWERm9xqCuwdsZFCo9H9pOAqdvj1ZuPOQUeuqNz84V8LeT6
 lp1NeymL+ZhVmNuHqPQNARQK4jOrnMn+qXi9RXKeUETOFPdHHf45G3sBGErrxQMdWyRAxhO
 Q4aQKTpWddnzV9BglfKhU0XvpZmNaJABLEX23n6D7eQlX0/8z/jvZ2yFQoedIZ+XKScFdAE
 dCe53oJ7Gj7m31BnvsDEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hCL3F3oVBeo=:pN0j6WZqvTEIxfnfg035dC
 /ZQIHbSCdwHZVog57SlyHxis6RjC2h9N69UJNCYQbgH4rA+WXlZchVsSoZwB29GGRpWA5Mbak
 mY60dihZn+LH0F5SedCzbd1LPNdJb19cua20oCvZyCiVxy8fPGFdMYcSLH5Ea96vzV3UOU2Rm
 AeHFoSMittIMEH6Blzx/SmGgvlrdNo7+GHTn6r2eG3r/uarKkxC1FiYruvO80xxKMLZZYLRIK
 KyWvbWPpOljMg66REWIYmaDcloRwEZWlWRqSTnKpZV/+JKEKRnqfdfvIO1mfcxO+5/NcH3K7R
 XSpRX2vkHzS6tkJKuW79g/Vfq/2p7a8YG3jKY/pwjJSzTvClc4oW44JfOOsn8YObf6F+X2zCd
 tjYUBsVzqJ6z59I8tX/ibbUxIiFP69fZcSkzo1tDAqqPj2c0gvcdOWeoSgGfoUiToekr5Kv8v
 RFCkYEWQ/f4aHmE49zmUc+zbaLZRepTS30qPcut0Zvdl0WZJVhF86LVd6xXSyE1mwFWKSu1gz
 wUeYCpq+AoSorWkKoQVJwwBWIm3M59SOZC9qkYCHc0IKIZE5+Iw/H7A1Kt3tVcyWetvY+w7sW
 n9IuPBkJa7Qsuvbqq3L1qqDnKmS8N387G3TxR7QUqfdq+cdOsVSkf/EHpImfUn0SxYW4h7UI6
 iyimBYwGn2LOOfX3nndp6LYo+e+QNg06JZZqj0vi40i8lSGw34cuHYwyFpQLsTcbvwcnvtNNv
 heMgbN/2Ml6KPrKj9AsDkYGTWNqp7GkXO4ACmgLTKVLphHCLyF8LOXY7AW91reGPY9TcFk0k5
 yJf4TED
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-07 at 04:43 +0200, Mike Galbraith wrote:
> On Sun, 2018-05-06 at 09:42 +0200, Paolo Valente wrote:
> > 
> > I've attached a compressed patch (to avoid possible corruption from my
> > mailer).  I'm little confident, but no pain, no gain, right?
> > 
> > If possible, apply this patch on top of the fix I proposed in this
> > thread, just to eliminate possible further noise. Finally, the
> > patch content follows.
> > 
> > Hoping for a stroke of luck,
> 
> FWIW, box didn't survive the first full build of the morning.

Nor the second.

	-Mike
