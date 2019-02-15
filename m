Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1685C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793F4205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404717AbfBOJXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:23:30 -0500
Received: from mail.monom.org ([188.138.9.77]:49910 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbfBOJX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:23:28 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 35736500633;
        Fri, 15 Feb 2019 10:23:26 +0100 (CET)
Received: from localhost (ppp-93-104-181-39.dynamic.mnet-online.de [93.104.181.39])
        by mail.monom.org (Postfix) with ESMTPSA id 227775002CF;
        Fri, 15 Feb 2019 10:23:25 +0100 (CET)
Date:   Fri, 15 Feb 2019 10:23:24 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.174-rt178
Data:   Fri, 15 Feb 2019 09:22:18 -0000
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
Message-Id: <20190215092326.35736500633@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.174-rt178 stable release.

This release is just an update to the new stable 4.4.174 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 9be24e580f9f3125b09794b025b4a856c57f43ec

Or to build 4.4.174-rt178 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.174.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.174-rt178.patch.xz


You can also build from 4.4.169-rt177 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.169-rt177-rt178.patch.xz

Enjoy!
   Daniel
