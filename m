Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbeEWPin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:38:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:50234 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932646AbeEWPii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:38:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Message-Id: <7a6786$1a3f5p@orsmga006.jf.intel.com>
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="44154041"
From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 3.18.109-rt102
Date: Wed, 23 May 2018 10:13:19 -0500
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.109-rt102 stable release.

This release is just an update to the new stable 3.18.109 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: c894e719bdbf1b5e52496c4e2c01a793f5b63460

Or to build 3.18.109-rt102 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.109.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.109-rt102.patch.xz


Enjoy!
   
   Tom
