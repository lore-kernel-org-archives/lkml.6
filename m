Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeBFPVz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:21:55 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:40613 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeBFPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:21:46 -0500
X-Google-Smtp-Source: AH8x22751AEWbXkbbiVJmf32sKLKqax9R/uZWe/zsHwsVFcHRS8f3y3tRXW2DAL+SgIBqpF09tFVWA==
Date: Tue, 6 Feb 2018 16:21:43 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180206152143.vea6si7ncjj7sxyq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I'm periodically getting following message in dmesg on Lenovo
Thinkpad X1 Carbon 3rd generation:

[drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.

In BIOS I already set GPU size to 512M, but this did not help. Also
update to last BIOS version did not help.

So why this message is periodically print in dmesg? And what can I do
with this problem?

And why cannot Linux kernel allocate itself more memory for GPU (if BIOS
can/could do that)? Is not 512MB for GPU enough?

-- 
Pali Rohár
pali.rohar@gmail.com
