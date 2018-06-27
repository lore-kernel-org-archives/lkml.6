Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C02C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01CF25E17
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01CF25E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754310AbeF0M2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:28:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:48214 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752897AbeF0M2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:28:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 05:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="67726616"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2018 05:28:29 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Vito Caputo <vcaputo@pengaru.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [REGRESSION] 4.18-rc2: X61s thinkpad display unusable after xlock & lid close
In-Reply-To: <20180627000548.jdhzpgnrdebzmlsd@shells.gnugeneration.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180627000548.jdhzpgnrdebzmlsd@shells.gnugeneration.com>
Date:   Wed, 27 Jun 2018 15:28:17 +0300
Message-ID: <87in64tnvi.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018, Vito Caputo <vcaputo@pengaru.com> wrote:
> Beginning with 4.18, when I lock my X server using the `xlock` command,
> and close the lid, upon reopening the lid I am not presented with the
> xlock UI.

Please file a bug report at [1]. Please include Xorg.0.log and dmesg
with drm.debug=14 reproducing the problem. For fastest results, please
git bisect.

BR,
Jani.

[1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel


-- 
Jani Nikula, Intel Open Source Graphics Center
