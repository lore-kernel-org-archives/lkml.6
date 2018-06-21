Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E044BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B6E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="jBdtvX++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B6E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933454AbeFUQid (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:38:33 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50548 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933297AbeFUQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Akt8sTdtxhWD51na/Xw+RURO9049zr72RiMQ40/1W+o=; b=jBdtvX++Ler4UxjqzfA7lO9KXS
        v9FGYNd47g7Am3Vmilv1H5QUwyMMxOyaRFdD/6DRkX/Y39xnnsQlrgDd/jbgEO5xw4ewP6xoayEH0
        eygKudildnwv2FtpgpN5jHaqX/rDYq1Nw/3TNgHY7Xw/tO+oIg95Eq27C8l3RzcAr4nK2/TPg2rAh
        DEtimzmKzg61pLzl+V0qmFoMBbw5+cZOkZApJyFMVvGV6XqcVe5R+j7VK7PYRTdUtqdPA+NoGZmWO
        ed7yRXHG0/3qKOh1asLpLEUJHHKpMmDYbXJpynDkPw7bvOGlLms68iWW7Pq3jnZfNq4E/yIM3Ngq/
        q0mmVtgw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:35444 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fW2bP-00302N-Du; Thu, 21 Jun 2018 16:38:31 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.18-rc2
Date:   Thu, 21 Jun 2018 09:38:30 -0700
Message-Id: <1529599110-4073-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.18-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.18-rc2

Thanks,
Guenter
------

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.18-rc2

for you to fetch changes up to 91bb8f45f73f19a0150c233c0f11cdeb6d71d1e9:

  hwmon: (nct6775) Fix loop limit (2018-06-16 16:40:36 -0700)

----------------------------------------------------------------
hwmon fixes for v4.18-rc2

- Fix a loop limit in nct6775 driver
- Disable fan support for Dell XPS13 9333

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (nct6775) Fix loop limit

Helge Eichelberg (1):
      hwmon: (dell-smm) Disable fan support for Dell XPS13 9333

 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 drivers/hwmon/nct6775.c        | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)
