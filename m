Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8748420645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8748420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeIDXYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:24:34 -0400
Received: from namei.org ([65.99.196.166]:45846 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeIDXYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:24:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w84IvtPm019665;
        Tue, 4 Sep 2018 18:57:56 GMT
Date:   Wed, 5 Sep 2018 04:57:55 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
cc:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: tomoyo: Fix obsolete function
In-Reply-To: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
Message-ID: <alpine.LRH.2.21.1809050457380.17815@namei.org>
References: <1536050499-20889-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Ding Xiang wrote:

> simple_strtoul is obsolete, and use kstrtouint instead
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

and next-testing.



-- 
James Morris
<jmorris@namei.org>

