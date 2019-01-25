Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB95C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0F3218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="g+nHJNhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfAYNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:36:35 -0500
Received: from forward102o.mail.yandex.net ([37.140.190.182]:45573 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbfAYNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:36:35 -0500
Received: from mxback6o.mail.yandex.net (mxback6o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::20])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 8419C668015F;
        Fri, 25 Jan 2019 16:36:31 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback6o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id vFiS5YJg6O-aPDigmwh;
        Fri, 25 Jan 2019 16:36:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548423385;
        bh=A48o3xeGl6AdGkx8lkIj+fXHoKo7x47wzRKWnuL/2jE=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=g+nHJNhrfV8RknZF6/s88PAaROf0VuneJkrPWsWhXiQEWxIyuCW5WWSK2B6BVimZI
         XY4ao37SFBdDSHHp1JsQzIQ3Mc82PV3CUy3x+wOOw4c0MZXpUDdkHv4wb+6TchS+9q
         kxR2DuXNBFMCK4qKjydrWAidjGPcrCQNq4D1E9sU=
Authentication-Results: mxback6o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id XwuTEG9eza-aKeacMcW;
        Fri, 25 Jan 2019 16:36:23 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] Enhance loongson-1 clock driver
Date:   Fri, 25 Jan 2019 21:34:10 +0800
Message-Id: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add of support for ls1c-clock and ls1b-clock


