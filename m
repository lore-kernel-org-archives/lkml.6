Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33094C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31E52192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392194AbfBOOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:11:57 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44659 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfBOOL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:11:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 03E0CFB06;
        Fri, 15 Feb 2019 15:11:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K68eWVgKyERr; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3835148DC1; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/3] input: goodix - support Goodix gt5688
Date:   Fri, 15 Feb 2019 15:11:50 +0100
Message-Id: <cover.1550239328.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the support for gt5688 two more minimal changes piled up so I'm
folding these in here. One is a doc update for the goodix bindings, the
other one makes it a bit simpler to figure out configuration problems
(like lack of touchscreen-size-{x,y} in the device tree.

I've kept the original subject to (hopefully) not break the series for
patchwork. All patches can be applied independently. Series is based on
next-20190208.

Changes from v2
* Add 'dt-bindings: input: Refer to touchscreen.txt for goodix ts'
* Add 'input: goodix: Print values in case of inconsistencies'
  (sent out separtely before, no comments so far)
* Collect 'Reviewed-By' on 'input: goodix - support Goodix gt5688'

Changes from v1
* Add tested board to commit message

Guido Günther (3):
  input: goodix - support Goodix gt5688
  dt-bindings: input: Refer to touchscreen.txt for goodix ts
  input: goodix: Print values in case of inconsistencies

 .../bindings/input/touchscreen/goodix.txt          | 14 +++++++++-----
 drivers/input/touchscreen/goodix.c                 |  6 +++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.20.1

