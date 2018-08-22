Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927ACC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4352B20BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4352B20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeHVVk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbeHVVk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:40:57 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5434A20B6F;
        Wed, 22 Aug 2018 18:15:00 +0000 (UTC)
Date:   Wed, 22 Aug 2018 14:14:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [ANNOUNCE] 4.14.63-rt40
Message-ID: <20180822141458.0b6b6af7@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.14.63-rt40 stable release.


This release is just an update to the new stable 4.14.63 version
and no RT specific changes have been made.

NOTE: There is a known issue with this release. The fix is here:

  http://lkml.kernel.org/r/1534660115.6187.4.camel@gmx.de

I did not apply it to this release because it needs to be added to
v4.16-rt first before it gets backported. Feel free to apply it
yourself if you have any concerns.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: da6bee3cef4af60566dc56f3d48fce0b18165107


Or to build 4.14.63-rt40 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt40.patch.xz




Enjoy,

-- Steve

