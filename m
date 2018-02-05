Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbeBEShn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:37:43 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:38410 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbeBEShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:37:06 -0500
X-Google-Smtp-Source: AH8x226Bk418vXr3ctIgkIO5YZ6eDCmd5Y8WLmw+KpqPow9KNOs8vS9hGI+WgC32GAdlsEkfvbwUQRD899evHR90O14=
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjEBji4G7o6ex1NYtR5jkunYg9kGByVXxiPhTSQBS8Big@mail.gmail.com>
References: <1517851938-5892-1-git-send-email-amir73il@gmail.com>
 <CA+55aFzyqjGXBjVmb+A7EUJr35a3BdZgYN29dD-KZXzY7k4e6Q@mail.gmail.com>
 <CAOQ4uxi4KrCYAVFbWE=4ptSgpVdPEaDDHPVFvFuHvrhsQ69uTA@mail.gmail.com>
 <CA+55aFz=4jx5f0NVes02rtKY9rW+bdEMUdRh0ukK4UPW3UkFeg@mail.gmail.com> <CAOQ4uxjEBji4G7o6ex1NYtR5jkunYg9kGByVXxiPhTSQBS8Big@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 10:37:04 -0800
X-Google-Sender-Auth: bpKkWsJDjl991iWbSTwtO_t0xX8
Message-ID: <CA+55aFxi6KehpF-CqSPwoR2m_0k3Gn=hVYW8i_QH5npBYMRKOw@mail.gmail.com>
Subject: Re: [RFC][PATCH] <linux/stringhash.h>: fix end_name_hash() for 64bit long
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:35 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>
> But my patch doesn't add any __hash_32() call. It was already there.

Oh, duh. My bad. It was indeed there already.

Let me go back and look at the history of this thing, it's changed
several times, and it looks like George Spelvin (not his real name)
isn't on his old email address.

             Linus
