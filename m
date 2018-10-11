Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3172086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3172086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeJKMxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:53:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48956 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeJKMxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:53:43 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E51412130EB1;
        Wed, 10 Oct 2018 22:28:09 -0700 (PDT)
Date:   Wed, 10 Oct 2018 22:28:08 -0700 (PDT)
Message-Id: <20181010.222808.4343784814669316.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/10] rxrpc: Fix packet reception code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
References: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 10 Oct 2018 22:28:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 08 Oct 2018 23:47:18 +0100

> Here are a set of patches that prepares for and fix problems in rxrpc's
> package reception code.  There serious problems are:
 ...
> The second patch fixes (A) - (C); the third patch renders (B) and (C)
> non-issues by using the recap_rcv hook instead of data_ready - and the
> final patch fixes (D).  That last is the most complex.
> 
> The preparatory patches are:
 ...
> And then there are three main patches - note that these are mixed in with
> the preparatory patches somewhat:
 ...
> The patches are tagged here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
> 	rxrpc-fixes-20181008

Pulled, thanks David.
