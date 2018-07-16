Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827320BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1827320BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeGPQnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:43:09 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:54928 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPQnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:43:09 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 12:43:09 EDT
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1ff5zt-0001cU-00; Mon, 16 Jul 2018 16:05:13 +0000
Date:   Mon, 16 Jul 2018 12:05:13 -0400
From:   Rich Felker <dalias@libc.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: cpu_no_speculation omissions?
Message-ID: <20180716160513.GA6080@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least the Centerton (late-generation Bonnell uarch) Atom family is
omitted from the cpu_no_speculation table added by commit fec9434a12f3
to arch/x86/kernel/cpu/common.c. Is this intentional? Would a patch
adding it and possibly other omissions be welcome?

Rich
