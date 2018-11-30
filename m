Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FFCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46BF20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46BF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLAI6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:58:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLAI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:58:52 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E21A14F245CB;
        Fri, 30 Nov 2018 13:48:09 -0800 (PST)
Date:   Fri, 30 Nov 2018 13:48:08 -0800 (PST)
Message-Id: <20181130.134808.1785785556132211918.davem@davemloft.net>
To:     jarkko.sakkinen@linux.intel.com
Cc:     James.Bottomley@HansenPartnership.com, dave@stgolabs.net,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20181130214405.GG23772@linux.intel.com>
References: <20181130205521.GA21006@linux.intel.com>
        <1543611662.3031.20.camel@HansenPartnership.com>
        <20181130214405.GG23772@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Nov 2018 13:48:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 30 Nov 2018 13:44:05 -0800

> On Fri, Nov 30, 2018 at 01:01:02PM -0800, James Bottomley wrote:
>> No because use of what some people consider to be bad language isn't
>> necessarily abusive, offensive or degrading.  Our most heavily censored
>> medium is TV and "fuck" is now considered acceptable in certain
>> contexts on most channels in the UK and EU.
> 
> This makes following the CoC extremely hard to a non-native speaker as
> it is not too explicit on what is OK and what is not. I did through the
> whole thing with an eye glass and this what I deduced from it.

It would be helpful if you could explain what part of the language
is unclear wrt. explaining how CoC does not apply to existing code.

That part seems very explicit to me.
