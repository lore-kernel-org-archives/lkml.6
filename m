Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9656C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AAF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AAF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeK2DSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:18:32 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:37689 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbeK2DSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:18:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,291,1539640800"; 
   d="scan'208";a="357825059"
Received: from unknown (HELO function) ([193.50.110.94])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2018 17:16:19 +0100
Received: from samy by function with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gS2Vf-00084x-3W; Wed, 28 Nov 2018 17:16:19 +0100
Date:   Wed, 28 Nov 2018 17:16:19 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin King <colin.king@canonical.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: i18n: fix spelling mistake
 "phoneticly" -> "phonetically"
Message-ID: <20181128161619.eee5hucep7mw47fi@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin King <colin.king@canonical.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181128161232.14907-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128161232.14907-1-colin.king@canonical.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Colin King, le mer. 28 nov. 2018 16:12:32 +0000, a ecrit:
> -	[MSG_FUNCNAME_SPELL_WORD_PHONETICALLY] = "spell word phoneticly",
> +	[MSG_FUNCNAME_SPELL_WORD_PHONETICALLY] = "spell word phonetically",

Mmm, clearly an english typo. Speakup people, do you think there might
be any downside here?  Could it be that it was done on purpose for e.g.
syntheses to pronounce it right?

Samuel
