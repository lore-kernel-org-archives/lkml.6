Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDMWlf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 18:41:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43379 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeDMWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 18:41:33 -0400
X-Google-Smtp-Source: AIpwx49GFbWJKzxxS4oM0mC1IRSGYoEJ+RWhXBEZH2EopktD+kFpx8U7mvuC5OwO+BMZxuTikACOkcNrHpjJMUhuRig=
MIME-Version: 1.0
In-Reply-To: <87tvsrjai0.fsf@xmission.com>
References: <20180404115311.725-1-alban@kinvolk.io> <87tvsrjai0.fsf@xmission.com>
From: Djalal Harouni <tixxdz@gmail.com>
Date: Sat, 14 Apr 2018 00:41:31 +0200
Message-ID: <CAEiveUf5LWpvA-QMm3eYr9yFgUjwyQdkk-WVptze9m_EfbGMwg@mail.gmail.com>
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc
 mounts when not fully visible
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: Alban Crequy <alban.crequy@gmail.com>, Alban Crequy <alban@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>, Iago Lopez Galeiras <iago@kinvolk.io>,
        Stephen J Day <stephen.day@docker.com>,
        Michael Crosby <crosbymichael@gmail.com>,
        Jess Frazelle <acidburn@microsoft.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Daniel J Walsh <dwalsh@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 4:45 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
[...]
>
> The only option I have seen proposed that might qualify as something
> general purpose and simple is a new filesystem that is just the process
> directories of proc.  As there would in essence be no files that would
> need restrictions it would be safe to allow anyone to mount without
> restriction.
>
Eric, there is a series for this:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1533642.html

patch on top for pids:
https://github.com/legionus/linux/commit/993a2a5b9af95b0ac901ff41d32124b72ed676e3

it was reviewed, and suggestions were integrated from Andy and Al Viro
feedback, thanks. It works on Debian, Ubuntu and others, not on Fedora
due to bug with dracut+systemd.

I do not have time to work on it now, anyone can just pick them.

Thanks!


-- 
tixxdz
