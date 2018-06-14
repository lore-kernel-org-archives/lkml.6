Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 857E8C07D5D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458982086A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964993AbeFNQOU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:14:20 -0400
Received: from osg.samsung.com ([64.30.133.232]:46337 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755523AbeFNQJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:09:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 078FA20F3C;
        Thu, 14 Jun 2018 09:09:33 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zJ_WCHcuRv9A; Thu, 14 Jun 2018 09:09:32 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id 9F73720EB1;
        Thu, 14 Jun 2018 09:09:16 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTUoE-0005TR-Bk; Thu, 14 Jun 2018 13:09:14 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 17/27] bindings: nvmem/zii: Fix location of nvmem.txt
Date:   Thu, 14 Jun 2018 13:09:02 -0300
Message-Id: <fcfc83951a2997c527126af1fdd6fb1e0acbe27d.1528990947.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1528990947.git.mchehab+samsung@kernel.org>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location pointed there is missing "bindings/" on its path.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
index d5e22fc67d66..0df79d9e07ec 100644
--- a/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
+++ b/Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
@@ -18,7 +18,7 @@ Optional properties:
 Data cells:
 
 Data cells are child nodes of eerpom node, bindings for which are
-documented in Documentation/bindings/nvmem/nvmem.txt
+documented in Documentation/devicetree/bindings/nvmem/nvmem.txt
 
 Example:
 
-- 
2.17.1

