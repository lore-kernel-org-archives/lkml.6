Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DAECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B7206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604B7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeGPRlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:41:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:13253 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbeGPRlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:41:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 10:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,362,1526367600"; 
   d="scan'208";a="65094666"
Received: from spredd1-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.137.181])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2018 10:12:41 -0700
Date:   Mon, 16 Jul 2018 10:12:39 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/connector: Fix typo in drm_connector_list_iter_next()
Message-ID: <20180716171239.GD4262@intel.com>
References: <20180716161645.2715-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716161645.2715-1-lyude@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:16:45PM -0400, Lyude Paul wrote:
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/drm_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 9b9ba5d5ec0c..2e0312e4645a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -577,7 +577,7 @@ __drm_connector_put_safe(struct drm_connector *conn)
>  
>  /**
>   * drm_connector_list_iter_next - return next connector
> - * @iter: connectr_list iterator
> + * @iter: connector_list iterator
>   *
>   * Returns the next connector for @iter, or NULL when the list walk has
>   * completed.
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
