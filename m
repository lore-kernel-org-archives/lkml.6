Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbeBFSwG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:52:06 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:42874 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753026AbeBFSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:51:59 -0500
X-Google-Smtp-Source: AH8x2272809omLx+q+8tlUYF7snCb/KlLJ6hQikHMo4y0RrRzwTxsDQXJQOXu6muynLJcRaseYbEXRSyKBb0FF8s1ys=
MIME-Version: 1.0
In-Reply-To: <151790891868.9432.1307772484552574756.stgit@warthog.procyon.org.uk>
References: <151790891868.9432.1307772484552574756.stgit@warthog.procyon.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2018 20:51:58 +0200
Message-ID: <CAHp75Vd4i+=xyM80beqznuQbqwp_VSVOi0=-44u7WGpkVvw7mw@mail.gmail.com>
Subject: Re: [PATCH] printk: Print error pointers as negative integers for %p
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 6, 2018 at 11:21 AM, David Howells <dhowells@redhat.com> wrote:
> The new hashing feature of unadorned printk("%p") makes it hard to spot if
> the pointer actually carries an error value.  Make %p print any pointer
> that matches IS_ERR() as a negative integer.
>
> Should I set SMALL and the field_width as well, I wonder?

> +               spec.type = FORMAT_TYPE_INT;

_LONG ?

For sake of consistency.

-- 
With Best Regards,
Andy Shevchenko
