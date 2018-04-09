Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDIHyS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 03:54:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:20935 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeDIHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 03:54:16 -0400
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x24dP3Zg1I6xSGfZ
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] AF_ALG: register completely initialized request in list
Date: Mon, 09 Apr 2018 09:54:12 +0200
Message-ID: <3223691.KS9TZr8pPl@tauon.chronox.de>
In-Reply-To: <CACT4Y+bGDOi-+vVs=-eD=wHaUbFz2ZVO13yF8hq4cU4dkGXorg@mail.gmail.com>
References: <00000000000092ad87056950ef9e@google.com> <3337259.MW9pfDCdka@positron.chronox.de> <CACT4Y+bGDOi-+vVs=-eD=wHaUbFz2ZVO13yF8hq4cU4dkGXorg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. April 2018, 09:51:13 CEST schrieb Dmitry Vyukov:

Hi Dmitry,

> You can ask syzbot to test by replying to its report email with a test
> command, see:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication
> -with-syzbot
> 
> Note that all testing of KMSAN bugs needs to go to KMSAN tree, for details
> see:
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs

Thank you. I will resend the patch later today with the proper tags.

Ciao
Stephan
