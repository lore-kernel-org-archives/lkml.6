Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED304C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC59020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfBYReJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:34:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:28709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfBYReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:34:09 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 09:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="141496159"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2019 09:34:08 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 63C48300309; Mon, 25 Feb 2019 09:34:08 -0800 (PST)
Date:   Mon, 25 Feb 2019 09:34:08 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Sebastien Boisvert <sboisvert@gydle.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Subject: Re: [PATCH 03/11] perf tools report: Support nano seconds
Message-ID: <20190225173408.GV16922@tassilo.jf.intel.com>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-4-andi@firstfloor.org>
 <d90b76f2-8d53-05ac-1526-9f0ddc4a0328@gydle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90b76f2-8d53-05ac-1526-9f0ddc4a0328@gydle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:40:45AM -0500, Sebastien Boisvert wrote:
> 
> 
> On 2019-02-24 10:37 a.m., Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Upcoming changes add timestamp output in perf report. Add a --ns
> > argument similar to perf script to support nanoseconds resolution
> > when needed.
> 
> Is this a ISO-8601 date with nanoseconds ?

No. 

-Andi
