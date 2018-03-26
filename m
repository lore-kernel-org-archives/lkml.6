Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCZH6f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:58:35 -0400
Received: from exmail.andestech.com ([59.124.169.137]:48437 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZH6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:58:34 -0400
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
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH 0/2] perf: riscv: Preliminary Perf Event Support on RISC-V
Date: Mon, 26 Mar 2018 15:57:53 +0800
Message-ID: <1522051075-6442-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2Q7rrob048911
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the baseline PMU for RISC-V platforms.

To ease the future PMU portings, a guide is also written, containing
perf concepts, arch porting practices and some hints.

Alan Kao (2):
  perf: riscv: preliminary RISC-V support
  perf: riscv: Add Document for Future Porting Guide

 Documentation/riscv/pmu.txt         | 250 +++++++++++++++++++
 arch/riscv/Kconfig                  |  12 +
 arch/riscv/include/asm/perf_event.h |  76 +++++-
 arch/riscv/kernel/Makefile          |   1 +
 arch/riscv/kernel/perf_event.c      | 469 ++++++++++++++++++++++++++++++++++++
 5 files changed, 804 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/riscv/pmu.txt
 create mode 100644 arch/riscv/kernel/perf_event.c

-- 
2.16.2
