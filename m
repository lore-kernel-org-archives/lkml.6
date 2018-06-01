Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeFAOzE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:55:04 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36529 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeFAOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:55:01 -0400
X-Google-Smtp-Source: ADUXVKJNZcxssKS0fS/+EDQWaOqSK4QK6b5P7mBbTSM63t0kRBPYML5fPToKp826rvtMkhOmRXH/n7Cm+y9kB+ZfSR4=
MIME-Version: 1.0
In-Reply-To: <907F14B1-A97E-46FE-BDFE-F8D4A23DF2EC@infradead.org>
References: <20180601213639.74f49e51@canb.auug.org.au> <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com>
 <20180601220832.73ad5b84@canb.auug.org.au> <907F14B1-A97E-46FE-BDFE-F8D4A23DF2EC@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 17:55:00 +0300
Message-ID: <CAHp75VcJau2Yeg8Y_fMFbTsECxOBi+OvXVN58__JvB9GfiAu9A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86 tree
To: Darren Hart <dvhart@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 5:33 PM,  <dvhart@infradead.org> wrote:
> On June 1, 2018 5:08:32 AM PDT, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>On Fri, 1 Jun 2018 14:40:35 +0300 Andy Shevchenko
>><andy.shevchenko@gmail.com> wrote:
>>>
>>> Oops. What is the proposed fix for that? It seems we can't rebase
>>> published branches.
>>
>>It's unfixable without a rebase, so you could instead consider it an
>>opportunity to improve your processes for the future. :-)
>
> Yeah, in this case we have to do a rebase.
>
> Andy, I've been wanting to look at using some simple bots and tags for this kind of thing. GitHub makes this really easy, might be time to move. We'll continue this offline.
>
> For now, please rebase next to correct the error as this change is on top of any of my commits, we won't make things worse by you recommitting my commits.

Done.

Author has been informed.

-- 
With Best Regards,
Andy Shevchenko
