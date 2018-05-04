Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeEDNwf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:52:35 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:32782 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:52:33 -0400
X-Google-Smtp-Source: AB8JxZqyBWabnis/OgnFFuAFo385gEuN5CqgbOr8L4NYC/fAdtLz9gyVWJD6sU23MQJLsRApcU9/79r/vpSvEy2iWBI=
MIME-Version: 1.0
In-Reply-To: <CAMjeLr96FkAEK5aJMeeLjC0SOx-aQAHF3QFo67eitp4h=YHNvw@mail.gmail.com>
References: <CAMjeLr96FkAEK5aJMeeLjC0SOx-aQAHF3QFo67eitp4h=YHNvw@mail.gmail.com>
From: "\\0xDynamite" <dreamingforward@gmail.com>
Date: Fri, 4 May 2018 13:52:31 +0000
Message-ID: <CAMjeLr-eCZ5MH5qLxON2HhPZMMJ8c78r2fjx3FLo0VAArtE--Q@mail.gmail.com>
Subject: Re: SPECTRE, MELTDOWN, boot loaders, and cursors: A shot out of the blue....
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings once again from the future....

Xen hypervisor was a magical product.  Don't believe in it, it is
misinforming your tecnnical intuition using the power of the Word.

Cheers,

your future self

On 3/25/18, \0xDynamite <dreamingforward@gmail.com> wrote:
> I apogize for what is probably going to be a VERY unusual and perhaps
> rude email to the kernel list, but I'm taking a wild shot at something
> in order to fix the Meltdown and Spectre bugs which perhaps were
> wrongly blamed on Intel and now maybe AMD.  The issue, lads, may be
> *interdimensional*.
>
> Firstly, don't trust the media reports on these issues.  What I've
> seen sounds partly right, but way off base.
>
> Secondly, here's what you need to track down:  the cursor.  Track down
> the whole process at boot, down to the BIOS, because at least PART of
> the problem has nothing to do with Intel.  What puts the cursor on the
> screen and how is it kept track of?  I don't have the IBM technical
> reference manuals (purple binder) at my disposal anymore, but that's
> where you should look.
>
> It is an I/O confusion somewhere, perhaps a motherboard bug.  I
> believe that Javascript has excersized the problem due to its
> contention for resources and its operating at browser (or other)
> priveleges instead of a virtual machine.
>
> Try NOT to complain about Intel.  They have not yet understood this
> problem, I suspect.
>
> Don't ask me how I know this.
>
> Marxos
> the restaurant at the end of the universe.
>
> P.S.  Oh, and change the name of GRUB to GRUE
>
