Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C7220838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="z5jAL+fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C7220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeIZTD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:03:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50662 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:03:29 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C9A3D5C0452;
        Wed, 26 Sep 2018 14:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537966237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=a1lR5HWgsII+2KzZThh43DCPu0gMT4DqUOPyNaYPo0U=;
        b=z5jAL+fiu9yZfe+n2wjXsmnzE5NAQTeaRz0uYfnuRJkabphRmb23F06UWG+HEdJ1ZZJmTV
        4GBNT7BclzYGX5uKTG2aMwkdJK8fZ3wFaRYGFhKFFPxLu7sTPNfwfwsYvIBa6xbMuU0+q+
        PN4lZB32kEuUJHWOlTTmFdHyT5AXMQc=
From:   Stefan Agner <stefan@agner.ch>
To:     sean@poorly.run
Cc:     alison.wang@nxp.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] MAINTAINERS: Move fsl-dcu driver to drm-misc tree
Date:   Wed, 26 Sep 2018 14:50:34 +0200
Message-Id: <20180926125034.4095-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is mostly in maintenance mode. Using drm-misc is a
good fit and should make maintenance a bit easier.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 02a39617ec82..6646a3d098a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4822,6 +4822,7 @@ F:	drivers/gpu/drm/fsl-dcu/
 F:	Documentation/devicetree/bindings/display/fsl,dcu.txt
 F:	Documentation/devicetree/bindings/display/fsl,tcon.txt
 F:	Documentation/devicetree/bindings/display/panel/nec,nl4827hc19-05b.txt
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 
 DRM DRIVERS FOR FREESCALE IMX
 M:	Philipp Zabel <p.zabel@pengutronix.de>
-- 
2.19.0

