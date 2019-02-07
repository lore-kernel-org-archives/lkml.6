Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F64E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVWIc01U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBGWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:30:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGWaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iLtooaSkEDgcosX1XSHC15t66y2mjw+jQsXju6D9jgI=; b=EVWIc01UpI+zycT5Vtp4yD7DPM
        K60nkrKooVyG4AWc4PDZHvU5lzyoAEP/rdTJqAMkPIG1u8UKSemFu5cm+ZYdduGrm1XbBKvEw0NM2
        eS5vK5dw1tJhw2SFBFkpHnem98VRpbW4KggsBhjT6yp9myWikoMY3X1EnDnSEcfzbB7QpV1DEib+k
        6jxGa72yOE6Nblh2KbhN2e59mR8hGYewXqpjj+9HNd8/BfMWi3C6jB7LH8HOxX9GW/JNF03PVp43i
        aTkkv+ZGQZ2NynUlXGi7Y/yBx0p7EDZEZQfe1lzMW+JZY3ef8kJeFqF4VNRz3ddVolTzGO5LiTB+y
        85cFlg5Q==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grsBY-0004AH-56; Thu, 07 Feb 2019 22:30:20 +0000
Date:   Thu, 7 Feb 2019 14:30:17 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.0-2
Message-ID: <20190207223017.GA27814@wrath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.0-2

for you to fetch changes up to 6a730fcb9cb472ba2d42b26a50ac65dacdd68882:

  Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0 (2019-01-26 11:30:26 -0800)

Thanks,

Darren Hart
VMware Open Source Technology Center

----------------------------------------------------------------
platform-drivers-x86 for v5.0-2

Correct Documentation/ABI 4.21 KernelVersion to 5.0.

The following is an automated git shortlog grouped by driver:

Documentation/ABI:
 -  Correct mlxreg-io KernelVersion for 5.0

----------------------------------------------------------------
Darren Hart (VMware) (1):
      Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0

 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Darren Hart
VMware Open Source Technology Center
