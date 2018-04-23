Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeDXBsr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:48:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:4250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932665AbeDXBsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:48:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Message-Id: <ca5293$1f24cp@fmsmga001.fm.intel.com>
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,320,1520924400";
   d="scan'208";a="49353113"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 3.18.104-rt101
Date: Mon, 23 Apr 2018 15:10:33 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>, Alex Shi <alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.104-rt101 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 35651514fed4fd79232b3085990514aeef908266

Or to build 3.18.104-rt101 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.104.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.104-rt101.patch.xz


Enjoy!
   
   Tom
