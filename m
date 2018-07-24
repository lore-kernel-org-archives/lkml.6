Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C23CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A79A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A79A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbeGXOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:01:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:46215 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388297AbeGXOBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:01:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 05:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="scan'208";a="242877074"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2018 05:55:13 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 96391203B0; Tue, 24 Jul 2018 15:55:12 +0300 (EEST)
Date:   Tue, 24 Jul 2018 15:55:12 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 34/35] media: camss: csid: Add support for events
 triggered by user controls
Message-ID: <20180724125512.oz2xiaodzk67eyhu@paasikivi.fi.intel.com>
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <1532343772-27382-35-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532343772-27382-35-git-send-email-todor.tomov@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todor,

On Mon, Jul 23, 2018 at 02:02:51PM +0300, Todor Tomov wrote:
> Changing a user control value can trigger an event to other
> users. Add support for that.
> 
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

No need to wait more acks from me; please just check the comments I've
given so far.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
