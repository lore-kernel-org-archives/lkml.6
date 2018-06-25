Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683F1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B68625A57
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B68625A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeFYNYC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:24:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49531 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbeFYNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:24:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB8CBACDD;
        Mon, 25 Jun 2018 13:23:59 +0000 (UTC)
Date:   Mon, 25 Jun 2018 15:23:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Robert Munteanu <rombert@apache.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Munteanu <rombert@apache.org>
Subject: Re: [PATCH] HID: redragon: fix num lock and caps lock LEDs
In-Reply-To: <20180619082040.30825-1-rombert@apache.org>
Message-ID: <nycvar.YFH.7.76.1806251523050.6203@cbobk.fhfr.pm>
References: <20180619082040.30825-1-rombert@apache.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Robert@suse.de wrote:

> From: Robert Munteanu <rombert@apache.org>
> 
> The redragon asura keyboard registers two input devices. The initial
> commit d44e2fadf940 ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")

This should actually have been 85455dd906d.

I have fixed that, added Fixes: tag, and applied.

-- 
Jiri Kosina
SUSE Labs

