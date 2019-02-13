Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6768C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A28222A1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550099189;
	bh=4LTTH5A4IodQjOSNPJgkav5b38ne+G7dE2QCvShryjw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ORHeJzL+ILgU5pwtODBBuaKDtnayM36fH3qt5yS2W9Wjefq0ifuRBVMK9DpIKSpZc
	 SWvFHdxY+M1fixu6hnvOyFHwEtffvhM8LsTsWzeRj/pB0sq/wEsjpZKnyIZoJ7RwFo
	 MPnr56y/s7K4KWdNd4q+iz5pb8A4AdH+m0VD/gxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394835AbfBMXG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405648AbfBMXGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:06:23 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F5A222A1;
        Wed, 13 Feb 2019 23:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550099183;
        bh=4LTTH5A4IodQjOSNPJgkav5b38ne+G7dE2QCvShryjw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sZlUXaW/kZo5Kzgssf2uELq2ijNjgR/3muSZjb3WYN9n73igRzsEkyLOOuqVh8uXc
         2x/VaeaJEFMcn6OybVUaNU4KSZcn1PYs3jkW6PWyavdbJXtxFOOBg24c36RNtNy/IV
         fxIg9Biupa49goAF/OpEjWwjOu3JOexuXCHTZvb0=
Date:   Thu, 14 Feb 2019 00:06:20 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Mikael_Wikstr=F6m?= <leakim.wikstrom@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and
 buttons
In-Reply-To: <20190209180526.7564-1-leakim.wikstrom@gmail.com>
Message-ID: <nycvar.YFH.7.76.1902140006090.11598@cbobk.fhfr.pm>
References: <20190209180526.7564-1-leakim.wikstrom@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2019, leakim.wikstrom@gmail.com wrote:

> From: Mikael Wikström <leakim.wikstrom@gmail.com>
> 
> Add support for the trackpoint and three mouse buttons on the type cover
> of the Lenovo X1 Tablet Gen3.
> 
> This is the same as with the 2nd generation Lenovo X1 Tablet.
> 
> Signed-off-by: Mikael Wikström <leakim.wikstrom@gmail.com>

Applied, thanks Mikael.

-- 
Jiri Kosina
SUSE Labs

