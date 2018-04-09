Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeDIFln (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 01:41:43 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:13984 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeDIFll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 01:41:41 -0400
X-RZG-AUTH: :P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9x24dP3Zg1I6xSGfZ
X-RZG-CLASS-ID: mo00
From: Stephan Mueller <smueller@chronox.de>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>,
        syzbot <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] crypto: DRBG - guard uninstantion by lock
Date: Mon, 09 Apr 2018 07:40:55 +0200
Message-ID: <58589900.TM7ux0T285@tauon.chronox.de>
In-Reply-To: <20180408224603.GA32004@thunk.org>
References: <001a114467482dbc4b05692df8f9@google.com> <6541596.TtyMCBNA0Q@positron.chronox.de> <20180408224603.GA32004@thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. April 2018, 00:46:03 CEST schrieb Theodore Y. Ts'o:

Hi Theodore,
> 
> So the syzbot will run while the patch goes through the normal e-mail
> review process, which is kind of neat.  :-)

Thank you very much for the hint. That is a neat feature indeed.

As I came late to the party and I missed the original mails, I am wondering 
about which GIT repo was used and which branch of it. With that, I would be 
happy to resubmit with the test line.

Ciao
Stephan
