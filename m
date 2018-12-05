Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90EE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90EE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeLEQ5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:57:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:62454 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeLEQ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:57:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 08:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="116238212"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2018 08:57:16 -0800
Date:   Wed, 5 Dec 2018 08:57:16 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181205165711.GA23186@agluck-desk>
References: <20181205141323.14995-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205141323.14995-1-bp@alien8.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:13:23PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Rename the containing folder to "mce" which is the most widespread name.
> Drop the "mce[-_]" filename prefix of some compilation units (while
> others don't have it).
> 
> This unifies the file naming in the MCE subsystem:
> 
> mce/
> |-- amd.c
> |-- apei.c
> |-- core.c
> |-- dev-mcelog.c
> |-- genpool.c
> |-- inject.c
> |-- intel.c
> |-- internal.h
> |-- Makefile
> |-- p5.c
> |-- severity.c
> |-- therm_throt.c
> |-- threshold.c
> `-- winchip.c
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Tony Luck <tony.luck@intel.com>
