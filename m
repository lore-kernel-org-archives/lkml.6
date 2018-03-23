Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCWUQj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:16:39 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:34727 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:16:37 -0400
X-Google-Smtp-Source: AG47ELvGIPHfvTUzNMfBAhSC/5wO6Z9lo1RDJdwAvQw92BqWWdyvOUt1QCSOkaANy8RXWl+V15IbLA==
Date: Fri, 23 Mar 2018 13:16:34 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: syzbot dashboard
Message-ID: <20180323201634.GA16350@gmail.com>
References: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
 <CA+55aFzxDYGLUPY802rJN=wgJ1aEZHLRE+W8J82eFz2nzKOMBg@mail.gmail.com>
 <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YDqJMb4mC6c--Ku=ZL9MpELmUKMXe4uQJ6H0av2FJC9w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:45:43AM +0100, 'Dmitry Vyukov' via syzkaller wrote:
> On Wed, Mar 21, 2018 at 9:32 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Wed, Mar 21, 2018 at 9:11 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> syzkaller/syzbot dashboard is now live at:
> >> https://syzkaller.appspot.com
> >
> > Ok, this may well be the thing that makes syzbot reports useful, if
> > they point to an external report instead of sending an absolutely huge
> > illegible email that nobody can read.
> 
> The dashboard was initially meant to be used only for internal
> monitoring (communication with kernel developers over emails) and I am
> too close to the project to see obvious stuff. So thanks for the
> feedback!
> 
> Do you mean to replace all attachments in syzbot emails with links to
> web dashboard content?
> I've heard opinions both ways (including "I am not clicking on any
> external links, include all content in the email"). So we need to
> decide. Provided that lots of email clients seem to inline
> attachments, rather than show them as separate files, I am leaning
> towards providing just links. Then emails can be short and tidy. Also
> will solve the problem of "I don't see original attachments in your
> forwarded email".
> 

A compromise could be to remove the raw.log from the emails, and send the config
in 'defconfig' format rather than the full config; that trims it down from 5256
lines to 925 currently.  That would get rid of most of what is bloating the size
of the emails, while still keeping the (very useful) C and syzkaller
reproducers.  Dashboard would still have everything, of course.

Eric
