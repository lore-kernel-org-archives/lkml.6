Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeEBPj0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:39:26 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64273 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751171AbeEBPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:39:18 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Matthias Kaehlcke <mka@chromium.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <152525436760.32109.17749926643981003077@mail.alporthouse.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, "Guenter Roeck" <groeck@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>
References: <20180501182440.70121-1-mka@chromium.org>
 <152525436760.32109.17749926643981003077@mail.alporthouse.com>
Message-ID: <152527554986.28472.11238909533010607091@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH v3] drm/i915: Disable some extra clang warnings
Date: Wed, 02 May 2018 16:39:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2018-05-02 10:46:07)
> Quoting Matthias Kaehlcke (2018-05-01 19:24:40)
> > Commit 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> > warnings to full") enabled extra warnings for i915 to spot possible
> > bugs in new code, and then disabled a subset of these warnings to keep
> > the current code building without warnings (with gcc). Enabling the
> > extra warnings also enabled some additional clang-only warnings, as a
> > result building i915 with clang currently is extremely noisy. For now
> > also disable the clang warnings sign-compare, sometimes-uninitialized,
> > unneeded-internal-declaration and initializer-overrides. If desired
> > they can be re-enabled after the code has been fixed.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

I've picked this for inclusion and will push shortly.
Thanks for the patch,
-Chris
