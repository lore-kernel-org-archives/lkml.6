Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC6B21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550180328;
	bh=cXf20YEaokKHVY4txIXqaEWzc23njuzJzCoaGHIVYHo=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=KKb7GfrKoFOvOyYaNOHYyA7M7g96aUKJQQmTw8ctFo9jEu8m6xxvtqLtfQhISWnc+
	 AckBMKRmRRiZ7G9RbuXEjixUlyKac6Fc65mUdmSPXNazt2U0PD8T0MkQar7Hh999aF
	 LyRtw1zXatXW6gFmbbrfy2Np84v4CiLJAD1vRL+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503350AbfBNViq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503339AbfBNVio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:38:44 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51AC42147C;
        Thu, 14 Feb 2019 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550180324;
        bh=cXf20YEaokKHVY4txIXqaEWzc23njuzJzCoaGHIVYHo=;
        h=Subject:From:To:Cc:Date:From;
        b=vo88IGFUjC3un0tv7CjVeGjM0gDR7oOzlzUWkFbloIva5NBlIDK9lUPwiE1eA+UAS
         WcZTatgYu4xgJTICz57PH27vbefAF/FpPhEDbbLm7WaSg4dY6k+VOQHbe1Dx7NqSL6
         +/qFA/JiFCaqRxMNxzVBzQUgmPpxdX+oZyp+3ILQ=
Message-ID: <1550180322.2498.8.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.134-rt113
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Thu, 14 Feb 2019 15:38:42 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.134-rt113 stable release.

This release is just an update to the new stable 3.18.134 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 7e548d5b688891c3bf17c4ff3ac0ace7dcd140c8

Or to build 3.18.134-rt113 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.134.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.134-rt113.patch.xz


Enjoy!
   
   Tom
