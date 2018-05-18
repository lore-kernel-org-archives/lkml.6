Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeERWyb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:54:31 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:39970 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeERWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:54:30 -0400
X-Google-Smtp-Source: AB8JxZpjbstS0lJXgivo4B4gl7bKYe15WqkLnPXEHMJU5agJS8CP/UxWfmQVAQK8bXaOBIWhuIJwnxyPQy+Eja/v2tc=
MIME-Version: 1.0
In-Reply-To: <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com> <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Fri, 18 May 2018 15:54:29 -0700
Message-ID: <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Manoj Gupta <manojgupta@chromium.org>,
        AlistairStrachan <astrachan@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sedat,
Thanks for the report.  We have a fix ready in
https://bugs.llvm.org/show_bug.cgi?id=37512.  Can you report what
version of clang you were using and if earlier versions of clang have
this issue?
Thanks,
~Nick
