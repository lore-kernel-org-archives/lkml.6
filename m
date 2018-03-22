Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCVXVO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:21:14 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:43006 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCVXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:21:11 -0400
X-Google-Smtp-Source: AG47ELtAivhghEMi13kzy+UgMBh4paEC96sWdhwZEAGuHsQFixFIKCKWZmmRcT/LIzSbQ6x1hxhivNF20757X+u/LIU=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gT_p44NGUhkw7irDk-Uo8HnEYQ35+wJaBUo3ziLSbPsQ@mail.gmail.com>
References: <CAJZ5v0gT_p44NGUhkw7irDk-Uo8HnEYQ35+wJaBUo3ziLSbPsQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 16:21:10 -0700
X-Google-Sender-Auth: FonHMDPbBN7bOM30UBsnDB-9h1w
Message-ID: <CA+55aFwR_29JpVPUyyhnpJp=PBXk4nVO-8DBty6-vk2-8cgNFw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v4.16-rc7
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 4:05 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-4.16-rc4

I get

  fatal: Couldn't find remote ref acpi-4.16-rc4

Forgot to push out?

Oh. No, I see what happened. You meant "rc7".

Didn't your script warn abou tthe tag name not matching?

              Linus
