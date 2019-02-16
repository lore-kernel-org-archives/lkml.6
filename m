Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7633FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E9D21B69
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550346314;
	bh=T7r+dY7Q2MIXgfayi+wkdjBS6gbD84XjdFJHtKxlEsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+biyUg4gTvaM9z4NjbgOCUbZDaRyRkdNgE74Wir3mT3acTtgUYHbny7kMD+7ZSHw
	 XiDDABmrqaKT8c6wdHVCmSdsb7InlFcGUjeGusGtn3YLUL5zVh1s/enbeAx74nT45m
	 XziITfVJk/vtvixe6o/2ww1EZ3pbEvEbaWSq9jdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfBPTpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbfBPTpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:45:11 -0500
Received: from localhost (19.64.7.109.rev.sfr.net [109.7.64.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A6A21A4C;
        Sat, 16 Feb 2019 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550346310;
        bh=T7r+dY7Q2MIXgfayi+wkdjBS6gbD84XjdFJHtKxlEsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnwowErUUTbWfAYKpeRIxktZJJYvUMTBndTif5dbh/KaHF9vFK6EQP9peDd9KGNOX
         idfuW1qbnsBC+Sdg0vu4+erTobMXseMMsdoufdDcwume3mC64JNVWgzbGzDEUhEe2y
         aJL4cJJY43Pqyj+e/32X7NLj3E5szpSTgARzVwyE=
Date:   Sat, 16 Feb 2019 20:45:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use the correct style for SPDX License Identifier in all
 header files across the kernel
Message-ID: <20190216194507.GA10104@kroah.com>
References: <20190216103356.GA10673@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216103356.GA10673@nishad>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 04:04:02PM +0530, Nishad Kamdar wrote:
>  816 files changed, 970 insertions(+), 970 deletions(-)

You have to break this up into subsystems at the very least, no one
person can take this patch, sorry.

greg k-h
