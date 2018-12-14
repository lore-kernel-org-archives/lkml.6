Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5D0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EED2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeLNXYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:24:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36618 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNXY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:24:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 451EB14E0AB81;
        Fri, 14 Dec 2018 15:24:27 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:24:24 -0800 (PST)
Message-Id: <20181214.152424.610334997107326314.davem@davemloft.net>
To:     deepa.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        arnd@arndb.de, y2038@lists.linaro.org, chris@zankel.net,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        isdn@linux-pingi.de, jejb@parisc-linux.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com, tglx@linutronix.de,
        ubraun@linux.ibm.com, linux-afs@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 0/8] net: y2038-safe socket timestamps 
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181211202520.16799-1-deepa.kernel@gmail.com>
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 15:24:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 11 Dec 2018 12:25:12 -0800

> The series introduces new socket timestamps that are
> y2038 safe.

Please address Willem's feedback, thank you.
