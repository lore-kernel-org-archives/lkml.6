Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B60FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8D20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E8D20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJHTBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:01:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:51974 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJHTBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:01:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 04:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="77084913"
Received: from glkb6.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2018 04:50:08 -0700
Subject: Re: [PATCH] MAINTAINERS: Add Maxime Ripard as drm-misc maintainer
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <arlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20181005160256.200162-1-sean@poorly.run>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <50b7b2dc-85c1-ac74-52ff-79a6b4b53577@linux.intel.com>
Date:   Mon, 8 Oct 2018 14:50:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005160256.200162-1-sean@poorly.run>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Welcome :)

On 05.10.2018 19:02, Sean Paul wrote:
> Unfortunately Gustavo has decided to step down as drm-misc maintainer to
> focus on other projects. Thanks Gustavo for your dedication and hard work!
>
> Fortunately for us, we have a wealth of people qualified to assume a
> -misc maintainer role. Maxime has done an outstanding job with sun4i and
> in the community in general. I'm really excited that he agreed to take
> on this responsibility and I look forward to working with him!
>
> Cc: Dave Airlie <arlied@linux.ie>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard  <maxime.ripard@bootlin.com>
> Signed-off-by: Sean Paul <sean@poorly.run>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94c1fef3279b..da8507d401b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4755,8 +4755,8 @@ F:	include/uapi/drm/
>   F:	include/linux/vga*
>   
>   DRM DRIVERS AND MISC GPU PATCHES
> -M:	Gustavo Padovan <gustavo@padovan.org>
>   M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> +M:	Maxime Ripard  <maxime.ripard@bootlin.com>
>   M:	Sean Paul <sean@poorly.run>
>   W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
>   S:	Maintained

