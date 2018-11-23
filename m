Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6CC04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12820861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU35TMsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B12820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503809AbeKWWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388237AbeKWWLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:11:08 -0500
Received: from localhost (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F5AB206B2;
        Fri, 23 Nov 2018 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542972436;
        bh=vRnyE/P2IEXErtWmMTbP1xLLOlakrSiuAnsl0qyATwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KU35TMsjX9iMo1Qnhk7Zh64KlmWRHg6nLr0EtOfgbhLFPR+Wiu5aSsN9tmk3trAtr
         aQrwqspLZ2WM0ajx68l4qU4wAek5oWD3nHrIInExdKAEDrtQe8Ke/CovwR7xhqzg3g
         pN12eCY+LndRjyMfPt1FAGz/mdqwqaYYXZaQlsLc=
Date:   Fri, 23 Nov 2018 06:27:11 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 09/36] scsi: NCR5380: Return false instead
 of NULL
Message-ID: <20181123112711.GA1917@sasha-vm>
References: <20181122195240.13123-1-sashal@kernel.org>
 <20181122195240.13123-9-sashal@kernel.org>
 <alpine.LNX.2.21.1811230849180.305@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1811230849180.305@nippy.intranet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 08:49:39AM +1100, Finn Thain wrote:
>
>This patch is not relevant to any -stable branch. Please don't backport.

Heh, I see why. I wonder why git applied it cleanly :/

Now dropped, thank you.

--
Thanks,
Sasha
