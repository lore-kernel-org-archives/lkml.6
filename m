Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB23C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6C2218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="WpJnwWGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfAYRfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:35:53 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:37043 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=qO15TubLP1KuvI54kTn3WNg+9YwYX0iaigSn6AA4wIM=;
        b=WpJnwWGbN+TS9DQAoXdSeeIaRAdGTCWxKEZ3JmFYrQyK6+vS9kXMraHYshLWYrEyi+BU95BETCNRcINM3m2xwpcwt8amrjbmtrUbnEQDDWg+nA0iYzcpUQPZknvjbU2HFMAgSRNtImg1ptLdjgxV6O2b+0mY+80aZWYg5FsIpdau930kS6PZSTCo5+i52d0+Hvyw+r0DL/Mchxa99reXdGiq7jNyUOEtz+jHEBqf4eXfbTGSXVrvYwwGjGiKTbEnMSpVuU7L26u5OPNBdnsr4Lk9v90jIpr+hrfFsmHd1euZH1t9pvgDtJpYQOP1jKzDs374TllK3XUXDoed6IVquw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:14838 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gn5OQ-0005HS-OD; Fri, 25 Jan 2019 18:35:50 +0100
Subject: Re: [PATCH v3 22/23] drm/qxl: use kernel mode db
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-23-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <743a4efe-7199-3123-66bf-23a0d6dd96a0@tronnes.org>
Date:   Fri, 25 Jan 2019 18:35:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118122020.27596-23-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 18.01.2019 13.20, skrev Gerd Hoffmann:
> Add all standard modes from the kernel's video mode data base.
> Keep a few non-standard modes in the qxl mode list.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
