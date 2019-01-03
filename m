Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EACC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560622070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="Of8uXJQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfACF2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 00:28:14 -0500
Received: from cock.li ([185.100.85.212]:57620 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfACF2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 00:28:14 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546493291; bh=UTjq/lclmVwzMpHSk7g+kPP4uISK+8hcIxy78mguBBA=;
        h=Date:From:To:Cc:Subject:From;
        b=Of8uXJQyOp4HYFgGCSUpV9CzfO69QyNxv709jz0Bh25JBc70sJbKmFDzxMF8LTGpJ
         Bw2bABXJn2jHXw+PL8wA+8MwAMZWTt7DJQ1j8JdUAP0WwFSAxYWf1YGWlNpvo5sFsk
         XSnQYr3dxzwLajOr1ywDyXN0iWiLinz7oTueCzmMcrEciuYLkekw5dKZlzxfBffLWg
         6n/LQOx2VpydJs+hB4w5MrAqsiRFN66E5JdbU/znmP5fXHpY9vrJUGZRx1sOO4BhKG
         VfuxzTTQtW3seE9szyx2TRJXP47DY4G6BPO10sP8GXXperMwQSXTzQ10aY1y6vhdjG
         WiWbic49ikKKw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Jan 2019 05:28:09 +0000
From:   vsnsdualce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        ubuntu-users@lists.ubuntu.com, debian-user@lists.debian.org
Cc:     freebsd-women@freebsd.org, freebsd-chat@freebsd.org,
        misc@openbsd.org, debian-user@lists.debian.org
Subject: (as you know) The FSF require contributors to their projects to
 assign ownership of the works to them...
Message-ID: <bc331d7b0e7dc5ff6a82759a1da02d50@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A license without an attached interest is revocable by the owner of the 
property.

The FSF require contributors to their projects to assign ownership of 
the works to them: For the FSF the license is not enough.

Put two and two together.
