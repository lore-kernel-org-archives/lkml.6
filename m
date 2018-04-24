Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934395AbeDXNoh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:44:37 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34857 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933683AbeDXNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:44:29 -0400
X-Google-Smtp-Source: AIpwx4/VQmsLx9hr3EWhH3x42+nabppqglIUSg4m8JGrKjGFjoNLsRjCFCN08j/mvyi1Af9GK47wZZ3sB5pYw5qAtFw=
MIME-Version: 1.0
X-Originating-IP: [217.140.96.140]
In-Reply-To: <CAMuHMdWQAss+_fjrj5BGcstojR0Up9-danH3UxC5PWOLkKrpXQ@mail.gmail.com>
References: <1524484097-8315-1-git-send-email-gilad@benyossef.com>
 <CAMuHMdXNAkCVpyGyQMKRMRGuXyjOHAGgvHT4QGkuYdZetOr-9Q@mail.gmail.com>
 <CAOtvUMd41+5DzHRbViyNZkiL92BYh2YaREvhiAH0UPnPYCzB+w@mail.gmail.com>
 <CAMuHMdXZ0vL7Rxg4+CsP1u_Eb95Nj+qHnrahYPhAewmcrxN9HQ@mail.gmail.com>
 <CAOtvUMe=iOeWAUwDQ-3yy=Ogg0_=4iEwV32ATEn6SrLPEojNGQ@mail.gmail.com> <CAMuHMdWQAss+_fjrj5BGcstojR0Up9-danH3UxC5PWOLkKrpXQ@mail.gmail.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Tue, 24 Apr 2018 16:44:28 +0300
Message-ID: <CAOtvUMc5-UC1im7TYt7AtRJMJY=+_mRNmugWPNL_R_twLf7CQA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: limit build to plausible archs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 11:52 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>
> My underlying idea is not to cut down build time for test code (that's what
> we have COMPILE_TEST for), but to enhance usability for users and distros,
> who need to know if it makes sense to enable an option.

OK, considering the driver Kconfig depends on OF I think we're OK here
with regard to usability and distros.

>
> IMHO the extensive list of possible architectures is not really an
> improvement. So either a dependency on COMPILE_TEST, or no dependency
> at all makes the most sense to me.

Fair enough. Herbert, please drop the  patch than.

Thanks!
Gilad
-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
