Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id webHGbo/Glt3UgAAmS7hNA
	; Fri, 08 Jun 2018 08:35:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 059A3607DC; Fri,  8 Jun 2018 08:35:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 94BA960290;
	Fri,  8 Jun 2018 08:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94BA960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeFHIfx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:35:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:44256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751843AbeFHIfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:35:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D85C9AC5B;
        Fri,  8 Jun 2018 08:35:49 +0000 (UTC)
Date: Fri, 8 Jun 2018 10:35:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [GIT] livepatching
Message-ID: <nycvar.YFH.7.76.1806081034180.6203@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/livepatching.git for-linus

to receive

=====
- livepatching documentation fix from Petr Mladek
=====

Thanks.

----------------------------------------------------------------
Petr Mladek (1):
      livepatch: Remove not longer valid limitations from the documentation

 Documentation/livepatch/livepatch.txt | 24 ------------------------
 1 file changed, 24 deletions(-)

-- 
Jiri Kosina
SUSE Labs
