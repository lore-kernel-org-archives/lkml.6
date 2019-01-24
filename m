Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEB0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89631218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548367232;
	bh=rRZq1MlK6R1mn1sSSC2l+9tI8V9tWm66veHAwssTc0M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=tCZali8F5/Adw9o1gWv+543V1zKv0fKqZ+6MHv8PTaZFC0j0jmsq2Jqf0I9nuC6Up
	 8I4Jigj5nCBL3eRPWq0e+cH7F/JlGBMp0XmMehvk8hUAmitXvkMR3QXbicViBgbjvP
	 7DFYI4HWCBpI7FT5y7L8E3DQT9oL7eC+ihRG/9FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfAXWAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 17:00:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:34334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbfAXWAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 17:00:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2FCEAE0B;
        Thu, 24 Jan 2019 22:00:28 +0000 (UTC)
Date:   Thu, 24 Jan 2019 23:00:26 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: Switch to use new generic UUID
 API
In-Reply-To: <20190124200906.60296-1-andriy.shevchenko@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1901242300020.6626@cbobk.fhfr.pm>
References: <20190124200906.60296-1-andriy.shevchenko@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Andy Shevchenko wrote:

> There are new types and helpers that are supposed to be used in new code.
> 
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-5.1/ish branch, thanks.

-- 
Jiri Kosina
SUSE Labs

