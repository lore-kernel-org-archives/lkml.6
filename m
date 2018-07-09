Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84513C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E320873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465E320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbeGIGlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:41:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:4417 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeGIGlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:41:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 23:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="71121118"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga001.jf.intel.com with SMTP; 08 Jul 2018 23:41:30 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 09 Jul 2018 09:41:30 +0300
Date:   Mon, 9 Jul 2018 09:41:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     yehezkelshb@gmail.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, rjw@rjwysocki.net, christian@kellner.me
Subject: Re: [PATCH 5/5] thunderbolt: Add support for runtime PM
Message-ID: <20180709064130.GX2534@lahna.fi.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
 <20180707211401.GA13111@wunner.de>
 <20180708073130.GR2534@lahna.fi.intel.com>
 <CA+CmpXvaE63kBreCMMw_+QwMb811Rjx7B1z5==cY9nQ39J_Ukw@mail.gmail.com>
 <ce53ea53a51b41dca92c5f5978c45cf1@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce53ea53a51b41dca92c5f5978c45cf1@ausx13mpc120.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:20:00AM +0000, Mario.Limonciello@dell.com wrote:
> In practice I don't anticipate anyone in the industry outside of Apple wiring up TBT
> with RTD3 unless it's at least Alpine Ridge or newer.

I don't think Apple does it even with Alpine Ridge. I have one Macbook
here with AR and it for sure does not do any kind of runtime PM when
there is a device connected.
