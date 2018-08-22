Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F34C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B0320684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfwirwyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B0320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeHVQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbeHVQje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:39:34 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9448420684;
        Wed, 22 Aug 2018 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534943681;
        bh=dIwe/sfr4sGM90cKFi/65cTqsv/5sbK69goR5hPMTxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfwirwyPCXMdR4PUfV6bFEmcaPRacC+M2ho3nxaOcjNluw0T31yiR76810zq55s4f
         Ea+gKdiUlk+8KOJbAAYxZ/k7cWv4LbMGuYlGH6++sJZC7hnVI54TchbpNsT+4AiuC2
         Kqmr1EnwlInNay5cFAh8EBEEOrgxWCDA8sTkSVBw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id BE61E141C3F; Wed, 22 Aug 2018 10:14:38 -0300 (-03)
Date:   Wed, 22 Aug 2018 10:14:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: Ping [PATCH v3] perf report: Create auxiliary trace data files
 for s390
Message-ID: <20180822131438.GC2880@kernel.org>
References: <20180822043739.100205-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822043739.100205-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 22, 2018 at 06:37:39AM +0200, Thomas Richter escreveu:
> Create auxiliary trace data log files when invoked with option
>  --itrace=d as in

Thanks, applied to my local perf/core branch, should appear online after
it goes thru testing together with the other changes I have queued up.

- Arnaldo
