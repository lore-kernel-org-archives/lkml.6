Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B725C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ECC265B0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ECC265B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeF0JmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:42:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:24597 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeF0JmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:42:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 02:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="52268014"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 27 Jun 2018 02:41:59 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Jun 2018 12:41:59 +0300
Date:   Wed, 27 Jun 2018 12:41:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     nathan.d.ciobanu@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        andreas.noever@gmail.com
Subject: Re: [PATCH] thunderbolt: fix small typo in variable name
Message-ID: <20180627094159.GL2558@lahna.fi.intel.com>
References: <1530056060-3612-1-git-send-email-nathan.d.ciobanu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530056060-3612-1-git-send-email-nathan.d.ciobanu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:34:20PM -0700, nathan.d.ciobanu@linux.intel.com wrote:
> From: Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>
> 
> Fixes small variable name typo and the associated
> checkpatch spelling warning
> 
> Signed-off-by: Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>

Applied to thunderbolt.git/next, thanks!
