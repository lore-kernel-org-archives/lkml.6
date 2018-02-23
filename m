Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeBWA72 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:59:28 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:37409 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbeBWA70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:59:26 -0500
X-Google-Smtp-Source: AG47ELsI+o2/cL/g7KxF4CtHOSeG0WuJl3HS+eNC7RB/jSx90VRO7L6ZakS9aSEpgNjiP1WKLQe10CgeTq3ABmNCIwQ=
MIME-Version: 1.0
In-Reply-To: <20180222235025.28662-1-john.ogness@linutronix.de>
References: <20180222235025.28662-1-john.ogness@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Feb 2018 16:59:25 -0800
X-Google-Sender-Auth: HEs0V9-67OMKSSoo-lzAp_-hjI4
Message-ID: <CA+55aFzcEv5xAFZuEqNpn55L+x8HkBSJDoWBYi92btCkWCp64Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] fs/dcache: avoid trylock loops
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 3:50 PM, John Ogness <john.ogness@linutronix.de> wrote:
>
> This patchset removes all trylock loops from within the dcache code.

I'm not hating it.

It may be because I got used (resigned?) to this from the discussion
around the previous version. But it looks ok to me.

But this is very much an area where I do want Al to ack it all, so
let's see if he's any happier now.

              Linus
