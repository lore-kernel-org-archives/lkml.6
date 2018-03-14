Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELs95bsTI3qVa5GIDVJeitjctB66w5znzvuRxjaF4DVWfE4iNE1lO4A1q4xwM6JiOi6Em+XU
ARC-Seal: i=1; a=rsa-sha256; t=1521062684; cv=none;
        d=google.com; s=arc-20160816;
        b=eYNtiJhpymweDxLkWtvORVLtl7uaY1RiUV/lWeZRXBlKi1UPOEgQJMVOXbM73AYQEq
         BiUwVwGdjRqM68solSTSkl1FPNdzHFmvV3R8dL0Im7zsSzDU6AyI6B5Tt0eiH42XFGPP
         PFS0CW0NnmwiHiEGb6GjomrfwSrUjvoxyyTo7Er1t6vT6sKjgzvy3lUMCA7yktRBPcxh
         gFSwg16yBxW5TV//Ua2MhiUNYE5k92FzwxIJbrzee8hftCkGLY9aiybwEanFuqt8ujYu
         h3114+UH5Fy92r+iC3EzYd+MC3ohg7bk2f1xadvri/d03l05jT08V2DyVV9TOBAjwj8G
         aCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id
         :arc-authentication-results;
        bh=dpBIE/HNyrf134+BLHWbzO3alEnxDJjrnYWiXRkF9e8=;
        b=Ph44ZZEdohOyzfgISzpwGEhiGKoPrKIz4Tejh1W0iR40HIuZvDqpRuhr9hjVn3WIXS
         P1/01IjB6RlnoF6J0yY5eUoL9NY6QevcFNDYtdFQ4cNCZzmfWVSKvB20UP2EzDX8pmoh
         Bx9e16FDRuWSMO7lzsNMbM0B31TKeWBrt8droJii3KfY+YC9Mp5HyvADfaLEFQYyx3hg
         ux+m9BB38U/m+h641Lkes5cRDWq90t9X4pTQclICuBi1squDy9Ng9XRxxTPnFuwQ0oCO
         F5IxD1EpihBs+ZQd4Y/hT8hzREoKUGlQAoCud+nvfSTCo8eawfO983K8R93biB21xIle
         TXSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180314211515.429128440@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 14 Mar 2018 22:15:15 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 0/4] genirq: Clean up license information
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949825957172254?=
X-GMAIL-MSGID: =?utf-8?q?1594949825957172254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following patch series cleans up the licensing information in the
generic irq subsystem.

  * Replace boiler plate language and sloppy references with SPDX

  * Add missing SPDX identifiers to files with no license reference

  * Use the proper tag format

While at it clean up the top of file comments by removing pointless
references to the filename itself and condense the information where
appropriate.

Thanks,

	tglx

---
 autoprobe.c    |    2 --
 chip.c         |   10 ++++------
 cpuhotplug.c   |    5 +----
 debugfs.c      |    8 +++-----
 devres.c       |    1 +
 dummychip.c    |    1 +
 generic-chip.c |    1 +
 handle.c       |    8 +++-----
 ipi.c          |    3 +--
 irq_sim.c      |   10 ++--------
 irqdesc.c      |    6 +++---
 irqdomain.c    |    2 ++
 manage.c       |    3 +--
 matrix.c       |    8 +++-----
 msi.c          |    5 +----
 pm.c           |    3 +--
 proc.c         |    2 --
 resend.c       |    2 --
 spurious.c     |    2 --
 timings.c      |   13 +++----------
 20 files changed, 31 insertions(+), 64 deletions(-)
