Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED1EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3A20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeJ3FGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:06:35 -0400
Received: from mail.monom.org ([188.138.9.77]:50754 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbeJ3FGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:06:35 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 15A825007F3;
        Mon, 29 Oct 2018 21:16:19 +0100 (CET)
Received: from localhost (ppp-93-104-187-85.dynamic.mnet-online.de [93.104.187.85])
        by mail.monom.org (Postfix) with ESMTPSA id C5361500294;
        Mon, 29 Oct 2018 21:16:18 +0100 (CET)
From:   Daniel Wagner <wagi@monom.org>
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
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/2] Linux v4.4.162-rt176-rc1
Date:   Mon, 29 Oct 2018 21:16:15 +0100
Message-Id: <20181029201617.24733-1-wagi@monom.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch v4.4.162-rt176-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2018-11-05.

Enjoy,

-- Daniel


Daniel Wagner (2):
  x86/kconfig: Fall back to ticket spinlocks
  Linux 4.4.162-rt176-rc1

 arch/x86/Kconfig | 1 -
 localversion-rt  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.14.4
