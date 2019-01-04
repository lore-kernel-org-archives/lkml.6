Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752B621871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=memeware.net header.i=@memeware.net header.b="rLhvIO13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfADH1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:27:34 -0500
Received: from cock.li ([185.100.85.212]:56172 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADH1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:27:33 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
        t=1546586850; bh=7svErTjufuXV3PTgY58BBq6WGRUJ6bU2luEJO8bARAI=;
        h=Date:From:To:Cc:Subject:From;
        b=rLhvIO13GdSSdfTftbR4hZjsbqDWLEhpBTcNPNnXJTWtDWHi7d/baOQ4hNOvL0uPR
         KDJ118CnbA+G7SxNtAzYd0irvzCWB2SJjq9UMByYE9ibh2iZvUaiG4ywM+rCCTZmYK
         01kZsTTcWLhHCN17J37WC6QIA24PaJTQJxbsDagbJJ2Ylow+pBj6af4WnOeK/1Zbje
         Q51VZSAYSFcqafB46cboHCP07PVUEXT5h3LObvdkz7CVL3lWeYNZLEyEMcatS68zfL
         EiLSEy2ZFEtbMQyLNTQI0HiAymGgkc1q/pmFcgfrofO3IpafAX42yZPhWIfYJspaAh
         1qW1AT5lZpbVw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jan 2019 07:27:29 +0000
From:   vnsndalce@memeware.net
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        misc@openbsd.org
Cc:     esr@thyrsus.com, moglen@columbia.edu, rms@gnu.org
Subject: "If the contract is non-revocable only when there is consideration is
 paid, then it would be impossible for the GPL to exist."
Message-ID: <c75f9476bbe31c1efa0995b0c41c325a@memeware.net>
X-Sender: vnsndalce@memeware.net
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have a contract to distribute software complete with 
> non-revocable interest, then there is absolutely no need for an extra 
> license on top
> of that to distribute the software. The contract would define the terms 
> of distribution and the software license would be meaningless to define 
> >the exact same terms as the contract. If the contract is non-revocable only when there is consideration is paid, then it would be impossible for
> the GPL to exist. The GPL exists to convey licenses to licensees who 
> may not have any direct connection to the grantor. If the GPL is only 
> valid
> between grantor and the direct licensee who has paid, then how is it 
> possible for any licensee to get the license to distribute the GPL 
> software >
> without directly contracting with the grantor?

Exactly.

Exactly.

Do you understand why the edifice the FSF built and which linus spurned, 
mocked, and ignored is essential now?

The FSF's plan for free-software was for contributors to assign their 
copyrights to the FSF, which is a 501(c)3 org (a non-profit, a charity). 
Then for it to distribute the software under the GPL(1 and later 2) to 
the rest of the people (for a fee ofcourse (see early emacs)). Promises 
to give a gift to a charity are generally irrevocable ( you learn this 
in law school, it is an exception to the general rule that promises are 
revocable absent consideration).

Then linus' way of doing things spread like wildfire, and now everyone 
was distributing code under the license, not require copyright 
assignment, and not being a (perhaps) charity for extra protection.

The FSF was careful in creating its citadel, with multiple levels of 
legal theory to protect the code from it's progenitors' whims, under the 
laws of the USA.

And linus said fuck that and fuck you RMS: you don't know what you're 
doing.

So they had to ret-conn the GPLv2 as a license for the masses.

And the rest is history.




> If the contract is non-revocable only when there is consideration is 
> paid, then it would be impossible for the GPL to exist.

And the nail is struck.
