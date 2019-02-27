Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D50C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9515E20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfB0Rey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:34:54 -0500
Received: from smtp8.web4u.cz ([81.91.87.88]:60810 "EHLO mx-8.mail.web4u.cz"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729862AbfB0Rew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:34:52 -0500
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
        by mx-8.mail.web4u.cz (Postfix) with ESMTP id 9BFB21FF423;
        Wed, 27 Feb 2019 18:27:51 +0100 (CET)
Received: from baree.pikron.com (unknown [89.102.8.6])
        (Authenticated sender: ppisa@pikron.com)
        by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 4DCBF1FF28E;
        Wed, 27 Feb 2019 18:27:51 +0100 (CET)
From:   pisa@cmp.felk.cvut.cz
To:     devicetree@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com,
        ondrej.ille@gmail.com, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v2 0/2] dt-bindings: net: can: binding for CTU CAN FD open-source IP core.
Date:   Wed, 27 Feb 2019 18:26:27 +0100
Message-Id: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.11.0
X-W4U-Auth: 95abe65f1fc7238849456d62576355ad1162ff17
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

The patch update, added separate patch to add Czech Technical University
to the vendors list. Change ctu_can_fd_0 instance string to lowercase
(originally uppercase because build from official abbreviations).
Clarify that clock-names are not used for now but can be used in future.

Pavel Pisa (2):
  dt-bindings: vendor-prefix: add prefix for Czech Technical University
    in Prague.
  dt-bindings: net: can: binding for CTU CAN FD open-source IP core.

The corresponding sources for testing program from user-space
and for Linux kernel driver for platform and PCIe IP core
integrations are available there

  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/tree/master/driver/

 .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 108 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt

-- 
2.11.0
