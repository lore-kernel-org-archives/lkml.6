Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F6C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9554D206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="STuGRrJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9554D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeJABR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:17:56 -0400
Received: from cock.li ([185.100.85.212]:56550 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728427AbeJABRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:17:55 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538333024; bh=1FVktq3M71bvJ8fdn30853yR/JgVbp6s0GLb3vw03to=;
        h=Date:From:To:Subject:From;
        b=STuGRrJ6gXH5tJylLlpwHu+UZrH/RpvBmxAFm7JsDnyycapgSkv4IGX/j3X9EJvex
         q45gcOFBqUuVZDufXKqlHSv5XaNRZfwTPjQDEdu9Ag3Zfr88Gpu9+lX/1anj8T26yk
         nPKH2L+fy8x8tXGikAgT2prKT1f3QyOIF56Dpb7CUPSzsS3iUCWNRVGMSvq4k0hFlx
         FQ8n+/w90DPJfnyrFTLXgKhdPPFL1lIny3s7kC5U6ZOwkFl9ohhVy3PoTVsVNGELay
         SBV2+IoKYZF4CBc+nKJP7BNhF6zV1ZPKtOQd3sOWqm57Pq5CTcDLRefczpguZ2kuVp
         /lkIHopLKiIKw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 30 Sep 2018 18:43:44 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: "You are easily replacable" Bruce Peren's message to past
 contributors.
Message-ID: <170cdf1c8c5a87ba667067cf1bf45eff@redchan.it>
X-Sender: freedomfromruin@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Any actual kernel developers who leave will be replaced by one of the 
other 4000 active this year. If they have been vociferous about their 
rights to entirely unlimited conduct (and all of the side-issues that 
seem to come with that) it may be that the folks on the kernel mailing 
list are already tired of them and won't miss them."

https://news.slashdot.org/comments.pl?sid=12682608&cid=57394936
