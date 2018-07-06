Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D746C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA412402E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA412402E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbeGFGPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:15:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:56333 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753198AbeGFGPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:15:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 23:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,314,1526367600"; 
   d="scan'208";a="53003006"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 05 Jul 2018 23:15:31 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 06 Jul 2018 09:15:31 +0300
Date:   Fri, 6 Jul 2018 09:15:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: baytrail: Mark expected switch fall-throughs
Message-ID: <20180706061531.GY2534@lahna.fi.intel.com>
References: <20180705155127.GA1458@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705155127.GA1458@embeddedor.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:51:27AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1292308 ("Missing break in switch")
> Addresses-Coverity-ID: 1292309 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
