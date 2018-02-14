Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031429AbeBNPdK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:33:10 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:55310 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031303AbeBNPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:33:09 -0500
X-Google-Smtp-Source: AH8x227oasTl9r/cUQ9StjTk+duznIHEDzW5eFZBq1xzN4rHrKyU95Mz1T72Vtl6lWeKiXyUt0ke1A==
Date: Wed, 14 Feb 2018 08:33:06 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [RFC 2/3] seccomp: hoist out filter resolving logic
Message-ID: <20180214153306.m3wlmz6zwjqsav36@smitten>
References: <20180204104946.25559-1-tycho@tycho.ws>
 <20180204104946.25559-3-tycho@tycho.ws>
 <CAGXu5jJLCcmB6MCeOgMntUgrnPycbmM8MBt_CVGXtsrQ+mtf=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJLCcmB6MCeOgMntUgrnPycbmM8MBt_CVGXtsrQ+mtf=Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:29:23PM -0800, Kees Cook wrote:
> On Sun, Feb 4, 2018 at 2:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > Hoist out the nth filter resolving logic that ptrace uses into a new
> > function. We'll use this in the next patch to implement the new
> > PTRACE_SECCOMP_GET_FILTER_FLAGS command. This is based on an older patch
> > that I had sent a while ago; it significantly revamps the get_nth_filter
> > logic based on previous suggestions from Oleg.
> 
> Is this the same as f06eae831f0c1fc5b982ea200daf552810e1dd55 ? Quick
> compare says yes? Either way, please rebase to v4.16-rc1 (or -rc2 in
> the future). :)

Yep, there was no tagged tree with that when I did these; I'll do that
for the next version.

Cheers,

Tycho
