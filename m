Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeFDI5c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:57:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45754 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeFDI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:57:30 -0400
X-Google-Smtp-Source: ADUXVKI08MClwJfVbnvIOV3mcS84ZyBgcKmyoT/s7jjuvAXHO1Nbl4LSpXLlWugsRaJFcqS2HIMz3d2LezT3jY/Mdvc=
MIME-Version: 1.0
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com> <20180604065238.GE19202@dhcp22.suse.cz>
 <CAHCio2iCdBU=xqEGqUrmc-ere-BhiS1AU052L4GfphbDPvOPqQ@mail.gmail.com>
In-Reply-To: <CAHCio2iCdBU=xqEGqUrmc-ere-BhiS1AU052L4GfphbDPvOPqQ@mail.gmail.com>
From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date: Mon, 4 Jun 2018 16:57:17 +0800
Message-ID: <CAHCio2jufEO7D4AT89URi+QWYJRMXyUo0-PwobcJzm0iLUnEzQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
To: mhocko@kernel.org
Cc: akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal

> I have earlier suggested that you split this into two parts. One to add
> the missing information and the later to convert it to a single printk
> output.

I'm sorry I do not get your point.  What do you mean the missing information?

> but it still really begs an example why we really insist on a single
> printk and that should be in its own changelog.

Actually , I just know that we should avoid the interleaving messages
in the dmesg.
But I don't know how to reproduce this issue.  I think I can just
recount this issue in
the changelog.

Thanks
