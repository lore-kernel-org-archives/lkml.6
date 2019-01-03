Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8F020815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546511458;
	bh=DFVoNK2bQrUGsSD8CzVAxCT6WZOJgfcq32s0suI3ud4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=MgAGE0yRHLy5/miGv4iZqjtFzqe8regmBaCwnIXOpRUZuXHRg8WIbeQOv8foFzYeM
	 0m+19EwBMlkUTkvAQyRqvmfagPTwf0VXgPywHFnLC72kAO3REGhOr03wnA8vjZq9N6
	 VJKzV12oMppByejMFvf0ccs0s4MzOe1UouEr7lqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfACKaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:30:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:51712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfACKav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:30:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D086AE4A;
        Thu,  3 Jan 2019 10:30:50 +0000 (UTC)
Date:   Thu, 3 Jan 2019 11:30:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Aditya Pakki <pakki001@umn.edu>
cc:     kjlu@umn.edu, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: Add checks to fix of_led_classdev_register
In-Reply-To: <20181224213914.26453-1-pakki001@umn.edu>
Message-ID: <nycvar.YFH.7.76.1901031130430.14047@cbobk.fhfr.pm>
References: <20181224213914.26453-1-pakki001@umn.edu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018, Aditya Pakki wrote:

> In lenovo_probe_tpkbd(), the function of_led_classdev_register() could
> return an error value that is unchecked. The fix adds these checks.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

