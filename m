Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934706AbeD0OjE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:39:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934230AbeD0OjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:39:00 -0400
Date: Fri, 27 Apr 2018 10:38:59 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Alasdair Kergon <agk@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, Tycho Andersen <tycho@tycho.ws>,
        Heinz Mauelshagen <heinzm@redhat.com>
Subject: Re: dm/raid1: Remove VLA usage
Message-ID: <20180427143859.GA26647@redhat.com>
References: <20180411044315.GA46144@beast>
 <CAGXu5jLUTF0c3DLGjFFnSwJ3FJmiOMYRu3vqTqNVEBQehyn4KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLUTF0c3DLGjFFnSwJ3FJmiOMYRu3vqTqNVEBQehyn4KA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26 2018 at  7:31pm -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Apr 10, 2018 at 9:43 PM, Kees Cook <keescook@chromium.org> wrote:
> > On the quest to remove all VLAs from the kernel[1], this avoids VLAs
> > in dm-raid1.c by just using the maximum size for the stack arrays.
> > The nr_mirrors value was already capped at 9, so this makes it a trivial
> > adjustment to the array sizes.
> >
> > [1] https://lkml.org/lkml/2018/3/7/621
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Friendly ping... can someone take this, or should this go via another tree?

It needs further review but it is on my radar.

But please consider it claimed and proceeding upstream for 4.18 via
linux-dm.git

Thanks,
Mike
