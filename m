Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6315BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6DD2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6DD2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeHQKIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:08:25 -0400
Received: from verein.lst.de ([213.95.11.211]:34210 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQKIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:08:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 93A7068EF1; Fri, 17 Aug 2018 09:07:12 +0200 (CEST)
Date:   Fri, 17 Aug 2018 09:07:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Wnukowski <wnukowski@google.com>
Cc:     torvalds@linux-foundation.org, axboe@fb.com, hch@lst.de,
        keith.busch@intel.com, keith.busch@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, yigitfiliz@google.com
Subject: Re: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
Message-ID: <20180817070712.GA11383@lst.de>
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com> <20180815225157.89523-1-wnukowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815225157.89523-1-wnukowski@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied this with some major updates to the subject, changelog
and the comment in the code.  Please double check it all still makes
sense.
