Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0ABC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991FF20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991FF20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLIGLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:11:35 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:58895 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbeLIGLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:11:35 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4941973|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.DUUKKgX_1544335892;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.DUUKKgX_1544335892)
          by smtp.aliyun-inc.com(10.194.97.246);
          Sun, 09 Dec 2018 14:11:32 +0800
Date:   Sun, 9 Dec 2018 14:11:32 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     linux-kernel@vger.kernel.org
Subject: some to support pm_trace
Message-ID: <20181209061132.GA28069@AExdroid03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is PM_TRACE for X86 use RTC register, which can debug suspend
convenient.
recently i want to use it with arm. is there a subsystem to support it.
