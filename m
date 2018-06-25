Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E82C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EDD25A28
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EDD25A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeFYNQr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:16:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933730AbeFYNQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:16:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CCCBABDF;
        Mon, 25 Jun 2018 13:16:44 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:16:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: hid-ntrig: add error handling for
 sysfs_create_group
In-Reply-To: <1528983437-52903-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <nycvar.YFH.7.76.1806251516350.6203@cbobk.fhfr.pm>
References: <1528707296-35785-1-git-send-email-jiazhouyang09@gmail.com> <1528983437-52903-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Zhouyang Jia wrote:

> When sysfs_create_group fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling sysfs_create_group.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Remove goto statement.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

