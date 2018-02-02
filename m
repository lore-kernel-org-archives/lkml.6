Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBBUeV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:34:21 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33491 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeBBUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:33:53 -0500
X-Google-Smtp-Source: AH8x224cqIRQt5E4+fMsfdVdcWUt67pJ9ttSJ5YnTzjdpi5UOFC33r8OIw3085RHEsPDHbxJIjw4mwGiWnpH/Sx4fXk=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <8647279167c3b14dea07f3585fc6cd9fe2e60b7e.1517571437.git.rgb@redhat.com>
References: <8647279167c3b14dea07f3585fc6cd9fe2e60b7e.1517571437.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2018 15:33:50 -0500
Message-ID: <CAHC9VhTOXcvdVtditYLYpR7LHrab6APUnxuH02hdK8gpDCGneQ@mail.gmail.com>
Subject: Re: [PATCH] audit: update bugtracker and source URIs
To: Richard Guy Briggs <rgb@redhat.com>
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 6:39 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Since the Linux Audit project has transitioned completely over to
> github, update the MAINTAINERS file and the primary audit source file to
> reflect that reality.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  MAINTAINERS    | 1 -
>  kernel/audit.c | 3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 845fc25..fba4875 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2479,7 +2479,6 @@ M:        Paul Moore <paul@paul-moore.com>
>  M:     Eric Paris <eparis@redhat.com>
>  L:     linux-audit@redhat.com (moderated for non-subscribers)
>  W:     https://github.com/linux-audit
> -W:     https://people.redhat.com/sgrubb/audit
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
>  S:     Supported
>  F:     include/linux/audit.h
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 227db99..06964f1 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -38,7 +38,8 @@
>   *       6) Support low-overhead kernel-based filtering to minimize the
>   *          information that must be passed to user-space.
>   *
> - * Example user-space utilities: http://people.redhat.com/sgrubb/audit/
> + * Audit kernel, userspace, documentation and testsuite bugtrackers and
> + * repositories: https://github.com/linux-audit
>   */

Since we've got another week (I don't expect the merge window to close
until *next* weekend), I'm going to be a little more nit-picky than
usual.  Let's change it from "Audit kernel, userspace, documentation
..." to "Audit userspace, documentation, tests, and bug/issue
trackers: ...".

The reason is that while we have a kernel repository there, it isn't
the official repository, it's just a mirror so that we can leverage
the issue tracking and other tools that GitHub provides.  Make sense?

-- 
paul moore
www.paul-moore.com
