Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C796B2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550652015;
	bh=zLuNtyEUzgfVaAEa3vzsmDn8D0wLWyIl5sNCCATX8Dk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=TooP/5yjQxebpaN26KPYO4W5cGcySpIC4MJtkYSSyBkHY1R1Y6m0zow3dwitUfnKi
	 247vnbRyk7q/OnhF8amss5rDppqxr8IE5zs66D2payneiXcYdS666IZXm0bu12a0XI
	 yfZ5TkZXSuDpouJi1HMCRju6LRxFHaEmww6+6czc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfBTIkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:40:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBTIkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:40:14 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA5C20859;
        Wed, 20 Feb 2019 08:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550652013;
        bh=zLuNtyEUzgfVaAEa3vzsmDn8D0wLWyIl5sNCCATX8Dk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=z+u2TwO2xUczu5aa5Xi3T61QWIj73MZvSSuIp01WDJf6gOoYVaRpB01LcVvXMF9V1
         OvTmEgQQkCi+q3CiZWx1VKRuD2a1LCoGECnhY+yge5CwUMNz+pd8ky6MoTwExzd1o5
         15fRVC/bu4Eh/dRYZaTAsmDPD9QbAS6mjSBMjtfM=
Date:   Wed, 20 Feb 2019 09:40:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stefan Achatz <stefan_achatz@web.de>
cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] HID: roccat: Mark expected switch fall-through
In-Reply-To: <1550650517.5256.2.camel@web.de>
Message-ID: <nycvar.YFH.7.76.1902200939530.11598@cbobk.fhfr.pm>
References: <20190211215334.GA6216@embeddedor>  <nycvar.YFH.7.76.1902191415550.11598@cbobk.fhfr.pm> <1550650517.5256.2.camel@web.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019, Stefan Achatz wrote:

> I already confirmed this 7 months ago but as I see only in a reply to
> you.

I guess that fell in between cracks somewhere.

> Yes, this patch is correct.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

