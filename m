Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC12C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6349721766
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6349721766
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeGGHlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:41:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:51396 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeGGHlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:41:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 00:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,320,1526367600"; 
   d="scan'208";a="70353550"
Received: from jkavana1-mobl.ger.corp.intel.com ([10.252.15.136])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2018 00:40:35 -0700
Message-ID: <ebe5bbb03ca9c39e468d7f40d67d58733062a1f9.camel@intel.com>
Subject: Re: [PATCH 09/12] iwlwifi: Remove local iwl_bcast_addr and use
 ether_broadcast_addr
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date:   Sat, 07 Jul 2018 10:40:35 +0300
In-Reply-To: <af831d8873ffcc36014244f76d21cd6aaf5aca9c.1522479608.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
         <af831d8873ffcc36014244f76d21cd6aaf5aca9c.1522479608.git.joe@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-31 at 00:05 -0700, Joe Perches wrote:
> Use the new global to save a little bit of object code.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---

I took this one to our internal tree and it will be applied as part of
our normal upstreaming process.

Thanks!

--
Luca.
