Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeDDQSs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:18:48 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:45217 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeDDQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:18:47 -0400
X-Google-Smtp-Source: AIpwx49kRf2/NCNUNQL9RV0LV4OXVq3xz/UOBe4QzLMavdCkN28e/R/geuSbNSuWxfysRfqqBLHXcv/ktBmZlJShgRk=
MIME-Version: 1.0
In-Reply-To: <20180404121326.6eca4fa3@gandalf.local.home>
References: <20180404115310.6c69e7b9@gandalf.local.home> <20180404120002.6561a5bc@gandalf.local.home>
 <CAJWu+orC-1JDYHDTQU+DFckGq5ZnXBCCq9wLG-gNK0Nc4-vo7w@mail.gmail.com> <20180404121326.6eca4fa3@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 4 Apr 2018 09:18:45 -0700
Message-ID: <CAJWu+op5-sr=2xWDYcd7FDBeMtrM9Zm96BgGzb4Q31UGBiU3ew@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add set/clear_current_oom_origin() during allocations
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 9:13 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
[..]
>>
>> Also, I agree with the new patch and its nice idea to do that.
>
> Thanks, want to give it a test too?

Sure, I'll try it in a few hours. I am thinking of trying some of the
memory pressure tools we have. Likely by noon or so once I look at
some day job things :-D

thanks,

- Joel
