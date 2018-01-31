Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeAaVVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:21:48 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:32954 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeAaVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:21:46 -0500
X-Google-Smtp-Source: AH8x224WYbMLvZ2Aj+vvY9t6GCqI/iFnUogWE6pA8vNCjmSq/HZF33wHw/2+3iFxMgwQtSWXGjNvfVG/U0Kvri/dRm4=
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1801291040280.29680@namei.org>
References: <alpine.LRH.2.21.1801291040280.29680@namei.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2018 13:21:44 -0800
X-Google-Sender-Auth: KzlnBzc2f7Kv_mY1OjPy0GuEkEc
Message-ID: <CA+55aFw1vWWmv5Ebq9yWVDFm4SQUG_fNd3f5yoYkWRTfUNaL_Q@mail.gmail.com>
Subject: Re: [GIT PULL] Security subsystem updates for v4.16
To: James Morris <jmorris@namei.org>, Kees Cook <keescook@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 3:41 PM, James Morris <jmorris@namei.org> wrote:
>
> Note that individual trees may also be pulled via:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>         next-integrity
>         next-smack
>         next-tpm

So I did that, because it makes it easier and more controlled for me.
But then when double-checking that the end result is identical to your
full pull request, I end up missing the seccomp tree.

I can pull that separately too, but it was missing explanations and a
real pull request, so I left it alone.

           Linus
