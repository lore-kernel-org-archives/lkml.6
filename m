Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F0BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8BD2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8BD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeH1Po2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:44:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:55098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeH1Po2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:44:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B656CAED3;
        Tue, 28 Aug 2018 11:53:08 +0000 (UTC)
Date:   Tue, 28 Aug 2018 13:53:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sean O'Brien <seobrien@chromium.org>
cc:     Dmitry Torokhov <dtor@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] [v2] HID: add support for Apple Magic Keyboards
In-Reply-To: <20180827200215.172838-1-seobrien@chromium.org>
Message-ID: <nycvar.YFH.7.76.1808281352550.25787@cbobk.fhfr.pm>
References: <20180827200215.172838-1-seobrien@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Sean O'Brien wrote:

> USB device
> 	Vendor 05ac (Apple)
> 	Device 026c (Magic Keyboard with Numeric Keypad)
> 
> Bluetooth devices
> 	Vendor 004c (Apple)
> 	Device 0267 (Magic Keyboard)
> 	Device 026c (Magic Keyboard with Numeric Keypad)
> 
> Support already exists for the Magic Keyboard over USB connection.
> Add support for the Magic Keyboard over Bluetooth connection, and for
> the Magic Keyboard with Numeric Keypad over Bluetooth and USB
> connection.
> 
> Signed-off-by: Sean O'Brien <seobrien@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

