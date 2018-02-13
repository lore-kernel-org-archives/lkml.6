Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965106AbeBMQ6G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:58:06 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:40901 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934514AbeBMQ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:58:02 -0500
X-Google-Smtp-Source: AH8x225Oh12Np4117yEV3oP97f57mo5brnkXz3+2Ums+503dkQUgQ5c+f18GLE9z4mFDCZXNCPmf8nrV8JJvmEO6P6A=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <20180213165159.GR695913@devbig577.frc2.facebook.com>
References: <CAP8WD_bdbmAp=bYAXp--36SME5Cgn42ovz+YpjEt94fzaVt4Ew@mail.gmail.com>
 <20180213165159.GR695913@devbig577.frc2.facebook.com>
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 13 Feb 2018 11:57:41 -0500
Message-ID: <CAP8WD_Z+yYXiRUZt4eMo2+zOSPFhsw=XiqJQUqVZFGGnGoWdPg@mail.gmail.com>
Subject: Re: x86/stack protector: X86_32_LAZY_GS=n hangs kernel on old processors
To: Tejun Heo <tj@kernel.org>
Cc: jeremy@xensource.com, rusty@rustcorp.com.au, mingo@elte.hu,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 13, 2018 at 11:40:17AM -0500, tedheadster wrote:
>>   in your patch "x86: make lazy %gs optional on x86_32" were you able
>> to test it on really old processors? In 4.16.0-rc1, X86_32_LAZY_GS got
>> toggled from 'y' to 'n' in my default config because of changes to the
>> stack protector code. It hangs my ancient i486 test machine right
>> after 'Booting the kernel'.
>
> I didn't have access to an i486 at the time or ever since, so it
> wasn't tested there.  If this is specific to i486, flagging it so in
> the config probably isn't the end of the world at this point.

Tejun,
  I will be able to test this on other 32bit hardware at the end of
the week. Hopefully I'll be able to identify which processors it does
not work on (i486/i586/i686).

- Matthew
