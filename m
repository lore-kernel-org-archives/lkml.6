Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA64C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31FE21479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkcporTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31FE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbeKZVyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbeKZVyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DB02089F;
        Mon, 26 Nov 2018 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230065;
        bh=ijCryN4qeOnAYigIKnM5Ctmyf1V0a3Wq0Px/wYQWQtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkcporTukDt5ILZGAsb2jqKzGSCNtAmRbetS0ho9gZtWlSBVVUFj1YAGrm60z2f2h
         I5gqaT3a1mLwfL9XGL28uQyp5uci4r51NK11OibOtZcYWw/gSMERO1bBcxSZE3tPJS
         xo+XsNDxOmv+u1I1IhQ/S6BSplAlnGUYzxSmtjw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>
Subject: [PATCH 4.14 57/62] USB: misc: appledisplay: add 20" Apple Cinema Display
Date:   Mon, 26 Nov 2018 11:51:38 +0100
Message-Id: <20181126105054.886737466@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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


