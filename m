Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeDREce (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 00:32:34 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:38953 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeDREcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 00:32:32 -0400
X-Google-Smtp-Source: AIpwx48iLr1+N1rzcEkk7WjFpIzvMM3ZUm7SQOTgainrLf3vE54m7QXe4/p2Nzjmp8uChNWcXUyMhyOjcs23IaUqJkQ=
MIME-Version: 1.0
X-Originating-IP: [62.219.136.235]
In-Reply-To: <1523988865-26848-1-git-send-email-geert@linux-m68k.org>
References: <1523988865-26848-1-git-send-email-geert@linux-m68k.org>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Wed, 18 Apr 2018 07:32:31 +0300
Message-ID: <CAOtvUMeJLXxB3v2wr8EQFKxXpMo3Oi64Ac8aGA5vLDo37dQWjw@mail.gmail.com>
Subject: Re: [PATCH/RFC] crypto: Add platform dependencies for CRYPTO_DEV_CCREE
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Apr 17, 2018 at 9:14 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> The ARM TrustZone CryptoCell is found on ARM SoCs only.  Hence make it
> depend on ARM or ARM64, unless compile-testing.
>

Actually it is not. Despite what the name suggest, CryptoCell is
designed by Arm but is
not in fact limited to Arm cores. I think the only requirement is
ability to provide an AMBA bus
interface. Kudos to our marketing department to make that so clear and
so on... :-)

There are in fact licensees of this IP which use it with other (Linux
running) architectures, perhaps
thanks to the fact that the design originated in an outside company
(Discretix) which was bought by Arm.

Therefore, NAK on the specific patch. However, if there is some build
issue with a none Arm
architecture I of course very interested to hear about it.

Many thanks,
Gilad





-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
