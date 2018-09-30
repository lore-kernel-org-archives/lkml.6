Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF06C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9860E2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 12:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lkcl.net header.i=@lkcl.net header.b="no1bo5/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9860E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lkcl.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeI3SmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 14:42:14 -0400
Received: from lkcl.net ([217.147.94.29]:44453 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbeI3SmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 14:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=Zn7bzAY+G7ERbwlDGvgLwj0EjHwTc7grRWKStwnB+eA=;
        b=no1bo5/6ex6ywrL0V17tyRd0hex/8QxEKnPz7LH9CB/zrd+U0tTGjkeh5K12m/mpa42MiG24oYiI92k5vglffKXIYjladLdxNzjr/TSCHeI3jHCeDfoB2xjIUsx9KyvhFtLhiYs7O99QnspC+najC2k4are36DhtX7N/VvIrHEU=;
Received: from [10.8.0.223] (helo=localhost)
        by lkcl.net with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1g6aXP-0003EQ-LB; Sun, 30 Sep 2018 12:09:28 +0000
Received: from lkcl by localhost with local (Exim 4.80)
        (envelope-from <lkcl@localhost>)
        id 1g6aX7-0007w8-MZ; Sun, 30 Sep 2018 13:09:09 +0100
From:   lkcl@lkcl.net
To:     martin@lichtvoll.de
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
Date:   Sun, 30 Sep 2018 13:09:09 +0100
Message-Id: <20180930120909.30469-1-lkcl@lkcl.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <2936237.GcMzexieOU@merkaba>
References: <2936237.GcMzexieOU@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 10.8.0.223 (failed)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That written: Quite some of the rude mails that contained swearwords I 
> read from you have been about code, not persons. I think this is an 
> important distinction. I do not have much of an issue with swearing at 
> code :), especially when it is in some humorous way.

 absolutely, and this is one thing that a lot of people are, sadly,
 trained pretty much from birth to be incapable of understanding:
 namely the difference between criticism of the PERSON and criticism
 of the ACTION.

 (1) "YOU are bad! GO STAND IN THE NAUGHTY CORNER!"
 (2) "That was a BAD thing to do!"
 (3) "That hurt my feelings that you did that"

 the first is the way that poorly-trained parents and kindergarten
 teachers talk to children.

 the second is... only marginally better, but it's a start

 the third is how UNICEF trains teachers to treat children as human beings.

> Code quality indeed is important.
> As are human interactions.

 absolutely.  it's not about the code, it's always, *always* about people.
 we just happen to be writing code, but ultimately we are doing so in the
 service of other PEOPLE.

 l.

