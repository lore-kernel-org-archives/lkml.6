Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbeEAQs0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:48:26 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:41231 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeEAQsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:48:25 -0400
X-Google-Smtp-Source: AB8JxZoReHx1k0Dx4eq+JsBAW9Zzpu4Cl79CW2Iq6mgwbCfvQ2srB2ucRqeAE0SeYIWBTkAIxvzgOi6l3oCnk9sB5aU=
MIME-Version: 1.0
References: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
 <20180501134020.fonel3x6plea5xdt@treble> <CA+55aFz-11bMkZHWdiiwys32H5jvB4gATvUHT0Vx6pJkFYLb4w@mail.gmail.com>
 <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com>
In-Reply-To: <042668BD-8912-44D4-9CA1-9ABA2F094709@vmware.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 May 2018 16:48:13 +0000
Message-ID: <CA+55aFzXg_bzQd7FO5NAd3GdYuoHeAPyJskV2bPm+HNqnwifFQ@mail.gmail.com>
Subject: Re: Suboptimal inline heuristics due to non-code sections
To: namit@vmware.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 9:39 AM Nadav Amit <namit@vmware.com> wrote:

> Would it be reasonable to remove new-lines in such cases?

Yeah, that may be fine for some of our (already illegible) section crud.

                 Linus
