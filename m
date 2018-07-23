Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD2920854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD2920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbeGWWDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:03:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:9879 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388139AbeGWWDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:03:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 14:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="73843501"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2018 14:00:15 -0700
Date:   Mon, 23 Jul 2018 14:00:15 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ia64: switch to NO_BOOTMEM
Message-ID: <20180723210015.GA7058@agluck-desk>
References: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532325418-22617-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 08:56:54AM +0300, Mike Rapoport wrote:
> Hi,
> 
> These patches convert ia64 to use NO_BOOTMEM.
> 
> The first two patches are cleanups, the third patches reduces usage of
> 'struct bootmem_data' for easier transition and the forth patch actually
> replaces bootmem with memblock + nobootmem.
> 
> I've tested the sim_defconfig with the ski simulator and build tested other
> defconfigs.

Boots OK on my real ia64 system.

Unless somebody else sees an issue I'll push to Linus nest merge window.

-Tony
