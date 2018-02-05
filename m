Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeBESfd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:35:33 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33437 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbeBESfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:35:23 -0500
X-Google-Smtp-Source: AH8x227mlfyCoN69PFrVqHO9MIlaY5QCvse/HC3kR1UZj2MhGJsvMkA35rFPl6nPHXwDznaXMyQvX9lrPDoth7wY+7E=
MIME-Version: 1.0
In-Reply-To: <CA+55aFz=4jx5f0NVes02rtKY9rW+bdEMUdRh0ukK4UPW3UkFeg@mail.gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
 <CA+55aFzyqjGXBjVmb+A7EUJr35a3BdZgYN29dD-KZXzY7k4e6Q@mail.gmail.com>
 <CAOQ4uxi4KrCYAVFbWE=4ptSgpVdPEaDDHPVFvFuHvrhsQ69uTA@mail.gmail.com> <CA+55aFz=4jx5f0NVes02rtKY9rW+bdEMUdRh0ukK4UPW3UkFeg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 5 Feb 2018 20:35:21 +0200
Message-ID: <CAOQ4uxjEBji4G7o6ex1NYtR5jkunYg9kGByVXxiPhTSQBS8Big@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 7:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Feb 5, 2018 at 9:51 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> and hash_32_generic() is just __hash_32() with zero shift.
>
> Right. But that __hash_32() is very expensive and doesn't help.
>
> So the patch as-is doesn't seem to buy anything, and only adds cost.

But my patch doesn't add any __hash_32() call. It was already there.
Anyway, I'll drop the patch.

Thanks,
Amir.
