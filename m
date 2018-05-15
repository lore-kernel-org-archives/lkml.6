Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEOSyF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:54:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41668 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeEOSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:54:03 -0400
X-Google-Smtp-Source: AB8JxZrdvTW0pzuFbBpAdow5nVnqXRdZpQAbQgOSFFe6A1PSAwefgayTOH/Y6w2dbTl1uZCPWvYWU9Fsf6kl1YLSrrg=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL64DfHcg_ncdi6AxF+zF=bQePU6Cqt3i3qks4dN36=yQ@mail.gmail.com>
References: <20180504011345.63937-1-andriy.shevchenko@linux.intel.com>
 <CAGXu5j+p=ngqY_3oqMn83YMjjomKeQSs3Akk7+YfY5sPmcxw+g@mail.gmail.com> <CAGXu5jL64DfHcg_ncdi6AxF+zF=bQePU6Cqt3i3qks4dN36=yQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 21:54:01 +0300
Message-ID: <CAHp75Vdq48kv54noOJqnh29rpN30whBnOzA9-j4Y1dC4-XgLnA@mail.gmail.com>
Subject: Re: [PATCH v1] lib/string_helpers: Add missed declaration of struct task_struct
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:59 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, May 3, 2018 at 9:34 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, May 3, 2018 at 6:13 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> Starting from the commit 0d0443288f22 the new function has been
>>> introduced which takes struct task_struct as a parameter. Though,
>>> compiler doesn't know where to get information about it at this stage.
>>>
>>> Add missed declaration of struct task_struct to satisfy compiler.
>>>
>>> Fixes: 0d0443288f22 ("string_helpers: add kstrdup_quotable_cmdline")
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: James Morris <james.l.morris@oracle.com>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>>
>> I'm not sure who should carry this. You're welcome to put it in your tree?
>
> I haven't seen this show up in linux-next. Andy will you be taking it?

Will be in next next.

-- 
With Best Regards,
Andy Shevchenko
