Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426050AbeBOQeo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:34:44 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:63771 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1425903AbeBOQem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:34:42 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <627959e2-ab9a-49bc-27ea-0a69a17c68a6@embeddedor.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180214211234.GA22341@embeddedgus> <87vaey4nv8.fsf@intel.com>
 <627959e2-ab9a-49bc-27ea-0a69a17c68a6@embeddedor.com>
Message-ID: <151871247526.11261.15323797340765785326@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] drm/i915/selftests: fix inconsistent IS_ERR and PTR_ERR
Date: Thu, 15 Feb 2018 16:34:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-02-15 16:09:09)
> 
> 
> On 02/15/2018 03:13 AM, Jani Nikula wrote:
> > On Wed, 14 Feb 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >> Fix inconsistent IS_ERR and PTR_ERR in shrink_boom.
> >> The proper pointer to use is _explode_ instead of _purge_.
> >>
> >> This issue was detected with the help of Coccinelle.
> >>
> >> Fixes: fe215c8bc426 ("drm/i915/selftests: add missing gtt shrinker test")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > (Having some issues with fdo connections, thus not pushing.)
> >
> 
> Thanks, Jani

And pushed, thanks for the patch and review.
-Chris
