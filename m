Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeDPXJH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:09:07 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36830 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:09:05 -0400
X-Google-Smtp-Source: AIpwx49VtrR65/vza8urkcmX+I/OGwSeWUaaiGEVlVoI9kTQ4cAhnlULpFNj2CfiWpS5YvMEr5iyHQ==
Date: Mon, 16 Apr 2018 16:09:01 -0700
From: Tejun Heo <tj@kernel.org>
To: hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc: guro@fb.com, riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHSET v2] mm, memcontrol: Implement memory.swap.events
Message-ID: <20180416230901.GG1911913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Rebased on top of e27be240df53 ("mm: memcg: make sure memory.events is
uptodate when waking pollers").

This patchset implements memory.swap.events which contains max and
fail events so that userland can monitor and respond to swap running
out.  It contains the following two patches.

 0001-mm-memcontrol-Move-swap-charge-handling-into-get_swa.patch
 0002-mm-memcontrol-Implement-memory.swap.events.patch

This patchset is on top of the current linus#master
(a27fc14219f2e3c4a46ba9177b04d9b52c875532).

Thanks.

-- 
tejun
