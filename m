Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD20C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345C520850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345C520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLCPlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:41:07 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50988 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbeLCPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:41:07 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id C66AB5FCE1; Mon,  3 Dec 2018 23:41:00 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: sunxi: a64: Drop numeral from csi0/ts0
Date:   Mon,  3 Dec 2018 23:40:58 +0800
Message-Id: <20181203154100.4280-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This small series renames the csi0 and ts0 pin function names to csi and
ts. This makes the names match the datasheet. As there are only one of
each type of controller, having a numeral suffix doesn't make sense.

I'd like to do the rename now while we don't have users nor support for
these two controllers. I planned to send this together with CSI support
for the A64, but Jagan beat me to it, so here it is.


Regards
ChenYu

Chen-Yu Tsai (2):
  pinctrl: sunxi: a64: Rename function csi0 to csi
  pinctrl: sunxi: a64: Rename function ts0 to ts

 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c | 52 +++++++++++-----------
 1 file changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.0.rc1

