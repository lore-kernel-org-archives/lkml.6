Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D28C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217DF20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217DF20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeIDOEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:04:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:4382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeIDOEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:04:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 02:40:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="260525315"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga006.fm.intel.com with SMTP; 04 Sep 2018 02:40:16 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Sep 2018 12:40:15 +0300
Date:   Tue, 4 Sep 2018 12:40:15 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de
Subject: Re: [PATCH 3/3] thunderbolt: Add Intel as copyright holder
Message-ID: <20180904094015.GO2283@lahna.fi.intel.com>
References: <20180903133304.70362-1-mika.westerberg@linux.intel.com>
 <20180903133304.70362-4-mika.westerberg@linux.intel.com>
 <CA+CmpXu6NENgWMM-PSge=vFp3OKV1rtWqycqdgY9bmQE2in4JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXu6NENgWMM-PSge=vFp3OKV1rtWqycqdgY9bmQE2in4JA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 11:18:49PM +0300, Yehezkel Bernat wrote:
> >   * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
> > + * Copyright (C) 2018, Intel Corporation
> 
> Nitpicking: (c) or (C)?
> I can't find anything in the documentation and both are found in various files.

I don't think there are any rules for it. I've been using (C) typically
even if it is not "consistent" with other copyrights in the same file.
