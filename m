Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeCBWae (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:30:34 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34112 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752837AbeCBWac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:30:32 -0500
X-Google-Smtp-Source: AG47ELvBtxvf6Z0Eed40l/AWhH0ucMj1+ZE3wqXBDRHl3/3UO+K48ChIhq067H+ZaPEeJpkTPMYdkQkOGL2lMe0nMwk=
MIME-Version: 1.0
In-Reply-To: <20180302212919.GJ3887@localhost.localdomain>
References: <1508200182-104605-1-git-send-email-keescook@chromium.org>
 <1508200182-104605-10-git-send-email-keescook@chromium.org> <20180302212919.GJ3887@localhost.localdomain>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 2 Mar 2018 14:30:30 -0800
X-Google-Sender-Auth: He8H6NxTfUBc-qA6jhn_csJA1nQ
Message-ID: <CAGXu5jKvEcywh-NhMngNph376H3bXy=ZC9jxm6k5QdfJ_w64ZA@mail.gmail.com>
Subject: Re: [PATCH 09/58] net/irda: Convert timers to use timer_setup()
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Samuel Ortiz <samuel@sortiz.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 1:29 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> Note how it is using the irda_start_timer definition from
> include/net/irda/timer.h instead of
> drivers/staging/irda/include/net/irda/timer.h which was patched in
> this patch.

$ git show net-next/master:include/net/irda/iriap.h
fatal: Path 'include/net/irda/iriap.h' does not exist in 'net-next/master'

4.14 moved include/net/irda/iriap.h into the staging directory:

5bf916ee0ab6 ("irda: move include/net/irda into staging subdirectory")

I think you've got a stale copy of the old file in your tree...

-Kees

-- 
Kees Cook
Pixel Security
