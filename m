Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeDDUyn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:54:43 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51983 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752037AbeDDUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:54:42 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Xidong Wang <wangxidong_97@163.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1522827474-5120-1-git-send-email-wangxidong_97@163.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, "Xidong Wang" <wangxidong_97@163.com>
References: <1522827474-5120-1-git-send-email-wangxidong_97@163.com>
Message-ID: <152287525774.1494.4981557971786322487@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH 1/1] drm/i915: Do not use kfree() to free kmem_cache_alloc()
 return value
Date: Wed, 04 Apr 2018 21:54:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xidong Wang (2018-04-04 08:37:54)
> In eb_lookup_vmas(), the return value of kmem_cache_alloc() is freed
> with kfree(). I think the expected paired function is kmem_cahce_free().
> 
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>

Thank you for the fix; applied.
-Chris
