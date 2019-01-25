Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FBEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8273218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="K4VoAb6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfAYPxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:53:38 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:59766 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfAYPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=G8s8nC22PnbLYHzQpIX5ZoFkic9PpAQlwPgVaS57cyU=;
        b=K4VoAb6fCAkf8Yy8eld/soVBmNT9uTgswny90CE0OGa5gl+8FFu4223KhAwjvLNGvJOXXwk22KLA/IjAN4IFTPdRkiTj08/Fk7cyyuDhhkRFQt8ZmOvPPw8ryhVXNsoOzB2H+3cnzf1xOrrkErCOFEt5HScfWz+pS7M+h49annFqT7SjDYTdpRmybXuJnipeSH4CZ3mIodGEUgn0I3UyIv8eGFiPS4A/lvB4gY74W6rIz1heOhMEG/ifGXGI2Hv0KhbyR7WRqVgu/Rr9XHXWLU5orFk8Mt9m+JcSsQ3o8Xy3lehD2Ss2w1WuK2+RSRz+2I2V04FCS9e5gVKVLGWxGQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49231 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn3nT-0002h9-LZ; Fri, 25 Jan 2019 16:53:35 +0100
Subject: Re: [PATCH v3 05/23] drm/qxl: drop unused fields from struct
 qxl_device
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-6-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <a756762d-eb82-7424-4184-03678c404210@tronnes.org>
Date:   Fri, 25 Jan 2019 16:53:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> slot_id_bits and slot_gen_bits can be read directly from qxlrom instead.
> va_slot_mask is never used anywhere.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
