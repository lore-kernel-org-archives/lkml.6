Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFCAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69552073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69552073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeI2ERC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:17:02 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:40487 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726303AbeI2ERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:17:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 68199182CED2A;
        Fri, 28 Sep 2018 21:51:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hill40_45bb6e2f05b3a
X-Filterd-Recvd-Size: 2107
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:51:19 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        openbmc@lists.ozlabs.org
Subject: Bad MAINTAINERS pattern in section 'ARM/NUVOTON NPCM ARCHITECTURE'
Date:   Fri, 28 Sep 2018 14:51:17 -0700
Message-Id: <20180928215117.28711-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	1781	ARM/NUVOTON NPCM ARCHITECTURE
	1782	M:	Avi Fishman <avifishman70@gmail.com>
	1783	M:	Tomer Maimon <tmaimon77@gmail.com>
	1784	R:	Patrick Venture <venture@google.com>
	1785	R:	Nancy Yuen <yuenn@google.com>
	1786	R:	Brendan Higgins <brendanhiggins@google.com>
	1787	L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
	1788	S:	Supported
	1789	F:	arch/arm/mach-npcm/
	1790	F:	arch/arm/boot/dts/nuvoton-npcm*
-->	1791	F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
	1792	F:	drivers/*/*npcm*
	1793	F:	Documentation/devicetree/bindings/*/*npcm*
	1794	F:	Documentation/devicetree/bindings/*/*/*npcm*

Commit that introduced this:

commit 6a498e06ba22872d3a27cc0dae77b9314b1de48b
 Author: Brendan Higgins <brendanhiggins@google.com>
 Date:   Thu Aug 17 09:44:32 2017 -0700
 
     MAINTAINERS: Add entry for the Nuvoton NPCM architecture
     
     Add maintainers and reviewers for the Nuvoton NPCM architecture.
     
     Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
     Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
     Reviewed-by: Avi Fishman <avifishman70@gmail.com>
     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
 
  MAINTAINERS | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

No commit with include/dt-bindings/clock/nuvoton,npcm7xx-clks.h found

