Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7zYJ6g8"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A419607C7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeFFLkd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:40:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38223 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeFFLkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:40:32 -0400
X-Google-Smtp-Source: ADUXVKKxGDgxuHr2GQK4L/JXbKyTl04WoCBoeib9C/fHTLHiTSAdfAgBYD/OOX5Smq3GTDQ2A2QGfw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, colin.king@canonical.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: staging: rtl8192e: Series of coding style changes
Date: Wed,  6 Jun 2018 12:39:55 +0100
Message-Id: <20180606114003.22654-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 6 : Sorry to send this out again but version 5 contained a little less
verbosity then required.

Again these are just some simple coding style changes to the file, so nothing
of importance.
