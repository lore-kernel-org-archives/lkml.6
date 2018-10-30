Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BDEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8231320664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8231320664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeJ3O2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbeJ3O2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:28:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC3F63082E10;
        Tue, 30 Oct 2018 05:36:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E79F60BE1;
        Tue, 30 Oct 2018 05:36:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B0523B3DC7; Tue, 30 Oct 2018 06:36:35 +0100 (CET)
Date:   Tue, 30 Oct 2018 06:36:35 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: Re: [PATCH] gpu/drm/virtio/virtgpu_vq.c: Use kmem_cache_zalloc
Message-ID: <20181030053635.xwys3njelwa4j4vc@sirius.home.kraxel.org>
References: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com>
 <CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
 <87sh0xc7pv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh0xc7pv.fsf@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 30 Oct 2018 05:36:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 12:50:36PM +0300, Jani Nikula wrote:
> On Tue, 23 Oct 2018, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > On Fri, Oct 19, 2018 at 9:30 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> >>
> >> Replaced kmem_cache_alloc + memset with kmem_cache_zalloc
> >
> > Put a new line gap in between these two lines and send v2.
> 
> Nah, the maintainers can trivially add the newline while
> applying. Review is much more valuable than nitpicking on the commit
> message.

Queued (and added newline).

thanks,
  Gerd

