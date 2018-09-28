Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF120C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A92120868
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeI2ERj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:17:39 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:34305 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbeI2ERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:17:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 82576180A8458;
        Fri, 28 Sep 2018 21:51:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fish99_4b0d9a33d8004
X-Filterd-Recvd-Size: 1904
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:51:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'CS3308 MEDIA DRIVER'
Date:   Fri, 28 Sep 2018 14:51:54 -0700
Message-Id: <20180928215154.28947-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	3826	CS3308 MEDIA DRIVER
	3827	M:	Hans Verkuil <hverkuil@xs4all.nl>
	3828	L:	linux-media@vger.kernel.org
	3829	T:	git git://linuxtv.org/media_tree.git
	3830	W:	http://linuxtv.org
	3831	S:	Odd Fixes
	3832	F:	drivers/media/i2c/cs3308.c
-->	3833	F:	drivers/media/i2c/cs3308.h

Commit that introduced this:

commit fc279cc2887f0830b9232e970dd6a5dcd8612f3c
 Author: Hans Verkuil <hans.verkuil@cisco.com>
 Date:   Mon Nov 30 18:05:54 2015 -0200
 
     [media] cs3308: add new 8-channel volume control driver
     
     Add simple support for this 8 channel volume control driver.
     Currently all it does is to unmute all 8 channels.
     
     Based upon Devin's initial patch made for an older kernel which I
     cleaned up and rebased. Thanks to Kernel Labs for that work.
     
     Signed-off-by: Devin Heitmueller <dheitmueller@kernellabs.com>
     Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
     Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
 
  MAINTAINERS                |   9 +++
  drivers/media/i2c/Kconfig  |  10 ++++
  drivers/media/i2c/Makefile |   1 +
  drivers/media/i2c/cs3308.c | 138 +++++++++++++++++++++++++++++++++++++++++++++
  4 files changed, 158 insertions(+)

No commit with drivers/media/i2c/cs3308.h found

