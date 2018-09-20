Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26379ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC06D21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC06D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbeITNPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:15:24 -0400
Received: from verein.lst.de ([213.95.11.211]:58172 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731413AbeITNPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:15:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 325FA68D79; Thu, 20 Sep 2018 09:33:20 +0200 (CEST)
Date:   Thu, 20 Sep 2018 09:33:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: sd: don't crash the host on invalid commands
Message-ID: <20180920073320.GA14716@lst.de>
References: <20180920071907.10102-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920071907.10102-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
