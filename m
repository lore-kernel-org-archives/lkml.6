Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB9421104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdJwAdr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB9421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeKZVqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbeKZVqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:46:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D5321104;
        Mon, 26 Nov 2018 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229590;
        bh=+9gZ0N+vfmTbliD6mG/n9u4cHNtGHG1kJX+1iTWJouQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdJwAdr31eGjtSrRQ8ay+4/cZp2vq9JWl4lotwp6xQQXby6+p77XdjC3ZP6cGmY6B
         yb67XS0XXE8t1cwL/02p9OPpDW7Cg+tm49l6QwVfCE7EAskyLiC86dKAvwtWDwUsUi
         l+J1QGLmYmFjLE84Iq7aCaaQIqv1sq8/FYGSFTOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>
Subject: [PATCH 3.18 21/24] USB: misc: appledisplay: add 20" Apple Cinema Display
Date:   Mon, 26 Nov 2018 11:51:15 +0100
Message-Id: <20181126105032.656544113@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mattias Jacobsson <2pi@mok.nu>

commit f6501f49199097b99e4e263644d88c90d1ec1060 upstream.

Add another Apple Cinema Display to the list of supported displays

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/appledisplay.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -63,6 +63,7 @@ static const struct usb_device_id appled
 	{ APPLEDISPLAY_DEVICE(0x9219) },
 	{ APPLEDISPLAY_DEVICE(0x921c) },
 	{ APPLEDISPLAY_DEVICE(0x921d) },
+	{ APPLEDISPLAY_DEVICE(0x9222) },
 	{ APPLEDISPLAY_DEVICE(0x9236) },
 
 	/* Terminating entry */


