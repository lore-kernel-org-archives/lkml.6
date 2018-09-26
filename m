Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734BBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E669C2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="SGPJ2moG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E669C2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeIZVoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:44:03 -0400
Received: from imap.thunk.org ([74.207.234.97]:50454 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZVoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L8ERYMRHfDL2MA2WvnOthnM+hwbCjbx5f4BHaGimmQw=; b=SGPJ2moGrimrgEn+RMXRLxmub6
        ytYBpf0VCpYtQ+Zdh0zn2caKlDXXpGuQ5deNFprw+X3mpQhUK2Zd7j15zmNvThBDTT/xzyJYCwt6W
        9EuuPNweH4P3FGle0Pln+Hw0monNiJXZ280ujGEkB7bklcMW1EKcpJnySt8xod4PnRmM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g5Blp-0000os-ON; Wed, 26 Sep 2018 15:30:33 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4C4C47A54D5; Wed, 26 Sep 2018 11:30:29 -0400 (EDT)
Date:   Wed, 26 Sep 2018 11:30:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JvQtdC+0L3RgtGM0LXQsg==?= 
        <dm.leontiev7@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Maybe a copyright attack on linux
Message-ID: <20180926153029.GF3321@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JvQtdC+0L3RgtGM0LXQsg==?= <dm.leontiev7@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+JonM0_4GSeQ5veX3aDjJ_RBoL065YLNFMuyVftQBn-pCcA=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+JonM0_4GSeQ5veX3aDjJ_RBoL065YLNFMuyVftQBn-pCcA=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:55:18PM +0300, Дмитрий Леонтьев wrote:
> Or: "Why you should not use "kill switch" option proposed by smdy to
> protest against CoC"
> 
> Hello.
> 
> I'm neither a great software developer nor a lawyer, but I'm not a
> novice and I'm very annoyed whan I see this:
> 
> https://woww.reddit.com/r/programming/comments/9iqr3u/linux_developers_threaten_to_pull_kill_switch/

Dmitry,

Before you worry overmuch, I suggest you take a look at the people who
are the claimed "linux developers" who are so "threatening" and see
how many commits (if any at all) they actually have contributed to he
Linux sources.

There are a lot of people who are not members of the Linux kernel
development community that have been contributing a huge amount of
noise on both sides of the controversy, both pro- and anti- CoC.

My view is that this noise is not at all helpful, and they have their
own agenda which they are trying to promote.  A handy-dandy command if
you have the git tree for the kernel downloaded is:

	git log --author=user@example.com

Best regards,

						- Ted
