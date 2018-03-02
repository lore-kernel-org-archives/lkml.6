Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934423AbeCBXKE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:10:04 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33236 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934276AbeCBXI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:08:57 -0500
X-Google-Smtp-Source: AG47ELu5+51MAgkJ+GwX5WiOBNjEK8j05DtndcxrPRMD1nde1yTlVBRZjjp8Uc0AgL7f6MwzYlG2IA==
Date: Fri, 2 Mar 2018 20:08:51 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Samuel Ortiz <samuel@sortiz.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/58] net/irda: Convert timers to use timer_setup()
Message-ID: <20180302230851.GO4375@localhost.localdomain>
References: <1508200182-104605-1-git-send-email-keescook@chromium.org>
 <1508200182-104605-10-git-send-email-keescook@chromium.org>
 <20180302212919.GJ3887@localhost.localdomain>
 <CAGXu5jKvEcywh-NhMngNph376H3bXy=ZC9jxm6k5QdfJ_w64ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKvEcywh-NhMngNph376H3bXy=ZC9jxm6k5QdfJ_w64ZA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 02:30:30PM -0800, Kees Cook wrote:
> On Fri, Mar 2, 2018 at 1:29 PM, Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> > Note how it is using the irda_start_timer definition from
> > include/net/irda/timer.h instead of
> > drivers/staging/irda/include/net/irda/timer.h which was patched in
> > this patch.
> 
> $ git show net-next/master:include/net/irda/iriap.h
> fatal: Path 'include/net/irda/iriap.h' does not exist in 'net-next/master'
> 
> 4.14 moved include/net/irda/iriap.h into the staging directory:
> 
> 5bf916ee0ab6 ("irda: move include/net/irda into staging subdirectory")
> 
> I think you've got a stale copy of the old file in your tree...

Right you are. Sorry for the noise.

Thanks,
  Marcelo
