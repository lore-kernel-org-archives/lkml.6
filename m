Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8213FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFBA2185B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFBA2185B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeHQJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:54:36 -0400
Received: from verein.lst.de ([213.95.11.211]:34045 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeHQJyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:54:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AA60A70573; Fri, 17 Aug 2018 08:53:26 +0200 (CEST)
Date:   Fri, 17 Aug 2018 08:53:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart van Assche <bart.vanassche@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "Ed L . Cachin" <ed.cashin@acm.org>
Subject: Re: [PATCH 3/5] aoe: use device_add_disk_with_groups()
Message-ID: <20180817065326.GB11170@lst.de>
References: <20180814073305.87255-1-hare@suse.de> <20180814073305.87255-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814073305.87255-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 09:33:03AM +0200, Hannes Reinecke wrote:
> Use device_add_disk_with_groups() to avoid a race condition with
> udev during startup.

The desxription and the subject line need an update now that
device_add_disk_with_groups is no more.
