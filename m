Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8353C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC5620883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="zfituxbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfARMTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:19:24 -0500
Received: from cock.li ([185.100.85.212]:52618 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfARMTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:19:24 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1547813962; bh=OZh2KBNvZL7I8VmAMh7eA317aGFG2Qk5trg+g3SL7CM=;
        h=Date:From:To:Cc:Subject:From;
        b=zfituxbpELiMvipv+zyhY+2XtKFyDI3khYVMwUHc5C8aWs9C1KYmnPKoHTQ8x+3a7
         qo45DGtHH0D8fXfVr+5YJhWGaMdbszAXnhPcPygG3hQcHJYT37WeaV64jlpvryS/EW
         4oMNzI4UgcefJHKjbiWD6WvLkTT82TdL9/BVctUTczOIE1O46y1YjCJT3otPQPHrqs
         GYgi9gf4U6XXlZnQJM7LPR5GFX6M+ykHbDMHAxMXW8z9r2QEmN4hbaXlHhGHo7nNzy
         MuXKzY2oWhb9Dx+fW3nUoJF/9iwU8z0+MSNNhvC7vr6TucSQkKmb1FrUjza2//ZoCp
         /uNc7RY64d6pQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jan 2019 12:19:21 +0000
From:   sicevar@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     gentoo-user@lists.gentoo.org, ubuntu-users@lists.ubuntu.com,
        misc@openbsd.org
Subject: GPL Revocation - Slashdot
Message-ID: <f077641621ff6a775229ab9dda6cd4d7@redchan.it>
X-Sender: sicevar@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://slashdot.org/submission/9113350/author-of-program-rescinds-gpl-from-geek-feminists
