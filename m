Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0594BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7B0240AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7B0240AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeGENnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:43:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:58889 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753384AbeGENnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:43:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 06:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,312,1526367600"; 
   d="scan'208";a="69863674"
Received: from jnikula-mobl2.fi.intel.com (HELO localhost) ([10.237.72.62])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2018 06:43:35 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/i915: Mark expected switch fall-throughs
In-Reply-To: <87efgqrofh.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180628223541.GA17665@embeddedor.com> <87efgqrofh.fsf@intel.com>
Date:   Thu, 05 Jul 2018 16:43:20 +0300
Message-ID: <87tvpdol1j.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 28 Jun 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 141432
>> Addresses-Coverity-ID: 141433
>> Addresses-Coverity-ID: 141434
>> Addresses-Coverity-ID: 141435
>> Addresses-Coverity-ID: 141436
>> Addresses-Coverity-ID: 1357360
>> Addresses-Coverity-ID: 1357403
>> Addresses-Coverity-ID: 1357433
>> Addresses-Coverity-ID: 1392622
>> Addresses-Coverity-ID: 1415273
>> Addresses-Coverity-ID: 1435752
>> Addresses-Coverity-ID: 1441500
>> Addresses-Coverity-ID: 1454596
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
>
> I'll let others chime in before merging.

Pushed to drm-intel-next-queued, headed for v4.19, thanks for the patch.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
