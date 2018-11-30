Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC473C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5052080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5052080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeLAHxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:53:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59268 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeLAHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:53:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 649D614F0ADB2;
        Fri, 30 Nov 2018 12:42:29 -0800 (PST)
Date:   Fri, 30 Nov 2018 12:42:28 -0800 (PST)
Message-Id: <20181130.124228.979846577878820546.davem@davemloft.net>
To:     abuse@2.abuse.bgcomp.co.uk
Cc:     axboe@kernel.dk, dave@stgolabs.net, keescook@chromium.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, dja@axtens.net,
        linux@dominikbrodowski.net, dri-devel@lists.freedesktop.org,
        edumazet@google.com, federico.vaga@vaga.pv.it,
        geert+renesas@glider.be, deller@gmx.de, corbet@lwn.net,
        kumba@gentoo.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, paul.burton@mips.com, pmladek@suse.com,
        robh@kernel.org, sean.wang@mediatek.com,
        sergey.senozhatsky@gmail.com, shannon.nelson@oracle.com,
        sbrivio@redhat.com, rostedt@goodmis.org, me@tobin.cc,
        makita.toshiaki@lab.ntt.co.jp, willemb@google.com, yhs@fb.com,
        yanjun.zhu@oracle.com
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2007856.n5V9iKLVsV@eth7>
References: <d7c34289-f03a-b641-cc9c-00395306511d@kernel.dk>
        <20181130.123507.1940310466680455876.davem@davemloft.net>
        <2007856.n5V9iKLVsV@eth7>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Nov 2018 12:42:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abuse <abuse@2.abuse.bgcomp.co.uk>
Date: Fri, 30 Nov 2018 20:39:01 +0000

> I assume I will now be barred.

Perhaps, but not because you said fuck.  It would be because you're
intentionally creating a disturbance on the list and making it more
difficult for developers to get their work done and intentionally
creating a distraction and a hostile environment for the discussion at
hand.

That would not be censorship.

There is a big difference.
