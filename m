Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C706C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C93821104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C93821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbeKUVsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:48:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:3730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbeKUVsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:48:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 03:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="109975952"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2018 03:14:02 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] drm/i915: fix spelling mistake "reserverd" -> "reserved"
In-Reply-To: <20181120151415.32419-1-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181120151415.32419-1-alexandre.belloni@bootlin.com>
Date:   Wed, 21 Nov 2018 13:14:33 +0200
Message-ID: <87pnuyel7q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> Fix a spelling mistake in a comment.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks for the patch, pushed to drm-intel-next-queued.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index f9ce35da4123..742f8ff101e4 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -4280,7 +4280,7 @@ static void gen10_sseu_device_status(struct drm_i915_private *dev_priv,
>  	for (s = 0; s < info->sseu.max_slices; s++) {
>  		/*
>  		 * FIXME: Valid SS Mask respects the spec and read
> -		 * only valid bits for those registers, excluding reserverd
> +		 * only valid bits for those registers, excluding reserved
>  		 * although this seems wrong because it would leave many
>  		 * subslices without ACK.
>  		 */

-- 
Jani Nikula, Intel Open Source Graphics Center
