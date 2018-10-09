Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA52C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CF22077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CF22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJIP5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:57:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeJIP5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:57:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E45D8AB4C;
        Tue,  9 Oct 2018 08:41:45 +0000 (UTC)
Date:   Tue, 9 Oct 2018 10:41:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
cc:     Dmitry Torokhov <dtor@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 1/2] mfd: cros: add "base attached" MKBP switch
 definition
In-Reply-To: <20181009062855.GA32033@dell>
Message-ID: <nycvar.YFH.7.76.1810091041030.14430@cbobk.fhfr.pm>
References: <20181005184114.207503-1-dtor@chromium.org> <20181009062855.GA32033@dell>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2018, Lee Jones wrote:

> > This adds a "base attached" switch definition to the MKBP protocol that
> > is used by Whiskers driver to properly determine device state (clamshell
> > vs tablet mode).
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > ---
> > 
> > v2 changes: None
> > 
> > Lee, I was wondering if it would be OK for cros_ec_commands.h to be
> > merged through HID tree.
> 
> Yes, so long as it goes through in this merge-window.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks; both patches now queued in hid.git#for-4.20/google

-- 
Jiri Kosina
SUSE Labs

