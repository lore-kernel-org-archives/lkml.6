Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeFAOpS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:45:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42135 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeFAOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:45:12 -0400
X-Google-Smtp-Source: ADUXVKKlonN/i8r3SJXV0p9fnXQkPmYfdCeEiC3DOWOZ+wttNu1kyNt/Mv3Styww4QTJJt7EdL+ZK7gHiY08CrRzXlA=
MIME-Version: 1.0
In-Reply-To: <20180601220832.73ad5b84@canb.auug.org.au>
References: <20180601213639.74f49e51@canb.auug.org.au> <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com>
 <20180601220832.73ad5b84@canb.auug.org.au>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 17:45:11 +0300
Message-ID: <CAHp75VdOKwyRTG9J2p5ys2uN7-9KZv+uqXzEUBaqdm4i8QWT_g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Darren Hart <dvhart@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 3:08 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Andy,
>
> On Fri, 1 Jun 2018 14:40:35 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> Oops. What is the proposed fix for that? It seems we can't rebase
>> published branches.
>
> It's unfixable without a rebase, so you could instead consider it an
> opportunity to improve your processes for the future. :-)

Do you have some already cooked scripts to perform such checks on
given repository?
Can you  share?

-- 
With Best Regards,
Andy Shevchenko
