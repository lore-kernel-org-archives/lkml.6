Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE858C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0462089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="tqmln9tE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0462089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeJAKnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:43:04 -0400
Received: from cock.li ([185.100.85.212]:42772 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeJAKnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:43:04 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538366837; bh=rTyiVli/eTn3dtIjLoaqgL5Ngy7+KyJp9RXWevzHqhk=;
        h=Date:From:To:Subject:From;
        b=tqmln9tEV7HgebqivHLKiJMH8gtE5bI1f2RRoyqR8/36wOqUoY2SM5GePPNHeQNYx
         S4mohctjDA0PhlwbnSujM80bmbwqO6upnKJkij88Xw3Np/qLOJoa6cCubJ75GCOawl
         ZjzsFbGW8KDITpopfr/XZ9pApYSZBz04Ex8bf3pS1Cg/KRGt6zP8AQkB5dJ7xjiNRt
         MMzAksdzHcBtFTU6lpTCu+TtXSsbuisVTa19+9rRNKSnCsi4hb9mM0iGogQ4YCUo5a
         hd6oqyj1BB5zIZsOqLhDdqtyB2m7/6X9ohWll/8plEsexiW8pOSDGbaT9WUKd9pY7s
         D77FB0QyteAtQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 04:07:17 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: "You are easily replacable" Bruce Peren's message to past
 contributors.
Message-ID: <12720693a2076d2ee310b008f01f9751@redchan.it>
X-Sender: freedomfromruin@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"You are easily replacable" Bruce Peren's message to past contributors.:


"Any actual kernel developers who leave will be replaced by one of the 
other 4000 active this year. If they have been vociferous about their 
rights to entirely unlimited conduct (and all of the side-issues that 
seem to come with that) it may be that the folks on the kernel mailing 
list are already tired of them and won't miss them."

https://news.slashdot.org/comments.pl?sid=12682608&cid=57394936
