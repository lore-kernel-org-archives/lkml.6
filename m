Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934634AbeDXNhE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:37:04 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:54265 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934178AbeDXNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:36:57 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <09f02909-90cb-60f0-e362-7d5314dd8964@embeddedor.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180424131545.GA4053@embeddedor.com>
 <152457614368.12387.9348969127399551440@mail.alporthouse.com>
 <09f02909-90cb-60f0-e362-7d5314dd8964@embeddedor.com>
Message-ID: <152457701306.12387.8661221098982971725@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] drm/i915/selftests: Fix uninitialized variable
Date: Tue, 24 Apr 2018 14:36:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-04-24 14:30:58)
> 
> 
> On 04/24/2018 08:22 AM, Chris Wilson wrote:
> > Quoting Gustavo A. R. Silva (2018-04-24 14:15:45)
> >> There is a potential execution path in which variable err is
> >> returned without being properly initialized previously.
> >>
> >> Fix this by initializing variable err to 0.
> > 
> > err is only returned along an error path, returning 0 would not be
> > useful. Which path? All the error paths look correct to me.
> > -Chris
> > 
> 
> If the following two conditions take the false branch then the function 
> returns err with a random stack value:


It would help if I read the right function. Ok,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
