Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAB6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88299214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88299214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbeKVFWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:22:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727628AbeKVFWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:22:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48E26ADA9;
        Wed, 21 Nov 2018 18:46:59 +0000 (UTC)
Date:   Wed, 21 Nov 2018 19:46:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HID: revert the Logitech High Resolution wheel
 support
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1811211946380.21108@cbobk.fhfr.pm>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Benjamin Tissoires wrote:

> It turns out that the implementation of the high resolution support of
> Logitech wheels is rather incompatible with the mice from Microsoft.
> 
> We had a lengthy discussion off-list and the summary is quoted in 7/7.
> 
> The TL;DR, we need to revert the current series before it gets out in
> a released kernel and work on a better approach for 4.21.
> 
> This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
> and Peter, but I wouldn't mind a public ack before I push this to
> the for-linus branch.

As discussed previously

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

