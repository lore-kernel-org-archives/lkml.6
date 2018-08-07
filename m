Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B682175D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B682175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kwaak.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbeHGMK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:10:58 -0400
Received: from gw-fsck-sorbs.kwaak.net ([84.245.27.153]:55491 "EHLO
        mail.kwaak.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbeHGMK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:10:58 -0400
Received: from [192.168.0.44] (port=38894 helo=shell3.kwaak.net)
        by mail.kwaak.net with esmtp (Exim 4.50)
        id 1fmyjq-00037J-Cb; Tue, 07 Aug 2018 11:57:15 +0200
Received: from ard by shell3.kwaak.net with local (Exim 4.80)
        (envelope-from <ard@kwaak.net>)
        id 1fmyjp-00037E-F3; Tue, 07 Aug 2018 11:57:13 +0200
Date:   Tue, 7 Aug 2018 11:57:13 +0200
From:   ard <ard@kwaak.net>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180807095713.GD23827@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180806132234.GA23827@kwaak.net>
 <20180806132725.ihbi5rxvkuuppajr@linux-x5ow.site>
 <20180806142414.GB23827@kwaak.net>
 <20180807065400.nxpndw4kf6jdd55i@linux-x5ow.site>
 <20180807092619.GC23827@kwaak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807092619.GC23827@kwaak.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.168.0.44 (failed)
X-Kwaak-Spam-Score: -2.6
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.304,
        required 5, autolearn=not spam, BAYES_00 -2.60,
        DNS_FROM_AHBL_RHSBL 0.29)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:26:19AM +0200, ard wrote:
> 3) I need a place for graphs, I will see if I can abuse the
> github ticket some more 8-D.
https://github.com/hardkernel/linux/issues/360#issuecomment-411001362

Regards,
Ard van Breemen
-- 
.signature not found
