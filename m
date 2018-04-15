Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeDOWgF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 18:36:05 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44054 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeDOWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 18:36:04 -0400
X-Google-Smtp-Source: AIpwx49lFo7uPKopYDoDrxtT2oxsHYkEHiD86SIHT4jXIvceoAi/rP/wZ/RK+6q9mioombPwWJICX1qjzmSrvtvxL2Q=
MIME-Version: 1.0
In-Reply-To: <20180415190631.5nilksv3fr2clxbj@hjlipp.my-fqdn.de>
References: <20180415190631.5nilksv3fr2clxbj@hjlipp.my-fqdn.de>
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 16 Apr 2018 00:35:33 +0200
Message-ID: <CAEJqkghu-c90=cocnkxW7zD9twkb0v=DTNbQgmUC4JGC6fvgWw@mail.gmail.com>
Subject: Re: [RFC] Passing luks passphrase from grub to systemd
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-15 21:06 GMT+02:00 Hansjoerg Lipp <hjlipp@web.de>:
> Hello,
>

Hello,

> as I'm stuck with a (non-EFI x86_64) system with encrypted root
> partition, I have to enter the passphrase twice (grub needs it for
> getting the kernel etc., systemd needs it for mounting the root
> partition). This can be quite inconvenient, especially if the passphrase
> is long and contains special characters, and grub assumes a different
> keyboard layout.
> I therefore developed a proof of concept code allowing grub to pass the
> passphrase to the kernel and systemd to get the passphrase from the
> kernel. See the description and patch for the Linux part and the link to
> all changes below.
>
> I'm presenting my code here because I'd like to know if something like
> this might be useful also for other people (and further development
> might be sensible). I'd also be thankful for comments how this might be
> implemented in a better way.

Somethng like this is not needed.
All that is possible already from userspace.

Systemd can do that on his own ( see systemd-cryptsetup-generator )
( other init ofc too ) assuming your initrd , cryptsetup and grub is
setup correctly.


Regards,

Gabriel C
