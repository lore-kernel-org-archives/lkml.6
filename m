Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7078FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39587206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39587206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbeKVRXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:23:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeKVRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:23:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 771E13154846;
        Thu, 22 Nov 2018 06:45:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 367FB5C25A;
        Thu, 22 Nov 2018 06:45:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 71DCB4CCB4; Thu, 22 Nov 2018 07:45:14 +0100 (CET)
Date:   Thu, 22 Nov 2018 07:45:14 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Christophe Fergeau <cfergeau@redhat.com>
Cc:     spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: add spice-devel list to
 MAINTAINERS
Message-ID: <20181122064514.o2dxbk3v2aha2hla@sirius.home.kraxel.org>
References: <20181121090129.23506-1-kraxel@redhat.com>
 <20181121164019.GF3883@natto.ory.fergeau.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121164019.GF3883@natto.ory.fergeau.eu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 22 Nov 2018 06:45:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 05:40:19PM +0100, Christophe Fergeau wrote:
> On Wed, Nov 21, 2018 at 10:01:29AM +0100, Gerd Hoffmann wrote:
> > So qxl kernel patches are sent to the spice-devel list for review.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4caac2f6b0..d9945d57eb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4728,6 +4728,7 @@ DRM DRIVER FOR QXL VIRTUAL GPU
> >  M:	Dave Airlie <airlied@redhat.com>
> >  M:	Gerd Hoffmann <kraxel@redhat.com>
> >  L:	virtualization@lists.linux-foundation.org
> > +L:	spice-devel@lists.freedesktop.org
> 
> Should this also list dri-devel@lists.freedesktop.org ?

Not needed I think, there is a "DRM DRIVERS" entry for everything below
drivers/gpu/drm which includes dri-devel.

cheers,
  Gerd

