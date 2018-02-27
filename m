Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeB0QQf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:16:35 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:34018 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752603AbeB0QQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:16:18 -0500
Date: Tue, 27 Feb 2018 09:53:33 -0600
From: Julia Cartwright <julia@ni.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Carsten Emde" <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Alex Shi <alex.shi@linaro.org>
Subject: [ANNOUNCE] 4.9.84-rt62
Message-ID: <20180227155333.GV951@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=550 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802270199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.9.84-rt62 stable release.

This release is just an update to the new stable 4.9.84 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: be42cd02846a611af533103a3f4b6a7d8c592f49

Or to build 4.9.84-rt62 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.84.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.84-rt62.patch.xz

Enjoy!
    Julia
