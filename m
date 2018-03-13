Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeCMTwp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:52:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33059 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeCMTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:52:43 -0400
X-Google-Smtp-Source: AG47ELsuRJI2lypJJhrjLNpDQUttgPhF5JStdfPeeKCTQztJT14KpXyzVrFkLIqiYDX3p2X+VDf9BT5POLXdLDWBkbk=
MIME-Version: 1.0
In-Reply-To: <CAMM=eLdZ6adSV6Q0JLkRi9k=7g5o4SEAyGfOm0P_nqw71Jbing@mail.gmail.com>
References: <20180313183326.0e93f359@canb.auug.org.au> <CAMM=eLdZ6adSV6Q0JLkRi9k=7g5o4SEAyGfOm0P_nqw71Jbing@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Mar 2018 12:52:42 -0700
X-Google-Sender-Auth: YAPJfXS11m8XSl3rpuHVJZ24jfI
Message-ID: <CAGXu5jK=SMR3UsnwuEX3WwQd8WdjgR=94xXzHdBMEGALRr_JOQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Mar 13
To: Mike Snitzer <snitzer@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:57 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> I had to revert the following commits to get this kernel to build
> (otherwise I got macro expansion errors, using RHEL7
> gcc-4.8.5-28.el7.x86_64):
>
> beb7eb2 kernelh-skip-single-eval-logic-on-literals-in-min-max-v3
> 19ff7e5 kernelh-skip-single-eval-logic-on-literals-in-min-max-v2
> c7c133f kernel.h: skip single-eval logic on literals in min()/max()

Yeah, these need to be dropped from -mm. There isn't a sane solution
at the moment that works fully for all compiler versions. :(

-Kees

-- 
Kees Cook
Pixel Security
