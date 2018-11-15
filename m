Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7BB2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u9kNJeI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7BB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeKOPph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:45:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeKOPph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U3vHJvY8zhg9jV6Q+prFR6+FpOif1jl4lgNAL0Rlp/c=; b=u9kNJeI7RuAPZMZwo6nJ+sqgF
        unAJDZnIRvKK6W8z4RZaWKOeUZ0Kq0Hc4SjHVGXGVDM6RI+UmqWHfTd7PvxjQf9tR52/QuuCTIg2T
        /Q55Gmm28s8C2Qne6XSYALKEyT79kYAaO5cCIR46pRrwM3t+UezQSr2GQlyn8c36vRnIPjgSc+zU/
        O2JkRc7+ViWvORQnYgjWBRqN/NokoZ4yjyiCgRD2F68AgKM2AppMSahD4cV7Wo7uyVfhemYa7RvEq
        o66mg+QXeSXD/k6bxByjTOwwjoITpcGHogzJWoWO7NqAqszQJpRBO3C5CE8w6Z/cfEn7J5HaH77/j
        TIQH+AaKw==;
Received: from 189.27.28.95.dynamic.adsl.gvt.net.br ([189.27.28.95] helo=silica.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNAMy-0000hi-BP; Thu, 15 Nov 2018 05:39:13 +0000
Date:   Wed, 14 Nov 2018 21:39:01 -0800
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [RFC PATCH 1/3] MAINTAINERS: Reclaim the P:
 tag for Subsystem Profile
Message-ID: <20181114213901.75768212@silica.lan>
In-Reply-To: <154225759959.2499188.5163439674278041458.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225759959.2499188.5163439674278041458.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Nov 2018 20:53:19 -0800
Dan Williams <dan.j.williams@intel.com> escreveu:

> Fixup some P: entries to be M: and rename the remaining ones to 'E:' for
> "entity". The P: tag will be used to indicate the location of a
> Subsystem Profile for a given MAINTAINERS entry.
> 
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0abecc528dac..83b7b3943a12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -76,7 +76,7 @@ trivial patch so apply some common sense.
>  
>  Descriptions of section entries:
>  
> -	P: Person (obsolete)
> +	E: Entity (obsolete)

I don't like very much the idea of renaming it, but that's just my 2 cents.

IMO, the best would be to replace them to a non-obsolete field on a patch
that would remove it, then another patch would re-add with a different
meaning.

On a quick look, I suspect we could get rid of all remaining entries.
See below.

>  	M: Mail patches to: FullName <address@domain>
>  	R: Designated reviewer: FullName <address@domain>
>  	   These reviewers should be CCed on patches.
> @@ -771,7 +771,7 @@ S:	Orphan
>  F:	drivers/usb/gadget/udc/amd5536udc.*
>  
>  AMD GEODE PROCESSOR/CHIPSET SUPPORT
> -P:	Andres Salomon <dilinger@queued.net>
> +M:	Andres Salomon <dilinger@queued.net>
>  L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
>  W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
>  S:	Supported
> @@ -9271,7 +9271,7 @@ F:	drivers/staging/media/tegra-vde/
>  
>  MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>

> -P:	LinuxTV.org Project
> +E:	LinuxTV.org Project

LinuxTV is not really an entity. Just a name for a community-maintained site
where we store data about it.

That's already a "W:" tag pointing for it, so I would just remove it.

If you decide to remove, feel free to add my ack:

	Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  L:	linux-media@vger.kernel.org
>  W:	https://linuxtv.org
>  Q:	http://patchwork.kernel.org/project/linux-media/list/
> @@ -12465,7 +12465,7 @@ S:	Maintained
>  F:	arch/mips/ralink
>  
>  RALINK RT2X00 WIRELESS LAN DRIVER
> -P:	rt2x00 project
> +E:	rt2x00 project

I suspect that the above info is not really useful, and it is probably just
a left-over from the past history. 

I suspect that, if removed, nobody will really miss it, as it is quite
obvious :-)

>  M:	Stanislaw Gruszka <sgruszka@redhat.com>
>  M:	Helmut Schaa <helmut.schaa@googlemail.com>
>  L:	linux-wireless@vger.kernel.org
> @@ -12764,7 +12764,7 @@ S:	Supported
>  F:	drivers/net/ethernet/rocker/
>  
>  ROCKETPORT DRIVER
> -P:	Comtrol Corp.
> +E:	Comtrol Corp.

There's already a W: field pointing to the company that maintains it.
So, IMHO this is simply duplicated stuff that can be removed.

>  W:	http://www.comtrol.com
>  S:	Maintained
>  F:	Documentation/serial/rocket.txt
> @@ -13577,15 +13577,15 @@ F:	drivers/video/fbdev/simplefb.c
>  F:	include/linux/platform_data/simplefb.h

>  SIMTEC EB110ATX (Chalice CATS)
> -P:	Ben Dooks
> -P:	Vincent Sanders <vince@simtec.co.uk>
> +E:	Ben Dooks
> +M:	Vincent Sanders <vince@simtec.co.uk>
>  M:	Simtec Linux Team <linux@simtec.co.uk>
>  W:	http://www.simtec.co.uk/products/EB110ATX/
>  S:	Supported
>  
>  SIMTEC EB2410ITX (BAST)
> -P:	Ben Dooks
> -P:	Vincent Sanders <vince@simtec.co.uk>
> +E:	Ben Dooks
> +M:	Vincent Sanders <vince@simtec.co.uk>
>  M:	Simtec Linux Team <linux@simtec.co.uk>
>  W:	http://www.simtec.co.uk/products/EB2410ITX/
>  S:	Supported

On the above two drivers, I've no idea why to keep it there. Ben Dooks
seems to be a past maintainer. He is already listed at CREDITS
for several things including Simtec.

So, I guess this information is duplicated/obsoleted and could just 
be removed.

Cheers,
Mauro
