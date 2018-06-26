Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081924EB4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081924EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965545AbeFZNyC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:54:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:34397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935437AbeFZNyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:54:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 06:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="60283935"
Received: from jgbauer-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.36.34])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jun 2018 06:53:59 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id DF24821E18; Tue, 26 Jun 2018 16:53:55 +0300 (EEST)
Date:   Tue, 26 Jun 2018 16:53:55 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/32] media: Rename CAMSS driver path
Message-ID: <20180626135355.ffkssccfqwhfb53f@kekkonen.localdomain>
References: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
 <1529681621-9682-5-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529681621-9682-5-git-send-email-todor.tomov@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

On Fri, Jun 22, 2018 at 06:33:13PM +0300, Todor Tomov wrote:
> Support for camera subsystem on QComm MSM8996/APQ8096 is to be added
> so remove hardware version from CAMSS driver's path.
> 
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>

The patch didn't make it to the list... if you're renaming or moving files,
could you add -C option to git format-patch? It tends to produce a lot
smaller and easier to review patches.

Thanks.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
