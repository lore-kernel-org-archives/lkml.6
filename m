Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBA12087E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Yttp0ABY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA1PVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:21:24 -0500
Received: from forward101j.mail.yandex.net ([5.45.198.241]:54622 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfA1PVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:21:23 -0500
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id E9BA81BE1C27;
        Mon, 28 Jan 2019 18:21:20 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id k7pNLSbGGa-LK0eUBKD;
        Mon, 28 Jan 2019 18:21:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548688880;
        bh=KY2INEUQYvURyvKT5+mZgBEHRZYcrS53jl3RH8nd4kE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Yttp0ABY7O429nYt2p6aJmoArQoIQP2CHewFcwkLqt7231SS0n3rTU5eWiTG/x9b7
         yd/HinoXBpFlqPJekPLIgoYGxDXIWO3OHLEqUyh9s+k11z9piL6OCAGq0sBf+C3Rmp
         6tFYxwJo9qp61DVrz74Wnk6gFIgbqllzpv88HHaM=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id EWlCXSEkWL-LAnWx4d3;
        Mon, 28 Jan 2019 18:21:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 0/3] Enhance loongson-1 clock driver
Date:   Mon, 28 Jan 2019 23:20:49 +0800
Message-Id: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
References: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add of support for ls1c-clock and ls1b-clock
v2: Move of declear into per clk file


