Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932076AbeCIOAN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:00:13 -0500
Received: from mail.monom.org ([188.138.9.77]:52752 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeCIOAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:00:12 -0500
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.120-rt135
Date: Fri, 09 Mar 2018 14:55:34 +0100
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Alex Shi <alex.shi@linaro.org>
Message-Id: <20180309140010.A0B88500C74@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.120-rt135 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 91db57e54eb9be1560454d6a370d67847b05735f

Or to build 4.4.120-rt135 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.120.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.120-rt135.patch.xz


You can also build from 4.4.115-rt130 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.115-rt130-rt135.patch.xz

Enjoy!
   Daniel
