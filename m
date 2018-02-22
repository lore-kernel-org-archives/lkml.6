Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBVEdC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 23:33:02 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:40962 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeBVEdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 23:33:00 -0500
X-Google-Smtp-Source: AG47ELuZ5h4t2iciiCJMz6gIrowtj5gEBlKBBDZaehCgD/M6oVKo6lmrbq7vmZaFR03UvCxctbaaUvBGQb+VwU+JBb0=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2v9s8A8u+aRYgkQJL+TBmEauwuyFzPb_gnvU=1ZkntRA@mail.gmail.com>
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com> <CAK8P3a2v9s8A8u+aRYgkQJL+TBmEauwuyFzPb_gnvU=1ZkntRA@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 22 Feb 2018 10:02:59 +0530
X-Google-Sender-Auth: tMyf89GSiVcTKkypU7jg94B0rzQ
Message-ID: <CAOh2x=kyFCmvMTx=YwSv-bnQb6uiTzwHuJzNKigu6FyThEGxHA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bhupesh Sharma <bhsharma@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bhupesh.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 4:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Note that when referencing a commit, it's best to abbreviate the commit
> ID to the first 12 characters like "e1a50de37860". You can also a line like
>
> Fixes: e1a50de37860 ("arm64: cputype: Silence Sparse warnings")
>
> which is the standard format to describe such regressions.

Right and this can be automated a bit as well. The procedure is
described in:

Documentation/process/submitting-patches.rst

You can update your .gitconfig file and then use the --pretty=<...>
argument to `git log` or `git show` commands.

--
viresh
