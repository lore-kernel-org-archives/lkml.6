Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A84C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCBA217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCBA217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeHIMUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:20:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727786AbeHIMUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:20:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1435FAD73;
        Thu,  9 Aug 2018 09:56:47 +0000 (UTC)
Date:   Thu, 9 Aug 2018 11:56:46 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>
Subject: Re: [PATCH 0/3] scsi: fcoe: memleak fixes
Message-ID: <20180809095646.mqqu2xopodb7rdp7@linux-x5ow.site>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180806092503.6ed56kukj2i236qt@linux-x5ow.site>
 <20180809080543.xvjoya74j66sadvg@linux-x5ow.site>
 <yq11sb7rho2.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq11sb7rho2.fsf@oracle.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 05:52:13AM -0400, Martin K. Petersen wrote:
> 
> Johannes,
> 
> > Martin,
> >
> > though it looks like these patches aren't fixing all of the errors Ard
> > has, they fix all I could reproduce up to now and Ard already stated
> > they're not regressing.
> >
> > So can we please stage them for 4.19?
> 
> I merged them last week.

Oh I'm sorry, missed that.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
