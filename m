Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF457C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700B1218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="X/G4qt1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfAaKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:41:17 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:35615 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfAaKlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=yY9hV1nDMXMbnNiwgM8u8fQvecI0Cnd/WSs52Nzwack=;
        b=X/G4qt1dKXVyEHO3A2wrxNEjtMEar7QZuDotd3bAEAiQdqCWAJeyerooos2HHUU2GvoT3FPbFtsklProqQSxe2pl5uroqLjuazIjwyjE6FwYDdaFsZ7mFhYMnlRBzWmOdNnbU7fr6jrox13e5bVah5HbA0HnhJjB9scsl/00FNPq/uhbqrzxwkYrP2MLiBOShrtRyEVZeiOn7a5o6Tggf7BTaD0Z6lDQ+cMO2wxE2XlV0Z/kQyXcuqbZvoT5egjOdkrMSkNRthRke8B04q3QvOAOcV7E9hBl5lV6LHYWKrK6/hPOx4Xveizd3B5kvb5mOldokJpSe8taIgXlFqU1JQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52616 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gp9mU-0003DW-8N; Thu, 31 Jan 2019 11:41:14 +0100
Subject: Re: [PATCH v2 3/6] drm/virtio: params struct for
 virtio_gpu_cmd_create_resource()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-4-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <52a8ddf4-e836-9ef4-e6d0-8b57e48cdb25@tronnes.org>
Date:   Thu, 31 Jan 2019 11:41:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190130094338.14203-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> Add format, width and height fields to the virtio_gpu_object_params
> struct.  With that in place we can use the parameter struct for
> virtio_gpu_cmd_create_resource() calls too.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
