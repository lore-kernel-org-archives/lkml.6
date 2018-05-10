Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeEJVRP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:17:15 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:37286 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752078AbeEJVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:17:13 -0400
Date: Thu, 10 May 2018 16:16:31 -0500
From: Julia Cartwright <julia@ni.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [ANNOUNCE] 4.9.98-rt76
Message-ID: <20180510211631.GA1063@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.9.98-rt76 stable release.

This release is just an update to the new stable 4.9.98 version
and no RT specific changes have been made.

Expect a 4.9.98-rt77-rc1 with backports from rt-devel soon.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: bc64e52891b8b9e56b19cbb800a1b8c415df13e8

Or to build 4.9.98-rt76 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.98.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.98-rt76.patch.xz

Enjoy!
    Julia
