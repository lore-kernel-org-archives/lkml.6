Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeDBMeP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 08:34:15 -0400
Received: from exmail.andestech.com ([59.124.169.137]:59714 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbeDBMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 08:34:12 -0400
Date: Mon, 2 Apr 2018 20:34:03 +0800
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, "Namhyung Kim" <namhyung@kernel.org>,
        Alex Solomatnikov <sols@sifive.com>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-riscv@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] perf: riscv: Preliminary Perf Event Support on
 RISC-V
Message-ID: <20180402123403.GA30097@andestech.com>
References: <1522672284-29593-1-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1522672284-29593-1-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w32CT1cr097414
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the lack of version prefix in the title.  This patchset should be
version 2.

On Mon, Apr 02, 2018 at 08:31:22PM +0800, Alan Kao wrote:
> This implements the baseline PMU for RISC-V platforms.
> 
> To ease future PMU portings, a guide is also written, containing
> perf concepts, arch porting practices and some hints.
> 
> Changes in v2:
>  - Fix the bug reported by Alex, which was caused by not sufficient
>    initialization.  Check https://lkml.org/lkml/2018/3/31/251 for the
>    discussion.
> 
> Alan Kao (2):
>   perf: riscv: preliminary RISC-V support
>   perf: riscv: Add Document for Future Porting Guide
> 
>  Documentation/riscv/pmu.txt         | 249 +++++++++++++++++++
>  arch/riscv/Kconfig                  |  12 +
>  arch/riscv/include/asm/perf_event.h |  76 +++++-
>  arch/riscv/kernel/Makefile          |   1 +
>  arch/riscv/kernel/perf_event.c      | 468 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 802 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/riscv/pmu.txt
>  create mode 100644 arch/riscv/kernel/perf_event.c
> 
> -- 
> 2.16.2
> 
