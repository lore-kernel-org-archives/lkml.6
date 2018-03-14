Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeCNQ4g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:56:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33458 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:56:35 -0400
X-Google-Smtp-Source: AG47ELuP1QIQG5GdZj6Lkl+5IdNNtSut4Jk/Sqg0+LWHGGZpHzvNOeqI1g15NJJ0vLZOvzhdoZUPSHaNteFkYJNBYGM=
MIME-Version: 1.0
In-Reply-To: <20180313184652.dzjmoxs7zl4ocrfw@gmail.com>
References: <20180313184652.dzjmoxs7zl4ocrfw@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Mar 2018 09:56:33 -0700
X-Google-Sender-Auth: WL4FZtYmjwwp209HJbUwL7ylJsM
Message-ID: <CA+55aFyiM9apbksAvYn7ECaed2F9q7YJk7Vv_iA=ogLKxD4R0w@mail.gmail.com>
Subject: Re: [GIT PULL] auxdisplay for v4.16-rc6
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>, Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:46 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> This is my first pull request, so if there is anything wrong, please let
> me know!

The commits in there looks fine, but I have to admit to not being
super-happy about it.  They are recently rebased, and looking around
in the logs you've been gone for the last eight years.

> Also, note that for the moment my PGP/GPG key is only signed by 2 other
> kernel maintainers and that we did it over email/Skype. I used GitHub
> as well for the same reason.

Ok, I see Linus Walleij's signature there, and the individual commits
look trivially correct, so I'm pulling it, but with a bit of grumbling
about the timing.

                 Linus
