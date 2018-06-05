Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeFESip (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:38:45 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37640 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeFESio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:38:44 -0400
X-Google-Smtp-Source: ADUXVKK1mrGF9qsPLq0kxE6H/zpCYpqlkvQFBq3aayWkczEti+/qXZI7aLR5F8uDBag5dFX4IVuwFMPp5kVWx2RVNpI=
MIME-Version: 1.0
References: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
 <8f46ed9a-85c0-8df4-2d1e-d268cbc9d0e9@mageia.org> <CA+55aFwJAbr8_Xs0ZX9K2iAr8bf=ZgNnKTLopQe6jPCgEBemrA@mail.gmail.com>
 <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
In-Reply-To: <7a5458da-4222-7480-00ed-a51bed2c1e39@mageia.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 11:38:32 -0700
Message-ID: <CA+55aFyD0OMV1eoc9wh_hLcnRhHq2FwJf4EZcORmHPNxTRSX9Q@mail.gmail.com>
Subject: Re: building in 32bit chroot on x86_64 host broken
To: tmb@mageia.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:23 AM Thomas Backlund <tmb@mageia.org> wrote:
>   #
> -# CONFIG_64BIT is not set
>
> So something _does_ strip away the needed config bit

Why do you need it?

I get

  CONFIG_X86_32=y
  CONFIG_X86=y

and CONFIG_64BIT never gets set.

It is true that I don't get the

  # CONFIG_64BIT is not set

line, but why do you care?

            Linus
