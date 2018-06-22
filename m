Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49EDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5484A2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5484A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeFVISd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:18:33 -0400
Received: from mail.monom.org ([188.138.9.77]:51248 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbeFVISb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:18:31 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id BE082500BA9;
        Fri, 22 Jun 2018 10:18:29 +0200 (CEST)
Received: from localhost (ppp-93-104-188-116.dynamic.mnet-online.de [93.104.188.116])
        by mail.monom.org (Postfix) with ESMTPSA id 20BB450051C;
        Fri, 22 Jun 2018 10:18:29 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.138-rt155
Date:   Fri, 22 Jun 2018 10:13:04 +0200
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
Message-Id: <20180622081829.BE082500BA9@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.138-rt155 stable release.

This release is just an update to the new stable 4.4.137 version
and no RT specific changes have been made.

As turns out, it is not a ghost I am hunting:

https://ci-rt.linutronix.de/RT-Test/histogram.jsp?cyclictest=517&id=144

So get this spike pops up under load on the CI test farm and also on
my local test computer. Though the only problem is, that it doesn't
show up when tracing is enabled. So if someone gets hold of a trace
please share it!

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: f9dc938fce05dbf24c1a7132cc3248b2799c94b7

Or to build 4.4.138-rt155 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.138.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.138-rt155.patch.xz


You can also build from 4.4.137-rt154 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.137-rt154-rt155.patch.xz

Enjoy!
   Daniel
