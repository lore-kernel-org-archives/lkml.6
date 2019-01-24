Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FBBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7159218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfAXVZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:58292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfAXVZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:25:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35701AD36;
        Thu, 24 Jan 2019 21:25:42 +0000 (UTC)
Date:   Thu, 24 Jan 2019 22:25:33 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Thomas Tai <thomas.tai@oracle.com>,
        linux-kernel@vger.kernel.org,
        Tyler Baicar <tbaicar@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v1] ras: Use consistent types for UUIDs
Message-ID: <20190124212533.GF10854@zn.tnic>
References: <20180713131027.77362-1-andriy.shevchenko@linux.intel.com>
 <20181005073305.GB24224@lst.de>
 <20190124205752.GK9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124205752.GK9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 10:57:52PM +0200, Andy Shevchenko wrote:
> Rafael, since you handled ACPI/APEI stuff for this cycle, perhaps you can take
> this one as well since for half a year there is no response from maintainers?

Can you send me the patch again pls, ontop of tip:ras/core:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=ras/core

I'll take it.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
