Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE3C2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE3C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeKZK3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 05:29:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:59055 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeKZK3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 05:29:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wAPNb90p017312;
        Sun, 25 Nov 2018 17:37:10 -0600
Message-ID: <b0960d55bb1895253caefe942f8065ac84213267.camel@kernel.crashing.org>
Subject: [GIT PULL] FSI fixes for 4.20
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Nov 2018 10:37:08 +1100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

Here are two very minor fixes for FSI. One from Arnd is a Kconfig fixup
and has been rusting away in my tree for a while (I had forgotten about
it). The other one just removes a duplicate #include, courtesy of
Brajeswar Ghosh.

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/linux-fsi.git tags/fsi-updates-2018-11-26

for you to fetch changes up to d20810530b7109a95abef5130e6dcec09c5180d7:

  fsi: fsi-scom.c: Remove duplicate header (2018-11-26 10:13:04 +1100)

----------------------------------------------------------------
Arnd Bergmann (1):
      fsi: master-ast-cf: select GENERIC_ALLOCATOR

Brajeswar Ghosh (1):
      fsi: fsi-scom.c: Remove duplicate header

 drivers/fsi/Kconfig    | 1 +
 drivers/fsi/fsi-scom.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

