Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48172085B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cud8y/FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfAGCtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:49:23 -0500
Received: from m50-132.163.com ([123.125.50.132]:51719 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbfAGCtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=M+8bXuvXzaxhUUFiCL
        LYdH/RLHfvVkD5F+bHCDXN9HY=; b=cud8y/FSixtTywsuOJ44GDw6gmpAic8TDu
        VC/Aq1HyPSW6rzBm64iwipPomJyCVq1viTrVlC/6B+TGcP7zhnXhS09tmCtofSbq
        g9WikSKU/8b5RnT0iX4OpXtZfGWQqRty1EV3zR7g1LqsOeIuzKqX3ZIs4UsBD6zc
        DWukibYec=
Received: from localhost.localdomain.localdomain (unknown [111.205.43.247])
        by smtp2 (Coremail) with SMTP id DNGowACXzyuAujJcPOxpAw--.944S2;
        Mon, 07 Jan 2019 10:33:37 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] ACPI/nfit: delete the redundant header file
Date:   Mon,  7 Jan 2019 10:33:35 +0800
Message-Id: <1546828416-3040-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DNGowACXzyuAujJcPOxpAw--.944S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVyxRDUUUU
X-Originating-IP: [111.205.43.247]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbiVAE1QFUMGski-gAAs2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

The header file "intel.h" is repeated here, So delete one.

Xiaochun Lee (1):
  ACPI/nfit: delete the redundant header file

 drivers/acpi/nfit/core.c | 1 -
 1 file changed, 1 deletion(-)

-- 
1.8.3.1


