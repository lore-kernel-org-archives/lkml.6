Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C93CC64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0937A2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0937A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeJCPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:46:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727648AbeJCPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:46:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8272AD7D;
        Wed,  3 Oct 2018 08:59:13 +0000 (UTC)
Date:   Wed, 3 Oct 2018 10:59:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sean O'Brien <seobrien@chromium.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marek Wyborski <marek.wyborski@emwesoft.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        Claudio Mettler <claudio@ponyfleisch.ch>
Subject: Re: [PATCH] [v4] HID: add support for Apple Magic Trackpad 2
In-Reply-To: <20181002225337.7349-1-seobrien@chromium.org>
Message-ID: <nycvar.YFH.7.76.1810031059000.14430@cbobk.fhfr.pm>
References: <20181002225337.7349-1-seobrien@chromium.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Sean O'Brien wrote:

> USB device
>         Vendor 05ac (Apple)
>         Device 0265 (Magic Trackpad 2)
> Bluetooth device
>         Vendor 004c (Apple)
>         Device 0265 (Magic Trackpad 2)
> 
> Add support for Apple Magic Trackpad 2 over USB and bluetooth, putting
> the device in multi-touch mode.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

