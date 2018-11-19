Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844C020684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844C020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeKSNVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:21:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60274 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:21:32 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A33A9146EDBBD;
        Sun, 18 Nov 2018 18:59:22 -0800 (PST)
Date:   Sun, 18 Nov 2018 18:59:22 -0800 (PST)
Message-Id: <20181118.185922.1427491199237345438.davem@davemloft.net>
To:     sabyasachi.linux@gmail.com
Cc:     khandual@linux.vnet.ibm.com, jrdr.linux@gmail.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] arch/sparc: Use kzalloc_node
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
References: <5bdd3128.1c69fb81.4bd46.f7ce@mx.google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Nov 2018 18:59:22 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Sat, 3 Nov 2018 10:54:52 +0530

> Replaced kmalloc_node + memset with kzalloc_node
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Applied.
