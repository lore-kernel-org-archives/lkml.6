Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E472579A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E472579A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934471AbeFZLNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:57297 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933592AbeFZLNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:13:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97B15AE24;
        Tue, 26 Jun 2018 11:13:42 +0000 (UTC)
Date:   Tue, 26 Jun 2018 13:13:42 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] nvme: trace: add disk name to tracepoints
Message-ID: <20180626111342.4g7or4jzm5zw2ks4@linux-x5ow.site>
References: <20180611184630.3435-1-jthumshirn@suse.de>
 <c05ae7fd-3580-ffb5-8beb-6e28666687f4@grimberg.me>
 <20180625070850.jdl7mudz6o6diwsj@linux-x5ow.site>
 <d4786519-1695-25a0-dbf5-5d6cb9809539@grimberg.me>
 <20180625140300.rebclfa6pa6mtsat@linux-x5ow.site>
 <f09c1b97-ea12-20d6-ac8a-ee3f19b2879e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f09c1b97-ea12-20d6-ac8a-ee3f19b2879e@grimberg.me>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 01:59:00PM +0300, Sagi Grimberg wrote:
> You want to submit or should I?

Whatever is easier for you
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
