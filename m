Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0773C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BE92173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BE92173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeHCNks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:40:48 -0400
Received: from mail.monom.org ([188.138.9.77]:33284 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeHCNks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:40:48 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A12E5500AD8;
        Fri,  3 Aug 2018 13:44:49 +0200 (CEST)
Received: from localhost (ppp-93-104-174-63.dynamic.mnet-online.de [93.104.174.63])
        by mail.monom.org (Postfix) with ESMTPSA id 0C117500937;
        Fri,  3 Aug 2018 13:44:49 +0200 (CEST)
Date:   Fri, 03 Aug 2018 13:44:48 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.145-rt162
Data:   Fri, 03 Aug 2018 11:43:22 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Message-Id: <20180803114449.A12E5500AD8@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.145-rt162 stable release.

This release is just an update to the new stable 4.4.145 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 2ef91c486c0425efec209a9bde6d7baf2b68d572

Or to build 4.4.145-rt162 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.145.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.145-rt162.patch.xz


Enjoy!
   Daniel
