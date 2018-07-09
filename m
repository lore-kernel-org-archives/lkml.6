Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71877C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA520871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FA520871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeGIJvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:51:21 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:8369 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbeGIJvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:51:20 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w699pHoQ021380;
        Mon, 9 Jul 2018 11:51:17 +0200
Date:   Mon, 9 Jul 2018 11:51:17 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: save NVS memory for ASUS 1025C laptop
Message-ID: <20180709095117.GA21102@1wt.eu>
References: <1531059617-19681-1-git-send-email-w@1wt.eu>
 <3003662.PMZt7LD2T1@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3003662.PMZt7LD2T1@aspire.rjw.lan>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:46:23AM +0200, Rafael J. Wysocki wrote:
> Please resend this one with a CC to linux-acpi@vger.kernel.org

Will do, thank you Rafael.

Willy
