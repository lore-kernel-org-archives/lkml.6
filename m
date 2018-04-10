Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeDJUfp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:35:45 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34237 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeDJUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:35:44 -0400
X-Google-Smtp-Source: AIpwx4+s1Ogdp8hJZbuM1tg5IqidOIHs58d1Jn6sRWohCyXAOrPamKLbGagT+xHt/dB6qie20jH/fZffPSb//yEOLhA=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxzkm0ELM4Xa_rkJpsv4hqeFa7yh2Tvkrh_xnhQqZs=Kg@mail.gmail.com>
References: <20180410171227.GA12596@smile.fi.intel.com> <CA+55aFxzkm0ELM4Xa_rkJpsv4hqeFa7yh2Tvkrh_xnhQqZs=Kg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Apr 2018 23:35:43 +0300
Message-ID: <CAHp75VcH0N2BZHaVko3EGWJGk8g_GriCCS_izyjXFSXG81q4rg@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 4.17-1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:22 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 10, 2018 at 10:12 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> This is first batch of Platform Drivers x86 for v4.17 cycle. Due to few
>> duplication the merge will have conflicts which would be resolved by
>> using `git merge -X no-renames ...` followed by choose of our version of
>> two failed one-liner hunks situated in one file.
>
> I'm not sure what git version or flags you are using, but git merges
> it cleanly for me using the standard recursive merge policy.

That's good news.
I'm using whatever is in Debian Unstable (old for less than month) and
what I tried was

% git checkout -b test origin/master
% git merge for-next # our branch for you

It complained to me that file was renamed / deleted and it didn't
resolve conflicts automatically.

-- 
With Best Regards,
Andy Shevchenko
