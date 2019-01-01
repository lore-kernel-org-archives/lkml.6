Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA34C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 22:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C662073F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 22:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="X35Ebzdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfAAW6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 17:58:49 -0500
Received: from cock.li ([185.100.85.212]:60580 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfAAW6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 17:58:48 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546383525; bh=AD67aiBtsTVjwMYx6SUUzB3+rSIEFenajn6FRBpyP40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X35EbzdlJdeCOosD+DD3c52x8vc53xjbXJBkwlMh5w92qIzUWkzf0ZrHEQmyQaWvO
         hhctVsOa/A1jYHuw7DM48P0tVlBC0rapkrXfWm8yF4zjWB75G+aaCoQq16X/owwRfD
         X7AX8zsUpOVi5ttQE+OIeU23X+yitzmGU5zou/FiV6D0wwydmBunbzaVOHr2zsN5ug
         w0koBNPX84KFsRF9xejAu2il4mttATKJBfoQlcFw6QSHLpJ1A9+NrtqBkjE8huX2CK
         BhcbMsFfOjzCUFGWP9TZbhJswpnxnBMW4gDvtDqTewOEHEGGdKRTqpDPNlRMlSM004
         faTv9K4lQGBJw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jan 2019 22:58:44 +0000
From:   vsnsdualce@memeware.net
To:     william@techservsys.com,
        "Ubuntu user technical support, not for general discussions" 
        <ubuntu-users@lists.ubuntu.com>
Cc:     misc@openbsd.org, gentoo-user@lists.gentoo.org,
        linux-kernel@vger.kernel.org
Subject: Yes you can rescind. Re: CoC loving Linux programmers swear the GPLv2
 is irrevocable. They are wrong. (As are the women they wish to empower).
In-Reply-To: <q0fn2v$q4j$1@blaine.gmane.org>
References: <a6f3c4d6d8c85f1db2e84682b8305339@memeware.net>
 <q0fn2v$q4j$1@blaine.gmane.org>
Message-ID: <3dda689113beda562b11ea84ce9ebbf2@memeware.net>
X-Sender: vsnsdualce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you lend (license) your lawnmower to BrucePerens, and receive nothing 
in return, and BrucePerens hires someone else to draw a star on your 
lawnmower, BrucePerens believes he can keep your lawnmower forever 
because he "relied" on your lease and , even though he paid you nothing 
and you never said you would not rescind the license (a default right of 
yours, you being the property owner).


On 2019-01-01 12:42, william drescher wrote:
> "Consideration" can be in form of "
> detrimental reliance." That means that you relied on the license and
> that reliance cost you something.
> 
> So if you spend money to pay programmers or if you spend time writing
> programs based on the license you have paid for the license.
