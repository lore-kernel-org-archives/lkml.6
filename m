Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeFAOdy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:33:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFAOdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:33:49 -0400
Date: Fri, 01 Jun 2018 07:33:41 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180601220832.73ad5b84@canb.auug.org.au>
References: <20180601213639.74f49e51@canb.auug.org.au> <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com> <20180601220832.73ad5b84@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
From: dvhart@infradead.org
Message-ID: <907F14B1-A97E-46FE-BDFE-F8D4A23DF2EC@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51EXx8i007805



On June 1, 2018 5:08:32 AM PDT, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>Hi Andy,
>
>On Fri, 1 Jun 2018 14:40:35 +0300 Andy Shevchenko
><andy.shevchenko@gmail.com> wrote:
>>
>> Oops. What is the proposed fix for that? It seems we can't rebase
>> published branches.
>
>It's unfixable without a rebase, so you could instead consider it an
>opportunity to improve your processes for the future. :-)

Yeah, in this case we have to do a rebase.

Andy, I've been wanting to look at using some simple bots and tags for this kind of thing. GitHub makes this really easy, might be time to move. We'll continue this offline.

For now, please rebase next to correct the error as this change is on top of any of my commits, we won't make things worse by you recommitting my commits.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
