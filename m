Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034338AbeEXSoI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030220AbeEXSoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:44:07 -0400
Date: Thu, 24 May 2018 14:44:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to
 have_filed_random_ptr_key
Message-ID: <20180524144405.10325ba3@gandalf.local.home>
In-Reply-To: <20180523104037.GD15312@amd>
References: <20180515100558.21df515e@gandalf.local.home>
        <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
        <20180515145744.3bdcbbe9@gandalf.local.home>
        <20180523104037.GD15312@amd>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 12:40:37 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> OTOH... fixing theoretical races is nice, but probably should not go
> to stable?

It also improves the performance of the hot path.

-- Steve
