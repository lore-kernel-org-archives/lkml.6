Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC75C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513FC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfAQXPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:15:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47966 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:15:19 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkGsX-0000xN-B2; Fri, 18 Jan 2019 00:15:17 +0100
Message-Id: <20190117231416.111952141@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 18 Jan 2019 00:14:16 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [patch 0/9] treewide: Cleanup recently added license mess
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently added files or recently added SPDX license identifiers introcuded
license conflicts due to contradicting SPDX license identifiers and boiler
plate text or sloppy license notices.

That's really sad. Quite some people have put a lot of effort into cleaning
up the licensing mess and provided detailed documentation.

It's about time that everyone in the community understands that licensing
is not just an annoyance. It's a really important part of the project and
has legal implication even on the personal level.

The following series addresses recently added crimes. The patches are in a
series but are indenpendent of each other so they are intended to be
applied by the relevant maintainers after thorough review.

Unfortunately we don't have a consistency scanner at the moment. That's a
non trivial problem as the license mess throughout the kernel is horrible
in general. I'm working on a scanner bot which will at least catch newly
added SPDX related inconsistencies. But that will take a while.

Thanks,

	tglx

8<------------
 block/blk-mq-debugfs-zoned.c        |    2 --
 crypto/aegis.h                      |    7 +------
 crypto/aegis128.c                   |    6 +-----
 crypto/aegis128l.c                  |    6 +-----
 crypto/aegis256.c                   |    6 +-----
 crypto/morus1280.c                  |    6 +-----
 crypto/morus640.c                   |    6 +-----
 drivers/vfio/pci/trace.h            |    6 +-----
 drivers/vfio/pci/vfio_pci_nvlink2.c |    6 +-----
 fs/ceph/quota.c                     |   13 -------------
 fs/cifs/trace.c                     |   10 ----------
 fs/cifs/trace.h                     |   10 ----------
 include/crypto/morus1280_glue.h     |    7 +------
 include/crypto/morus640_glue.h      |    7 +------
 include/crypto/morus_common.h       |    7 +------
 tools/bpf/bpftool/json_writer.c     |    7 +------
 tools/bpf/bpftool/json_writer.h     |    7 +------
 17 files changed, 13 insertions(+), 106 deletions(-)



