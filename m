Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264AC20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdSaR50G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264AC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbeKFCyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387538AbeKFCyX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:54:23 -0500
Received: from jouet.infradead.org (unknown [179.162.130.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017D620866;
        Mon,  5 Nov 2018 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541439221;
        bh=KnNtrvpjD5e8p4sqJmNPtSFgQsz8RsfN8TPS/QXeXvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdSaR50GwxzSSXDdfx9izJs/sAfw4dLQQAKmd3VGa04XWVZt9b6/na2C1W6ZSbfb5
         4adeZH6212r7RdVYfzt6fnyUzfwvz9si88Awkh8y0fhD6CPjz0UXdDRImUOUBP6MAv
         BpQ23RfMJZBpplLsl8mfKCpTiZGAI/DDHiU5/upw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4E367142ECF; Mon,  5 Nov 2018 14:23:37 -0300 (-03)
Date:   Mon, 5 Nov 2018 14:23:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf top: Display the LBR stats in callchain entry
Message-ID: <20181105172337.GG11147@kernel.org>
References: <1540983995-20462-1-git-send-email-yao.jin@linux.intel.com>
 <cb124f2d-a7b6-689e-c41d-0dec33a8cf0f@linux.intel.com>
 <20181105131027.GC11147@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105131027.GC11147@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 05, 2018 at 10:10:27AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 05, 2018 at 08:31:59AM +0800, Jin, Yao escreveu:
> > Hi,
> > 
> > Any comments for this patch?
> 
> I'll check it today, I'm just a bit behind while preparing for plumbers,
> I'll get to all the patches :-)

Thanks, tested, applied.

- Arnaldo
