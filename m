Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D910FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A884221582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A884221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeKPFJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:09:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:2451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeKPFJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:09:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 11:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,237,1539673200"; 
   d="scan'208";a="104839861"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2018 11:00:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 65D3830853D; Thu, 15 Nov 2018 11:00:28 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Travis Downs <travis.downs@gmail.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf unwinding - wrong stack pointer register value?]
References: <2335309.gnWok9HYb4@agathebauer> <31474933.dcNFsqGoRn@agathebauer>
        <CAOBGo4wPeobp90eqZF1apZxHUn-dnh6L3Rpt_=beR49o3XHY7g@mail.gmail.com>
        <6310843.N4ooJGWzKY@agathebauer>
Date:   Thu, 15 Nov 2018 11:00:28 -0800
In-Reply-To: <6310843.N4ooJGWzKY@agathebauer> (Milian Wolff's message of "Thu,
        15 Nov 2018 10:10:13 +0100")
Message-ID: <8736s2xj1v.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> I agree. I personally like your suggested approach - only add an indication 
> when the IP differs so much that it points to a different function. What do 
> others say to this?

Yes that's fine.

-Andi

