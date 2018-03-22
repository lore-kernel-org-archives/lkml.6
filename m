Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCVVcE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:32:04 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52032 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751899AbeCVVcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:32:02 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>,
        "Zhi Wang" <zhi.a.wang@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180322182154.GA21590@embeddedgus>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180322182154.GA21590@embeddedgus>
Message-ID: <152175429362.23562.9645295347693081397@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] drm/i915/gvt/scheduler: Remove unnecessary NULL checks in
 sr_oa_regs
Date: Thu, 22 Mar 2018 21:31:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-03-22 18:21:54)
> The checks are misleading and not required [1].
> 
> [1] https://lkml.org/lkml/2018/3/19/1792
> 
> Addresses-Coverity-ID: 1466017
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Zhenyu?
-Chris
