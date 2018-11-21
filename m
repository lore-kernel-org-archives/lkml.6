Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=BODY_SINGLE_WORD,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E69D214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=8chan.co header.i=@8chan.co header.b="Jh/aghbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E69D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=8chan.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeKVAGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:06:43 -0500
Received: from cock.li ([185.100.85.212]:37320 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeKVAGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:06:43 -0500
To:     lkml <linux-kernel@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8chan.co; s=mail;
        t=1542807137; bh=ruW4UFXxVsMKbdPMnmxDaTv+16pA7U93ISteQk0ZEwg=;
        h=To:From:Subject:Date:From;
        b=Jh/aghbTV3EzSFLF0rbHFNhVL5g02k1suSqtNadtHDG6waO+NwUT0hbLBcE6EEtok
         sgfZkkr18xwhtZk6BPnEX0sjEfyN6QJSOBN4r2JCXIo/pmsf3ECyBP4HsavbTaHFp6
         l/BT577X8jgZ/qHnZ/643qy28N8OXZHmj5CEepHAeTH750Anp6tAmOnGP3CflPg3bo
         rfgDFKJ/YUKwc/sWrkPz8vTGR4tQnuyVL0kzCGFUOne/StZVgPJlMnBf2TBmfhjitA
         Bkggv+NHlK4SDOivsLgqpJ1nCY9LhSg+lKQ6e2yjgxFtcD+Ocxc370Z1bIWtQkYPyh
         ljO3CQKuTW0HA==
From:   _ <dotchan@8chan.co>
Subject: help
Message-ID: <8e29f316-78f0-e184-0f7a-66eaba6c09a4@8chan.co>
Date:   Wed, 21 Nov 2018 13:32:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

help
