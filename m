Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E7C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E0B20672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E0B20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbeLCHvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:51:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48796 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbeLCHvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:51:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 02A7A20CFA; Mon,  3 Dec 2018 08:51:47 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3A69120786;
        Mon,  3 Dec 2018 08:51:46 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, robert.jarzmik@free.fr,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        miquel.raynal@bootlin.com, keescook@chromium.org,
        shreeya.patel23498@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: mtd: use DEFINE_SHOW_ATTRIBUTE() instead of open-coding it
Date:   Mon,  3 Dec 2018 08:51:45 +0100
Message-Id: <20181203075145.28502-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 07ce7a03138f52ceeafeb4557a306dfa723d32a1
In-Reply-To: <20181202083358.10896-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-02 at 08:33:58 UTC, Yangtao Li wrote:
> DEFINE_SHOW_ATTRIBUTE macro can help us simplify the code,so change
> to it.And change the DEBUGFS_RO_ATTR macro defined in some file to a
> standard macro.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
