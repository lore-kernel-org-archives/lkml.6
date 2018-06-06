Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeFFAOI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 20:14:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38373 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeFFAOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 20:14:06 -0400
X-Google-Smtp-Source: ADUXVKJPfKLjTVYXQyPmNi+rvt+yyL6Mdtgi5nSXSLrhXmjvGH6uNwhXbnNyGNbXo3nOxE/iUR9R1DsXEUp5e9/EHak=
MIME-Version: 1.0
References: <20180605192157.GG1351649@devbig577.frc2.facebook.com>
In-Reply-To: <20180605192157.GG1351649@devbig577.frc2.facebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Jun 2018 17:13:55 -0700
Message-ID: <CA+55aFzWdPavAPC--MY15RgwvU1QYgF+Uy7rMJmx2Dr3ddJdsQ@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v4.18-rc1
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 12:22 PM Tejun Heo <tj@kernel.org> wrote:
>
> * cgroup uses file modified events to notify certain events.  A rate
>   limiting mechanism is added.

This "explanation" didn't really parse for me at all.

I edited the merge message to something that I think is correct and
made more sense to me.

               Linus
