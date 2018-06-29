Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135BBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B474627BAF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B474627BAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeF2IKT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:10:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:52596 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934498AbeF2IKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:10:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 01:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="67332841"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2018 01:10:12 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 5DC622059E; Fri, 29 Jun 2018 11:10:10 +0300 (EEST)
Date:   Fri, 29 Jun 2018 11:10:10 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     alanx.chiang@intel.com
Cc:     linux-i2c@vger.kernel.org, andy.yeh@intel.com,
        andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com,
        rajmohan.mani@intel.com, andy.shevchenko@gmail.com,
        tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl,
        robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] eeprom: at24: Add support for address-width
 property
Message-ID: <20180629081010.odoq2pgilskhzck3@paasikivi.fi.intel.com>
References: <1530256915-25034-1-git-send-email-alanx.chiang@intel.com>
 <1530256915-25034-3-git-send-email-alanx.chiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530256915-25034-3-git-send-email-alanx.chiang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:21:55PM +0800, alanx.chiang@intel.com wrote:
> From: Alan Chiang <alanx.chiang@intel.com>
> 
> Provide a flexible way to determine the addressing bits of eeprom.
> Pass the addressing bits to driver through address-width property.
> 
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
