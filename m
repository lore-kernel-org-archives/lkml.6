Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BBBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A9220870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544738599;
	bh=TGIIEKIj1Eo16LtviyDATImfpZYQv60QUIs+Kr3c5zw=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=kb19yz359g+2YH8K0x0gmzAhFxtG/JJ3XCDutQrsoBIg3Ifa/OcZGJ/bZIUYPJEA2
	 2z2y9Bf258aGxuyr4ImcGnutcn+CHe0/fMSMrYVFvya9EKHNusOAvQ0umlUYfqxJ6Z
	 5aPco3SWoD9TYcTYhQ0/TpopFZbx5Iy7A/MCPr5g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A9220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeLMWDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMWDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:03:18 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F116520811;
        Thu, 13 Dec 2018 22:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544738597;
        bh=TGIIEKIj1Eo16LtviyDATImfpZYQv60QUIs+Kr3c5zw=;
        h=Subject:From:To:Cc:Date:From;
        b=kOx9FDHRBPLa7Uz9Agv2DupwfNjFW5qr0lrM5fviMGjW1/nspCDoXqottTeZBfAOB
         SZImLwqbPXiNfICBWX0cPy2xA6hu3Kkk69ReCdk0ZLTKmKyGtetA3GtuWBx0If9/Zh
         RSz/cfk0KU/ruBjZkqCdcxJGXLf6PVE54aX37mqA=
Message-ID: <1544738596.10497.5.camel@kernel.org>
Subject: [ANNOUNCE] 3.18.129-rt110
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
Date:   Thu, 13 Dec 2018 16:03:16 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 3.18.129-rt110 stable release.

This release is just an update to the new stable 3.18.129 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 9447e39d7222edcc6b3c063cd8e189a4f6a03f46

Or to build 3.18.129-rt110 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.129.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.129-rt110.patch.xz


Enjoy!
   
   Tom
