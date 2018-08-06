Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2994C21A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2994C21A34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwaak.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeHFQEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:04:33 -0400
Received: from gw-fsck-sorbs.kwaak.net ([84.245.27.153]:42876 "EHLO
        mail.kwaak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeHFQEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:04:33 -0400
X-Greylist: delayed 1963 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Aug 2018 12:04:32 EDT
Received: from [192.168.0.44] (port=52123 helo=shell3.kwaak.net)
        by mail.kwaak.net with esmtp (Exim 4.50)
        id 1fmfT2-0008C7-FN; Mon, 06 Aug 2018 15:22:37 +0200
Received: from ard by shell3.kwaak.net with local (Exim 4.80)
        (envelope-from <ard@kwaak.net>)
        id 1fmfT1-0008C2-1r; Mon, 06 Aug 2018 15:22:35 +0200
Date:   Mon, 6 Aug 2018 15:22:34 +0200
From:   ard <ard@kwaak.net>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180806132234.GA23827@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.168.0.44 (failed)
X-Kwaak-Spam-Score: -0.6
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.309,
        required 5, autolearn=not spam, AWL 2.00, BAYES_00 -2.60,
        DNS_FROM_AHBL_RHSBL 0.29)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Johannes,

On Mon, Aug 06, 2018 at 11:25:03AM +0200, Johannes Thumshirn wrote:
> Ard,
> 
> Did you have time to test these patches?

Ahh, yeah, sorry.
I did test them.
I can't say I see a regression.
I also can't say I see progress, although it feels like there is
a tad less leaking.
For that I need to do some statistics.

But for now I ack that it does not regress further.

-- 
.signature not found
