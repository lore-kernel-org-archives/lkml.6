Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeEOVCy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:02:54 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45575 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeEOVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:02:53 -0400
X-Google-Smtp-Source: AB8JxZoniCXZqXmcxPznhV/xxzhs8sRZAWNdU9SO1BuXKJ0E0yJs1VbEqrMR4awRaBf6lSxOf+8JOhLfzGDGfPC4bW8=
MIME-Version: 1.0
In-Reply-To: <20180515223516.16e907b3@bbrezillon>
References: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com>
 <20180510140311.02805561@bbrezillon> <CAHp75VcET7PZYfeRkmiP=n_xCnDzEFYS98ZLjszc1fHjdfDF2A@mail.gmail.com>
 <20180515093525.051856dd@bbrezillon> <CAHp75VevZCGOntYdj_B0T_SOKXFkWKLgyL2+1g2X9nRyhP5w=g@mail.gmail.com>
 <20180515100304.3daa7929@bbrezillon> <CAHp75VeEhB=+x0toCtSvrq0zBLXVCASzN2BUDDgNParSYZc5BQ@mail.gmail.com>
 <20180515223516.16e907b3@bbrezillon>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 00:02:52 +0300
Message-ID: <CAHp75VeA4nGUHz1L+ugX_F-aDTKoheqgnZ7zJKNKQmuRZ5pD5w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: jagdish.gediya@nxp.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jane Wan <Jane.Wan@nokia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>, ties.bos@nokia.com,
        prabhakar.kushwaha@nxp.com,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:35 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 15 May 2018 23:23:02 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> I made a mistake in my code sample, it's
>
>                                 if (srcbuf[i] & BIT(j))
>
> If you look at v6, you'll see it's been fixed by Jane.

In this case, indeed.

-- 
With Best Regards,
Andy Shevchenko
