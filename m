Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeBHJMS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:12:18 -0500
Received: from mail.monom.org ([188.138.9.77]:44852 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHJMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:12:15 -0500
From: Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.115-rt130
Date: Thu, 08 Feb 2018 10:06:40 +0100
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com,
        Alex Shi <alex.shi@linaro.org>
Message-Id: <20180208091210.C379C50096A@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.115-rt130 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 701115b70ba8e8b20c6cfe689db4c1dd6af3ece9

Or to build 4.4.115-rt130 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.115.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.115-rt130.patch.xz


You can also build from 4.4.113-rt128 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.113-rt128-rt130.patch.xz

Enjoy!
   Daniel
