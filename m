Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F51C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E520652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="ChneiTl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeJAOsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:48:30 -0400
Received: from cock.li ([185.100.85.212]:50598 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeJAOsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:48:30 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538381516; bh=pvVwbMz1yQSlaElHbs9cGPTHFQ4yt5gQwux0EcF5ptU=;
        h=Date:From:To:Cc:Subject:From;
        b=ChneiTl0nCzA4mTyVdMCkad4O2PQIln42W2YAsmh3CwwHkTUhGsJ4p9L+ZyHksi+8
         QMhVUk7w1K4xZyol7Au5mhHY9nmeiJI+EJz4C6spJ+Ryh7yDGKKkMiptGoXx8GrgYR
         BEmSzNOzA9ujy73JXtrjbmPVoiO+C+9eyV7s9Z94HmhpzgloykXQmBzhK25UvoV1vy
         qEQ5hM26bUjv4bjXYGO5CKHbjdh4R+yNr3jcY2nzR1cPh1qMpO4gvg9x1wn10Jhz+4
         64xQ7xDYsbB+ZH2ZhiojGj6pvbOSkH5d5PGkpEE7cDAIc5AIGiAiodjgJF8Z6UDz6w
         XdfENWzywFERw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 08:11:56 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org, dng@lists.dyne.org,
        debian-user@lists.debian.org
Cc:     rms@gnu.org, bruce@perens.com, esr@thyrsus.com,
        moglen@columbia.edu, bkuhn@sfconservancy.org, editor@lwn.net
Subject: SFConservancy misleads in "update" explaining GPLv2.
Message-ID: <3a72a88d59387d15bfe1efa1edbf04cc@redchan.it>
X-Sender: freedomfromruin@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section 4 is not operative against the grantor of the license, and makes 
no claim to be so.

It is speaking only of licensees and what might be described as 
sub-licensees.

Section 0 confirms that "You" refers to licensees.

Section 4 simply states that if a licensee loses his license, that does 
not cause the sub-licensee to lose his license in-turn.

