Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBC621019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTZBe/DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBC621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeKIHp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbeKIHp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:27 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80AC32089F;
        Thu,  8 Nov 2018 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714876;
        bh=p6fUDyphGUjXk0ZNPPQI2YmF8quBNUGWVKE7XtAQE50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTZBe/DQwuCvlQS7IYv/rYbWbFLu5aYctlm2mW/3fRv31hFYTzuIyORhylgcnqpCu
         6oCTLW6A889zEciNmzgQ1swapgTJmHULzFlb9hpkIA8W2Z9qIoqEyS7YRl6/NpQX5k
         Th1KQmzZLhm4R1DFGx95LM3uUy4Up4+NAtiXj2ZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mikhail Nikiforov <jackxviichaos@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 166/171] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM
Date:   Thu,  8 Nov 2018 13:52:16 -0800
Message-Id: <20181108215138.961716928@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Nikiforov <jackxviichaos@gmail.com>

commit 13c1c5e4d7f887cba36c5e3df3faa22071c1469f upstream.

Add ELAN061C to the ACPI table to support Elan touchpad found in Lenovo
IdeaPad 330-15IGM.

Signed-off-by: Mikhail Nikiforov <jackxviichaos@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1251,6 +1251,7 @@ static const struct acpi_device_id elan_
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },


