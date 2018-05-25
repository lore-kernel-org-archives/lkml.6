Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965330AbeEYJHz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:07:55 -0400
Received: from mail.monom.org ([188.138.9.77]:36802 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964909AbeEYJHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:07:53 -0400
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.132-rt149
Date: Fri, 25 May 2018 11:03:01 +0200
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanusse <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Message-Id: <20180525090752.3616A500BEA@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.132-rt149 stable release.

This release is just an update to the new stable 4.4.132 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 3f39cdf309d8915d1286609cdc20837d3e565e5a

Or to build 4.4.132-rt149 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.132.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.132-rt149.patch.xz


You can also build from 4.4.131-rt148 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.131-rt148-rt149.patch.xz

Enjoy!
   Daniel
