Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E75C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9584F20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="IvPKUxIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9584F20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeJMRfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:35:12 -0400
Received: from cock.li ([185.100.85.212]:50364 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbeJMRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:35:12 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1539424719; bh=vV+JTk4WVyXtOOPUDvgX7m55SKO34KNZ5QoNwgkRd/I=;
        h=Date:From:To:Cc:Subject:From;
        b=IvPKUxIN6GQMvFWOwKaOTk9whOLS/Zo92ZsLxz7lOkSuogV+Jqq0PXfLE2IPDQDee
         kjTw30d29r0CNzndxGx8gKHkvg03+ex99QMfGfjSYTqdi2HOgqpq6ApQ3OgfDDFzns
         xAhzqd3wOLCfqasLaNRsGXFMwp9DmkVZK+QV0kU5OMmPsD0cAdJw318I5S4rjxxqbz
         RZmM4bQ+8sFLFdsfwRbbA1Td7nEljkS0Qli7Pum5OsFC28YobETIcwN8kVxB1E2Z+q
         nYw34//493EPK/NuvJ+pvzmzPlufr9Fds6zD4hhew3RxyPCTawBNOzOnFL5/bKs+f7
         zOhKZj47BiQ+g==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 13 Oct 2018 09:58:39 +0000
From:   missingterms@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     rms@gnu.org, bruce@perens.com, esr@thyrsus.com,
        moglen@columbia.edu, bkuhn@sfconservancy.org, editor@lwn.net,
        torvalds@osdl.org
Subject: The GPL is not a contract, it is a revocable license.
Message-ID: <1b0d7b89fac31ca23455ff46983e9d0f@redchan.it>
X-Sender: missingterms@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPL is not a contract, it is a revocable license.

Enjoy the read:
http://illinoisjltp.com/journal/wp-content/uploads/2013/10/kumar.pdf

(With full citations).
