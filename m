Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95E20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfAHVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:49:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51324 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfAHVtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:49:10 -0500
Received: from localhost (unknown [66.187.232.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3797F14CCA981;
        Tue,  8 Jan 2019 13:49:06 -0800 (PST)
Date:   Tue, 08 Jan 2019 13:49:04 -0800 (PST)
Message-Id: <20190108.134904.797789678341389884.davem@davemloft.net>
To:     deepa.kernel@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        arnd@arndb.de, y2038@lists.linaro.org, chris@zankel.net,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        isdn@linux-pingi.de, jejb@parisc-linux.org,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        ubraun@linux.ibm.com
Subject: Re: [PATCH v3 0/8] net: y2038-safe socket timestamps 
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190108032657.8331-1-deepa.kernel@gmail.com>
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 08 Jan 2019 13:49:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Mon,  7 Jan 2019 19:26:49 -0800

> The series introduces new socket timestamps that are
> y2038 safe.

Great discussion, but this is definitely net-next material and the net-next
tree is not open at this time.
