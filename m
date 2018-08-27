Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C89C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D61208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D61208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kolivas.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeH1DEm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:42 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:61304 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbeH1DEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:42 -0400
Received: from ppp198-198.static.internode.on.net (HELO mine.kolivas.org) ([59.167.198.198])
  by ipmail06.adl6.internode.on.net with ESMTP; 28 Aug 2018 08:45:54 +0930
Received: from hex.localnet (unknown [192.168.1.250])
        by mine.kolivas.org (Postfix) with ESMTP id 3688736004A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:13:05 +1000 (AEST)
From:   Con Kolivas <kernel@kolivas.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] linux-4.18-ck1, Multiple Queue Skiplist Scheduler version 0.173 for linux 4.18
Date:   Tue, 28 Aug 2018 09:15:52 +1000
Message-ID: <3117959.qg1MXgrv07@hex>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Announcing a new -ck release, 4.18-ck1  with the latest version of the 
Multiple Queue Skiplist Scheduler, version 0.173. These are patches designed 
to improve system responsiveness and interactivity with specific emphasis on 
the desktop, but configurable for any workload.

linux-4.18-ck1:
-ck1 patches:
http://ck.kolivas.org/patches/4.0/4.18/4.18-ck1/
Git tree:
https://github.com/ckolivas/linux/tree/4.18-ck

MuQSS only:
Download:
http://ck.kolivas.org/patches/muqss/4.0/4.18/0001-MultiQueue-Skiplist-Scheduler-version-v0.173.patch
Git tree:
https://github.com/ckolivas/linux/tree/4.18-muqss


This is just a resync from 4.17 MuQSS and -ck patches.


Blog: ck-hack.blogspot.com

Enjoy!
お楽しみ下さい

-- 
-ck



