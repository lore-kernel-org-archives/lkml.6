Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC47C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92106218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548268610;
	bh=9+ZrgAa6HHecsVuqu+pbgz1vyAwGu/Pz0Kqi284huE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wYpcpFVcsW6ogloqFUYlzuECy5tFWIGx9hfmemaPmcJmvQoh2/GkDa+GSopqFQyme
	 duAZgk4bIR3fnHIPuqytTUfghNLeYwkldIb6V05GXn/umYm2ncfi7shfOzP9BU+YOM
	 +oi21vYlbCeHZjfzQGT699Fdf7uJyDwLoVXVCmAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAWSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfAWSgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:36:47 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C162218A1;
        Wed, 23 Jan 2019 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548268606;
        bh=9+ZrgAa6HHecsVuqu+pbgz1vyAwGu/Pz0Kqi284huE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACoAKN9d9WSY5ArvTuQjGUCLmHn/FjDcEXapRp5njkL02U6Mx2eRYFOdwPZkvnEuE
         5hngu16jQwWR5XF8Btxuo/ITncHsDCa/C9p9bwMmdLr+jB+5in7UPle6PfSUkYCM3n
         YDGXF4VVHR4pZoCjtAKtjgBkyBLlI/+6TrCTTBpE=
Date:   Wed, 23 Jan 2019 13:36:45 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org
Subject: Re: [PATCH v2] vmbus: Switch to use new generic UUID API
Message-ID: <20190123183645.GO202535@sasha-vm>
References: <20190110142532.52067-1-andriy.shevchenko@linux.intel.com>
 <20190121084821.GF18680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190121084821.GF18680@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:48:21AM +0100, Christoph Hellwig wrote:
>Looks good,
>
>Reviewed-by: Christoph Hellwig <hch@lst.de>

Queued up for hyperv-next, thanks all.

--
Thanks,
Sasha
