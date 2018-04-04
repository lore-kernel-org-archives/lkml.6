Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756723AbeDDA1n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 20:27:43 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37959 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeDDA1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 20:27:42 -0400
X-Google-Smtp-Source: AIpwx4+pIhb+q1dOUYF4QW5scS6p/Sx/dJmcUdvV2t3jHGlzKSorO5QCeU79wAX08PXjgQyWfCZeP5EN97l9pQracTI=
MIME-Version: 1.0
In-Reply-To: <mhng-524aadcd-1897-4376-ab3c-10c43e79793d@palmer-si-x1c4>
References: <alpine.DEB.2.21.1804031349110.2511@nanos.tec.linutronix.de> <mhng-524aadcd-1897-4376-ab3c-10c43e79793d@palmer-si-x1c4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:27:41 -0700
X-Google-Sender-Auth: UuMjC3gmMqxb4COSJjMAOArEilo
Message-ID: <CA+55aFynLQp=n0_e=AQfMpwsGpCLhgFsw3uGPfuVCS1wJD3v4w@mail.gmail.com>
Subject: Re: [GIT pull] irq updates for 4.17
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 3:39 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> I assume it's too late to swap this out for that?  If so that's OK, I can
> just send a follow-on.
>
> Sorry for breaking things!

Thomas,
 I'll delay pulling your trees until tomorrow in case you want to fix
things up.

And after that, I guess we can fix it up after-the-fact too.

                  Linus
