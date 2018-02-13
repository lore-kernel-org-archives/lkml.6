Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965896AbeBMV30 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:29:26 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34594 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965749AbeBMV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:29:25 -0500
X-Google-Smtp-Source: AH8x227/zn5C5n09Vm0DddAMnNlTra0qz7nGjtaw8xRJwFIkWvIhX7xi1SLdWYE7QfkzGvP4kugFTL1Ne9u30NCYD+U=
MIME-Version: 1.0
In-Reply-To: <20180204104946.25559-3-tycho@tycho.ws>
References: <20180204104946.25559-1-tycho@tycho.ws> <20180204104946.25559-3-tycho@tycho.ws>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 13:29:23 -0800
X-Google-Sender-Auth: spjagMC26ffcQgOkrNZKRy4JmnE
Message-ID: <CAGXu5jJLCcmB6MCeOgMntUgrnPycbmM8MBt_CVGXtsrQ+mtf=Q@mail.gmail.com>
Subject: Re: [RFC 2/3] seccomp: hoist out filter resolving logic
To: Tycho Andersen <tycho@tycho.ws>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> Hoist out the nth filter resolving logic that ptrace uses into a new
> function. We'll use this in the next patch to implement the new
> PTRACE_SECCOMP_GET_FILTER_FLAGS command. This is based on an older patch
> that I had sent a while ago; it significantly revamps the get_nth_filter
> logic based on previous suggestions from Oleg.

Is this the same as f06eae831f0c1fc5b982ea200daf552810e1dd55 ? Quick
compare says yes? Either way, please rebase to v4.16-rc1 (or -rc2 in
the future). :)

-Kees

-- 
Kees Cook
Pixel Security
