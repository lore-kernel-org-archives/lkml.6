Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4009CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023D52073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023D52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeH3R6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:58:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:13242 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbeH3R6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:58:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 06:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="86254873"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2018 06:55:53 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 605F7301B8B; Thu, 30 Aug 2018 06:55:53 -0700 (PDT)
Date:   Thu, 30 Aug 2018 06:55:53 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/10] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20180830135553.GJ7799@tassilo.jf.intel.com>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-4-andi@firstfloor.org>
 <20180830085658.GE16691@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830085658.GE16691@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > % perf record -e intel_pt// ...
> > % perf script --insn-trace
> > ... same output ...
> 
> which version of xed?

Recent version.

> 
> [jolsa@krava perf]$ ./perf script --insn-trace
> Unknown option -F
> [jolsa@krava perf]$ xed --version
> xed - Version 1.8.3
> 
> could you please check on this, and warn if the xed output
> is not available for this option

I tried it in an earlier version, but it's impossible
because xed always exits with error code 1.

-Andi
