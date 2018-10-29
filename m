Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35461C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF75B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF75B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeJ3EzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:55:15 -0400
Received: from mail.monom.org ([188.138.9.77]:50632 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbeJ3EzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:55:15 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id BECE75007F3;
        Mon, 29 Oct 2018 21:05:01 +0100 (CET)
Received: from localhost (ppp-93-104-187-85.dynamic.mnet-online.de [93.104.187.85])
        by mail.monom.org (Postfix) with ESMTPSA id 0CC6B500294;
        Mon, 29 Oct 2018 21:05:01 +0100 (CET)
Date:   Mon, 29 Oct 2018 21:04:59 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.162-rt175
Data:   Mon, 29 Oct 2018 19:58:21 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Message-Id: <20181029200501.BECE75007F3@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.162-rt175 stable release.

This release is just an update to the new stable 4.4.120 version
and no RT specific changes have been made.

This version still qspinlock enabled, because I wanted to update first
to the last stable release and then resend the patch which drops back
to ticket spinlocks.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 795fdff63ee1ad9582e242ab80e9257b64770cef

Or to build 4.4.162-rt175 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.162.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.162-rt175.patch.xz


You can also build from 4.4.157-rt174 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.157-rt174-rt175.patch.xz

Enjoy!
   Daniel
