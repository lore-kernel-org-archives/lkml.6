Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5D02173A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D02173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeHXNfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:35:39 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:34476 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXNfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:35:39 -0400
Received: from tony.xie?rock-chips.com (unknown [192.168.167.139])
        by lucky1.263xmail.com (Postfix) with ESMTP id 32555424;
        Fri, 24 Aug 2018 18:01:38 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 5EE3581B;
        Fri, 24 Aug 2018 18:01:30 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: tony.xie@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: tony.xie@rock-chips.com
X-UNIQUE-TAG: <79dff7e8d317f718aa9d2fe45f390389>
X-ATTACHMENT-NUM: 0
X-SENDER: xxx@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 4311CPZL8M;
        Fri, 24 Aug 2018 18:01:34 +0800 (CST)
From:   Tony Xie <tony.xie@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com
Subject: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for rk3399
Date:   Fri, 24 Aug 2018 18:02:59 +0800
Message-Id: <1535104980-8456-1-git-send-email-tony.xie@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Xie (1):
  arm64: dts: rockchip: Add idle-states to device tree for rk3399

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
1.9.1


