Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeDDU3o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:29:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751965AbeDDU3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:29:43 -0400
From: Lyude Paul <lyude@redhat.com>
To: intel-gfx@lists.freedesktop.org
Cc: "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 0/1] Keep AUX on while disabling DPMS for MST
Date: Wed,  4 Apr 2018 16:29:30 -0400
Message-Id: <20180404202932.6811-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend that was required anyway since I missed some t-b's and some acks.
Trying to figure out what patchwork is doing that's making this patch
not get noticed. Maybe it's the lack of cover letters on the previous
versions of this....

Lyude Paul (1):
  drm/i915: Keep AUX block running when disabling DPMS for MST

 drivers/gpu/drm/i915/intel_dp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.14.3
