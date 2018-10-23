Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A51C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB88D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB88D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJWK7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:59:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39930 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:59:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 42D03146CC8C2;
        Mon, 22 Oct 2018 19:37:53 -0700 (PDT)
Date:   Mon, 22 Oct 2018 19:37:52 -0700 (PDT)
Message-Id: <20181022.193752.2253158634087979055.davem@davemloft.net>
To:     jjk@jjacky.com
Cc:     netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: bpfilter: Set user mode helper's command line
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181020173957.31239-3-jjk@jjacky.com>
References: <CAADnVQ+xFfwV67BRXD0epoTwKz54W3mcYHXVWBd1iWb94p+zpg@mail.gmail.com>
        <20181020173957.31239-1-jjk@jjacky.com>
        <20181020173957.31239-3-jjk@jjacky.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 19:37:53 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aFrom: Olivier Brunel <jjk@jjacky.com>
Date: Sat, 20 Oct 2018 19:39:57 +0200

> Signed-off-by: Olivier Brunel <jjk@jjacky.com>

Applied.
