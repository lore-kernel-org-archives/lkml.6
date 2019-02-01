Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C47C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0D321902
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549048650;
	bh=75ZLFiPwniMlgo+gqWi2At3BvFJjbUDFyJ5A/S0sIZI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Yu3EKIDGW7VmsFkJxtJa3UUWvjL/JS6zmn0NHU93S7Vt+6iuA4aMtj8HMdZgJg0ue
	 eBTzMVkIk9PW5xQQczyt064r1yK4OiFFUV9rkPV0ep6SXEi2BdCekChpdZt6GrBIOY
	 u+D1fRzUMWqtFw+nMx5oz+1Zl3G0o94o9tp1mYYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfBATR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfBATR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:17:29 -0500
Received: from localhost.localdomain (80-123-14-12.adsl.highway.telekom.at [80.123.14.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4755218AF;
        Fri,  1 Feb 2019 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549048648;
        bh=75ZLFiPwniMlgo+gqWi2At3BvFJjbUDFyJ5A/S0sIZI=;
        h=From:To:Cc:Subject:Date:From;
        b=kG/Bp0NF1+rSBM9U/p53+1Q1JDA3bPlLoZ/pRM+dqo3JDMwsBxCw1CZrTsgQJvO8Z
         90HM85deqNXwYr6SfQRYtA1r+M5q43BpNtIJBKXNTJL6kx+Hg2ayWyM8MWNx3I1EMe
         bgHPLJ9z7Te//t4Piyc+lOaV4VVXkdpHTRhsc0QQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] ARM: defconfig: Samsung for v5.1
Date:   Fri,  1 Feb 2019 20:17:19 +0100
Message-Id: <20190201191720.20464-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.1

for you to fetch changes up to 25c390ec22167f896dbf5fb61b869ad05ce273ff:

  ARM: s5pv210_defconfig: Enable cpufreq (2019-01-13 10:31:17 +0100)

----------------------------------------------------------------
Samsung defconfig changes for v5.1

Enable more drivers in s5pv210 defconfig for Aries family of mobile
devices (e.g. Samsung Galaxy S).

----------------------------------------------------------------
Paweł Chmiel (3):
      ARM: s5pv210_defconfig: Run make savedefconfig
      ARM: s5pv210_defconfig: Enable more drivers present on Samsung Aries
      ARM: s5pv210_defconfig: Enable cpufreq

 arch/arm/configs/s5pv210_defconfig | 47 +++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)
