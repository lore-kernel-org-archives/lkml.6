Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbeEJU7t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:59:49 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45918 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeEJU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:59:48 -0400
X-Google-Smtp-Source: AB8JxZqUhhbRkr3b1lpfryIx4tE4/ZDp8Y4COwe6Ngpjq9wg/AC/8KwYyI1ByD4TZz+GWG78aDKDxgwbIEiaMpG5pgU=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+p=ngqY_3oqMn83YMjjomKeQSs3Akk7+YfY5sPmcxw+g@mail.gmail.com>
References: <20180504011345.63937-1-andriy.shevchenko@linux.intel.com> <CAGXu5j+p=ngqY_3oqMn83YMjjomKeQSs3Akk7+YfY5sPmcxw+g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 10 May 2018 13:59:46 -0700
X-Google-Sender-Auth: CL6uelzmlTRGkL7ZOTth2N-nTaA
Message-ID: <CAGXu5jL64DfHcg_ncdi6AxF+zF=bQePU6Cqt3i3qks4dN36=yQ@mail.gmail.com>
Subject: Re: [PATCH v1] lib/string_helpers: Add missed declaration of struct task_struct
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 9:34 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, May 3, 2018 at 6:13 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> Starting from the commit 0d0443288f22 the new function has been
>> introduced which takes struct task_struct as a parameter. Though,
>> compiler doesn't know where to get information about it at this stage.
>>
>> Add missed declaration of struct task_struct to satisfy compiler.
>>
>> Fixes: 0d0443288f22 ("string_helpers: add kstrdup_quotable_cmdline")
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: James Morris <james.l.morris@oracle.com>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I'm not sure who should carry this. You're welcome to put it in your tree?

I haven't seen this show up in linux-next. Andy will you be taking it?

-Kees

>
> -Kees
>
>> ---
>>  include/linux/string_helpers.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
>> index 4397c52ec4a4..d23c5030901a 100644
>> --- a/include/linux/string_helpers.h
>> +++ b/include/linux/string_helpers.h
>> @@ -5,6 +5,7 @@
>>  #include <linux/types.h>
>>
>>  struct file;
>> +struct task_struct;
>>
>>  /* Descriptions of the types of units to
>>   * print in */
>> --
>> 2.17.0
>>
>
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
