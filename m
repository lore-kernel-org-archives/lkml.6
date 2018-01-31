Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeAaQtU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:49:20 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:50707 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeAaQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:49:17 -0500
X-Google-Smtp-Source: AH8x225DJwjZorj0SUyFI4sjmHUl9q7+w188fd0E8yBj5c1M7W20U0SGxL3p2eUqDWZVMcU4/TVeefYOBjqif6fz0rM=
MIME-Version: 1.0
In-Reply-To: <20180131084918.15267-1-ebiggers3@gmail.com>
References: <94eb2c05a3807b84210560f4a1fd@google.com> <20180131084918.15267-1-ebiggers3@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2018 08:49:16 -0800
X-Google-Sender-Auth: 2JwivGyXDhFlPgKJl5O8rOVAEBg
Message-ID: <CA+55aFwU71orp9s6979j4XpOJ4Sdr2NSpe1b2xgKLy0v8q6vEw@mail.gmail.com>
Subject: Re: [PATCH] devpts: fix error handling in devpts_mntget()
To: Eric Biggers <ebiggers3@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 12:49 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
>
> If devpts_ptmx_path() returns an error code, then devpts_mntget()
> dereferences an ERR_PTR():

Thanks, applied.

            Linus
