Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDQUfb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:35:31 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:43418 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeDQUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:35:29 -0400
X-Google-Smtp-Source: AIpwx4+91Sqpdr5fuiADDvLAoNEbgUnYdHmTUanNnhx7s6i9Fj3oycx/Gl9xa5/wCfS24QncByzvexINFSvG6LFA7KI=
MIME-Version: 1.0
In-Reply-To: <1523954340-8708-2-git-send-email-alankao@andestech.com>
References: <1523954340-8708-1-git-send-email-alankao@andestech.com> <1523954340-8708-2-git-send-email-alankao@andestech.com>
From: Alex Solomatnikov <sols@sifive.com>
Date: Tue, 17 Apr 2018 13:35:27 -0700
Message-ID: <CAJ2AOiP1-TnSRdrLxowQ7DqzxoBYENfbO1ZR5A0_kwzLJ0WztA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf: riscv: preliminary RISC-V support
To: Alan Kao <alankao@andestech.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hu <nickhu@andestech.com>, Greentime Hu <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 1:38 AM, Alan Kao <alankao@andestech.com> wrote:

> +static inline void write_counter(int idx, u64 value)
> +{
> +       /* currently not supported */
> +}

CSR writes can be emulated: https://github.com/riscv/riscv-pk/pull/98

Or at least write_counter() should have BUG() or WARN_ONCE() or
something like that.
