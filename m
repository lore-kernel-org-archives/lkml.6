Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A17C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2BB2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2BB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeJRNMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:12:01 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:49911 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727348AbeJRNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:12:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6EFEB235C9;
        Thu, 18 Oct 2018 05:12:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slip41_52cc55438e755
X-Filterd-Recvd-Size: 2115
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Oct 2018 05:12:48 +0000 (UTC)
Message-ID: <889a482aff2a3d4110640833d3749ce7ba5447f1.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for VKMS
From:   Joe Perches <joe@perches.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 22:12:47 -0700
In-Reply-To: <20181017225126.o7le4sczgfol62mq@smtp.gmail.com>
References: <20181017225126.o7le4sczgfol62mq@smtp.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 19:51 -0300, Rodrigo Siqueira wrote:
> Add maintainers and reviewers for VKMS driver
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39c3f6682ace..78c3c0bf89fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4592,6 +4592,16 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  S:	Supported
>  F:	drivers/gpu/drm/pl111/
>  
> +DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> +M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> +R:	Haneen Mohammed <hamohammed.sa@gmail.com>
> +R:	Daniel Vetter <daniel@ffwll.ch>
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Maintained
> +L:	dri-devel@lists.freedesktop.org 
> +F:	drivers/gpu/drm/vkms/
> +F:	Documentation/gpu/vkms.rst
> +
>  DRM DRIVER FOR ARM VERSATILE TFT PANELS
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  T:	git git://anongit.freedesktop.org/drm/drm-misc

Please insert this section in alphabetical order


