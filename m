Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF13C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9DF2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="IDucfTZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfAWN1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:27:25 -0500
Received: from cock.li ([185.100.85.212]:38462 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfAWN1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:27:25 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1548250042; bh=uIK2tzQR1MFgvzgXoPSppWWCEcJlPTtA0iwMBLxR6B4=;
        h=Date:From:To:Subject:From;
        b=IDucfTZ2hTtKLb+hmv37ujfFlbyFa8D0Z/LW7u5/+fsvRMTDXdMsx9nV5WHnm8n5M
         1F9M4N+CV3IcVMmR/KK5KDbHqXAqKzH/4EhX9gtEP81Hcm/HVo6EHttmQnI2ogHPzZ
         wHEiqB+wiHNMc157z3NUZnQqAH+zcyelPWvl4XTS/XqavZvBWS7HKzELVK+VluM3de
         ZrTonYyMyHYomeCirx632EA9bCqPR1Z/oY1P2MFyD4yqXAzbYbY1W3uuGawLmQAUmM
         +esEElF+2/rCicq99+p1X/aD+4hziMjQU9WBhw68A0OGOUX6yJPEo9yTN9QRwecPRm
         21pBEkEf2DOTA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 13:27:21 +0000
From:   linuxgpletc@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: GRSecurity Kernel Patch?
Message-ID: <ba9cabc89e114d0b302fc1d22168e12a@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any news on this.
Are they ever going to release another open version?
Why do they get to violate the GPL by adding an additional restrictive 
term (ex: we will punish you if you redistribute the source), when their 
patch is a non-separable derivative work of the kernel?

