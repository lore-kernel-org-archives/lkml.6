Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031931AbeBNWul (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:50:41 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:39334 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031852AbeBNWuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:50:39 -0500
X-Google-Smtp-Source: AH8x22513brELF2KO9HSTWPxJ3JUyiavJDM0+LJYLW5ntkHXxnpan04ofHAJtZNHXNs59ZOcVJ+favZT9OT4bH1KgxM=
MIME-Version: 1.0
From: Kees Cook <keescook@google.com>
Date: Wed, 14 Feb 2018 14:50:37 -0800
Message-ID: <CAGXu5j+LVvfdeD4rhTKAQ0PP5s5ysAjNtrfkpcp2sLzwKqbVHw@mail.gmail.com>
Subject: collecting simple benchmark scripts?
To: Shuah Khan <shuah@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>,
        Laura Abbott <labbott@redhat.com>, Tycho Andersen <tycho@tycho.ws>,
        Steven Rostedt <srostedt@redhat.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In a separate thread, some folks were looking for some simple
benchmarks for evaluating various changes to kernel internals (as
opposed to the much more focused things like xfstests). For me, this
has been an area of lore and passed-around scripts, and it seems like
maybe we should have a subdirectory of tools/testing/benchmarks/ or
something to collect these?

(Or maybe this already exists and I've totally missed it?)

I've got at least one micro-benchmark in
tools/testing/selftests/seccomp/seccomp_benchmark.c, and searches show
tools/testing/selftests/vm/gup_benchmark.c too, but I was thinking of
either more generali things more like the famous "kernel build
benchmark" or a wrapper for running hackbench to get some statistics
out of it, etc.

Or, I guess, at least collecting all the micro-benchmarks in some
single place, as they're a bit scattered.

I'm sure I'm not remotely the first person to bring this up, but my
attempts at searches for this have failed.

Thoughts?

-Kees

-- 
Kees Cook
Pixel Security
