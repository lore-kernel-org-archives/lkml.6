Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7004C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D4120833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MKR6ok61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D4120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeIKRFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:05:38 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50584 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeIKRFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:05:38 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3E7F410C0EE8;
        Tue, 11 Sep 2018 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536667596; bh=je6NQKqWF0FgI0oxeV+NWAQKR7FhObcWYSxcBu/yMsw=;
        h=From:To:Cc:Subject:Date:From;
        b=MKR6ok61ln7D1MYiMpwqfRvf+3/0gIs9NG03AEd2f7noKJdbLW1Vv7M2pPIgJB1sb
         2s3cv2HSkpG/o2JAZMM9CLy0WiLW1is0dReBd4gjL8rAXTcDMCupAVkEjuG9Jyt7as
         9RUVZ42jTcMFjdf0qX9uwoYBvGsHBTRJG17fyDyRylXeR5YudcqtoxIgnVljA5FEiV
         RialKPbMGkZttOcmv5mZULK9I9WM7gXkH/lYpuWcRHg3D63a0do+Q69qoBAwUNwPXd
         ZmJ1/MWQ5y1o4pDB9Q1bztEC/sDEaLEGHbPIYxV9GV8zY2NAcWj6VZWRvDvd6BmeuP
         Ol24YuJmk2x1A==
Received: from jpinto-box.internal.synopsys.com (jpinto-e7440.internal.synopsys.com [10.107.19.76])
        by mailhost.synopsys.com (Postfix) with ESMTP id 82E1353F8;
        Tue, 11 Sep 2018 05:06:34 -0700 (PDT)
From:   Joao Pinto <Joao.Pinto@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com
Cc:     gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] PCI: designware: Change maintainer to Gustavo Pimentel
Date:   Tue, 11 Sep 2018 13:06:30 +0100
Message-Id: <aa29f3f8dbae3a2c8523ddfd74d11505600bc47f.1536659938.git.jpinto@synopsys.com>
X-Mailer: git-send-email 2.9.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently I am managing the Synopsys drivers & tools team (full-time) and so I
am passing the pcie-designware maintenance to Gustavo.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC: Jingoo Han <jingoohan1@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b..e5e8984 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11153,7 +11153,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
-M:	Joao Pinto <Joao.Pinto@synopsys.com>
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
-- 
2.9.3


