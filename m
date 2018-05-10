Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeEJTFw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:05:52 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34342 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeEJTFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:05:50 -0400
X-Google-Smtp-Source: AB8JxZoHlFObDR3hNu5Ncftdib+z1A2jKK9HGToMJoKReq8o0UP8LjVrP/FPkt6ueN0JmB1j6AxmK69n5lLrfi8RjCk=
MIME-Version: 1.0
In-Reply-To: <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com> <28df5659605d7b2ace94deca3b831b462183303f.1525964381.git.joe@perches.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 10 May 2018 12:05:48 -0700
X-Google-Sender-Auth: JTsnxZ0dTtt1Y38eAMoe5qHfkrA
Message-ID: <CAGXu5jLk9N9w=CPzw-Gvr3tOOLS8RjwTs-YX=rmbvfQz7EA4dg@mail.gmail.com>
Subject: Re: [PATCH 01/18] kernel: Use pr_fmt
To: Joe Perches <joe@perches.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 8:45 AM, Joe Perches <joe@perches.com> wrote:
> Sometime in the future, it would be useful to convert pr_fmt from a
> default simple define to use a default prefix with KBUILD_MODNAME.
>
> There are files in kernel/ that use pr_<level>, some with an embedded
> prefix, that also do not have a specific pr_fmt define.
>
> Add pr_fmt for those files.
>
> There are some differences in output as some messages are now prefixed
> with their KBUILD_MODNAME.
>
> Miscellanea:
>
> o Align multiline statements to open parenthesis
> o Wrap and realign arguments to 80 columns where sensible
> o Coalesce formats
>
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
