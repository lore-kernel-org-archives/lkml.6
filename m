Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 20E2EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C124D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C124D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755258AbeFNTKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:10:04 -0400
Received: from mail.monom.org ([188.138.9.77]:42010 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754660AbeFNTKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:10:02 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 6882950047A;
        Thu, 14 Jun 2018 21:10:01 +0200 (CEST)
Received: from localhost (ppp-83-171-155-144.dynamic.mnet-online.de [83.171.155.144])
        by mail.monom.org (Postfix) with ESMTPSA id CB452500181;
        Thu, 14 Jun 2018 21:10:00 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.137-rt154
Date:   Thu, 14 Jun 2018 21:02:51 +0200
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
Message-Id: <20180614191001.6882950047A@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.137-rt154 stable release.

This release is just an update to the new stable 4.4.137 version
and no RT specific changes have been made.

I am not sure if I am hunting a ghost. During testing on the CI
testfarm, a spike of around 400us popped up on a x86_64 box
(*). Fortunately, I have the same CPU for testing at home and I
tried very hard to reproduce it. Even Steven was helping out for
setting up the test correctly. But so far I haven't seen it again.

(*) https://ci-rt.linutronix.de/RT-Test/kb_details.jsp?id=139&b_id=5234&bt_id=382

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 74e9e457a9fce5f4d6723ad7f5331ab0951d485a

Or to build 4.4.137-rt154 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.137.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.137-rt154.patch.xz


You can also build from 4.4.131-rt148 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.131-rt148-rt154.patch.xz

Enjoy!
   Daniel
