Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D18DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061712073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061712073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeIDX5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:57:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbeIDX5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:57:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24AE2B12E;
        Tue,  4 Sep 2018 19:31:10 +0000 (UTC)
Date:   Tue, 4 Sep 2018 21:31:09 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] HID: multitouch: fix Elan panels with 2 input modes
 declaration
In-Reply-To: <20180904133115.5111-2-benjamin.tissoires@redhat.com>
Message-ID: <nycvar.YFH.7.76.1809042130260.15880@cbobk.fhfr.pm>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com> <20180904133115.5111-2-benjamin.tissoires@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Benjamin Tissoires wrote:

> When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
> the settings of the various features"), I wrongly removed a test
> that made sure we never try to set the second InputMode feature
> to something else than 0.
> 
> This broke badly some recent Elan panels that now forget to send the
> click button in some area of the touchpad.
> 
> Fixes 7f81c8db5489

Please make sure that the 'Fixes:' tag is always in proper format. There 
are tools depending on that :)

I'll fix that up manually.

Thanks!

-- 
Jiri Kosina
SUSE Labs

