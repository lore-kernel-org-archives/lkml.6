Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13514C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EBE20684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EBE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeKSNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:21:27 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60252 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:21:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C53B146EB316;
        Sun, 18 Nov 2018 18:59:17 -0800 (PST)
Date:   Sun, 18 Nov 2018 18:59:13 -0800 (PST)
Message-Id: <20181118.185913.65989390344960294.davem@davemloft.net>
To:     firoz.khan@linaro.org
Cc:     sparclinux@vger.kernel.org, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Nov 2018 18:59:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 14 Nov 2018 10:56:27 +0530

> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
 ...

Series applied to sparc-next.
