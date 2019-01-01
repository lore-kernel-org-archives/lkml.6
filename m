Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804DEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E025208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 23:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="X9O8Ajyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfAAXax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 18:30:53 -0500
Received: from cock.li ([185.100.85.212]:40262 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfAAXaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 18:30:52 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546385449; bh=UZgANCC8MweJpFGYGS6rOD6ns8jGxBKcW/9izaK4Ueg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X9O8Ajyo6PY2GVi7nwdtZMaHDK3W9Oen5YNiFDhL1kCPZZiLSNdv0o9nTKj3GmTms
         4ICXSldDdmHo5gvnmTcpzmVZgTB3xAldQcUZn9mFNfKz/snO0a3oh66i+AFG7Rsl4q
         fRqcZEha1Hp2GA/fiaZBK2v9T5dL4MkJVTsvi2Baxf0fPB7+WVPSTwB4r5qgwWucet
         6tR0TrzwOk4fGTqQLdmv8vWMvRdvDpFK0F8Kq7Xgho7fzZ0Y6ptEbHLRGLU7sY+kEl
         h5N5K5sF5mmx0mGilWf3IGECnoTfuPfe1HUfrPnnDEPE7vH+CKc1OG34Nij/EtAGpL
         CAN1cia5xwdgA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jan 2019 23:30:48 +0000
From:   vsnsdualce@memeware.net
To:     linux-kernel@vger.kernel.org, misc@openbsd.org,
        gentoo-user@lists.gentoo.org
Cc:     debian-user@lists.debian.org, ci-users@centos.org,
        centos@centos.org
Subject: Re: Thank you for your messages, and Happy New Year ;)
In-Reply-To: <CAAaskFBmER_jHyiXyH=yM-0fObGy0LGgo9OfQOmwZ-psaimS+w@mail.gmail.com>
References: <CAAaskFBmER_jHyiXyH=yM-0fObGy0LGgo9OfQOmwZ-psaimS+w@mail.gmail.com>
Message-ID: <b8e7b7bdaada30dfd719c7938ed5dc15@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response :).

Please Spread the word regarding the copyright-holders rights (remeber: 
the
Linux kernel programmers did not sign over their copyrights, one of the
reasons Linux grew so quickly amongst developers where GNU very slowly
(The FSF will only include code where the copyright has been transferred
to it)), thus the various 1000s of linux programmers who didn't work
for a company all retain their property rights.

A license is just that: license (permission). It is not a transfer of
rights. These licenses that were given are non-exclusive (not to just
one entity) and are thus cannot be construed as transfers either.

It's simply permission to use property, same as if you allowed a 
neighbor
to use an ax you owned (gave them license to use the ax).

If that neighbor went and then chopped an enemy to pieces with that ax,
limb by limb, joint by joint, applying burning cauterizing oil after 
each dismemberment,
he cannot say "I will not give you back the ax, because I relied on
your lease, and thus used the ax in such a way as it would be 
inconvenient
for me to return it to you".

The ax is still yours and you may tell your friend: give me my ax back 
now
(this is you rescinding the license).
