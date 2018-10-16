Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E093CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF9B208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF9B208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeJPNmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:42:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44138 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeJPNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:42:12 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B1D7012106D92;
        Mon, 15 Oct 2018 22:53:26 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:53:26 -0700 (PDT)
Message-Id: <20181015.225326.526411008919286426.davem@davemloft.net>
To:     dhowells@redhat.com
Cc:     netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Add /proc/net/rxrpc/peers to display
 peer list
From:   David Miller <davem@davemloft.net>
In-Reply-To: <153959946389.27408.16748794272430961849.stgit@warthog.procyon.org.uk>
References: <153959946389.27408.16748794272430961849.stgit@warthog.procyon.org.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 22:53:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Mon, 15 Oct 2018 11:31:03 +0100

> Add /proc/net/rxrpc/peers to display the list of peers currently active.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied.
