Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA5C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D744A2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D744A2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeHNPKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:10:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:50512 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbeHNPKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:10:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 05:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,238,1531810800"; 
   d="scan'208";a="76620967"
Received: from sneaga-mobl.ger.corp.intel.com (HELO [10.252.51.111]) ([10.252.51.111])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2018 05:23:11 -0700
Subject: Re: [PATCH v4 1/2] drm: Add per-plane pixel blend mode property
To:     Lowry Li <lowry.li@arm.com>, liviu.dudau@arm.com
Cc:     gustavo@padovan.org, daniel.vetter@intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, emil.l.velikov@gmail.com, nd@arm.com
References: <1534246377-31346-1-git-send-email-lowry.li@arm.com>
 <1534246377-31346-2-git-send-email-lowry.li@arm.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <54312d81-2b9e-c42e-a486-9ef3c262e06b@linux.intel.com>
Date:   Tue, 14 Aug 2018 14:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534246377-31346-2-git-send-email-lowry.li@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 14-08-18 om 13:32 schreef Lowry Li:
> Pixel blend modes represent the alpha blending equation
> selection, describing how the pixels from the current
> plane are composited with the background.
>
> Adds a pixel_blend_mode to drm_plane_state and a
> blend_mode_property to drm_plane, and related support
> functions.
>
> Defines three blend modes in drm_blend.h.
Hey,

The changelog's missing?

~Maarten
