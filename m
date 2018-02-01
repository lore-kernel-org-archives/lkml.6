Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755031AbeBAU0Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:26:25 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:33627 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754909AbeBAU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:26:18 -0500
X-Google-Smtp-Source: AH8x227wHgEvZxeZObMrKF0S4D2/g7hmsKxtoyZxe9WmcsuqUeZ3/LVJNRiHKWsi3UIdETmdn56fHeyolMJPPuBnQdI=
MIME-Version: 1.0
In-Reply-To: <f5868212-8e79-e7f8-658b-063b8d774db9@virtuozzo.com>
References: <20180201180052.32643-1-aryabinin@virtuozzo.com>
 <CA+55aFyLb6utrR_bCRj1JXteuvVchiWrsNNkjM3HetLHNxHx9A@mail.gmail.com> <f5868212-8e79-e7f8-658b-063b8d774db9@virtuozzo.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2018 12:26:16 -0800
X-Google-Sender-Auth: BYMlpztkpY1IwO7MgK_6xEFuuIU
Message-ID: <CA+55aFybz85w0T-ymJKmyUR0hKkOCWVnqAXcVFH5E--uF2x1aQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] compiler.h, kasan: Avoid duplicating __read_once_size_nocheck()
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, Kees Cook <keescook@chromium.org>,
        Eryu Guan <eguan@redhat.com>, Alexander Potapenko <glider@google.com>,
        Chris Metcalf <metcalf@alum.mit.edu>,
        David Laight <David.Laight@aculab.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 1, 2018 at 12:14 PM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 02/01/2018 09:28 PM, Linus Torvalds wrote:
>>
>> Will this go through Andrew's mm tree or what? I can pick it up directly too.
>
> Whatever you'd prefer.

Ok, I just took it directly as-is,

             Linus
