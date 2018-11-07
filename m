Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D12C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9EC2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9EC2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeKHIDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:03:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:45846 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbeKHIDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:03:32 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D4642ED;
        Wed,  7 Nov 2018 22:31:05 +0000 (UTC)
Date:   Wed, 7 Nov 2018 15:31:04 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
Message-ID: <20181107153104.71eddf4d@lwn.net>
In-Reply-To: <20181026172549.3628-1-colin.king@canonical.com>
References: <20181026172549.3628-1-colin.king@canonical.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 18:25:49 +0100
Colin King <colin.king@canonical.com> wrote:

> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/filesystems/spufs.txt | 2 +-
>  Documentation/gpu/drm-uapi.rst      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.  

This is the first patch to spufs.txt since 2006...I wonder if that stuff
is being used by anybody...

jon
