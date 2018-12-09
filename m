Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E6A20874
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544356163;
	bh=M81lS9VhPc4yl/fdTYxCqwkk1R2Hk3sQ5NnKDbX5zsQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hQL329n373ZOs8QO0lON4Cz1kzp/hd2k1TdSnXLux6bhb7F6YEhIp5CNyfTTQYq1o
	 iNy0AHmU1Qg+V85u1sLN2EaLOFAhL10UGZM35CKzJ2adYy1nHk8KyTzOVgNg0+JJob
	 rKoiM0gvB1R5B31+5V3h2lioriAU2FjyXrcuqKWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E6A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeLILtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 06:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeLILtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 06:49:21 -0500
Received: from localhost.localdomain (unknown [178.38.170.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB822081C;
        Sun,  9 Dec 2018 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544356160;
        bh=M81lS9VhPc4yl/fdTYxCqwkk1R2Hk3sQ5NnKDbX5zsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=xnw0cSbkF61NFfPbKDTKBGypK9fCwbWf5iBmO90k1WXP9TT2zfHg+8CtkK5b8cVRN
         hQQJ9lrFe88SHi3G31AHr0BRQ+WLHqd0c1OkZQHx38SyHyfhIg92I3MW6nVNeklf+1
         iMhm8IDpX8d7iB0nHRw7VS0IYn/H+alN2J8uLMGY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM: exynos: Stuff for v4.21
Date:   Sun,  9 Dec 2018 12:49:07 +0100
Message-Id: <20181209114911.25194-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No dependencies, please pull in any order.

I extended the validity of my key (it was set to expire on March 2019) so
please run "gpg --refresh-keys".

Best regards,
Krzysztof
