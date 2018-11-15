Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8317C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1FD208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1FD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeKOLKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:10:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:17987 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOLKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:10:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 17:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,234,1539673200"; 
   d="scan'208";a="281176412"
Received: from ellie.jf.intel.com (HELO ellie) ([10.54.70.81])
  by fmsmga006.fm.intel.com with ESMTP; 14 Nov 2018 17:04:55 -0800
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Joe Perches <joe@perches.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igb: Fix format with line continuation whitespace
In-Reply-To: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
References: <1b31c663afa1aa7b3d231917f00f58b9cb604231.camel@perches.com>
Date:   Wed, 14 Nov 2018 17:04:53 -0800
Message-ID: <878t1v2lsa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> The line continuation unintentionally adds whitespace so
> instead use a coalesced format to remove the whitespace.
>
> Miscellanea:
>
> o Use a more typical style for ternaries and arguments
>   for this logging message
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
--
Vinicius
