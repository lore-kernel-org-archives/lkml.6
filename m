Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeEQPqm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:46:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751695AbeEQPql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:46:41 -0400
Date: Thu, 17 May 2018 17:46:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v2 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180517154637.GC8586@redhat.com>
References: <20180517151218.12850-1-tycho@tycho.ws>
 <20180517151218.12850-2-tycho@tycho.ws>
 <20180517153323.GA8586@redhat.com>
 <20180517153957.GA3831@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517153957.GA3831@cisco>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17, Tycho Andersen wrote:
>
> > From lockdep pov this loop tries to take the same lock twice or more, it shoul
> > complain.
>
> I didn't, but I guess that's because it's not trying to take the same lock
> twice -- the pointer cur is changing in the loop.

Yes, I see. But this is the same lock for lockdep, it has the same class.

Oleg.
