Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E98C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F40E2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="0VumMRY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfBDRGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:06:05 -0500
Received: from cock.li ([185.100.85.212]:36054 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfBDRGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:06:05 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1549299960; bh=WMlAuLwuU/fI8wa0oIIFDdXtWo+NGTcpOLtBNsVayHA=;
        h=Date:From:To:Cc:Subject:From;
        b=0VumMRY2m8DJlwrAOK6HCXV0HOcu+OZSV+GRM6ldyEAcKnQvTteUQIxyAyUD0sH9N
         BY5NPNSk34WieIAjuJYDPxPu+bZYwP/YiNc/MQ16flTNYkPd2HlOFq8tm3sJXdgEcL
         NdKO3stuLzDoZfb58PtCohMwNcJSKSLI3tz0G1oF1I3gUHaFImJDStKotgsurw6H1q
         Segg66FNbzg1gp9CmsrUqFrRpEQvM1f6c2hpSe/7krfUfexknKqPxyK1MDvA6b6Dym
         gudH8q8Yn/16HWGnndcE3rKH0C6rc2IWfBwKZrndhy1hCzPy+Xqw4nHbjzyamkpTGe
         P9o+dJzTKKWQg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Feb 2019 17:06:00 +0000
From:   linuxgpletc@redchan.it
To:     linux-kernel@vger.kernel.org, gentoo-user@lists.gentoo.org,
        misc@openbsd.org
Cc:     news@theregister.co.uk, editor@lulz.com, rms@gnu.org,
        moglen@columbia.edu, bkuhn@sfconservancy.org, esr@thyrsus.com,
        editor@lwn.net, torvalds@osdl.org, editor@lulz.com,
        blukashev@sempervictus.com, tcallawa@redhat.com,
        compliance@sfconservancy.org, freebsd-chat@freebsd.org
Subject: Successful DMCA take-down of GPL licensed work.
Message-ID: <22db25cb4875db8aa4dd43f54261b390@redchan.it>
X-Sender: linuxgpletc@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://gitlab.com/MikeeUSA/GPC-Slots-2/
Is gone after a successful DMCA take-down by the Author (MikeeUSA).

Backstory: Author (MikeeUSA) revokes license from "JohnDoe".
"JohnDoe" defies revocation and uploads the work to gitlab.
"JohnDoe" modifies work to "remove sexism".
MikeeUSA issues a DMCA take-down request to gitlab.

Gitlab understands that a license, absent an attached interest, is 
revocable.
"JohnDoe" did not pay MikeeUSA for a license, was a gratis license.
DMCA take-down is valid.

Yes, the GPL _IS_ revocable.

And _YES_ the gratis Linux Kernel programmers CAN revoke their code as 
counter-stab against the speech codes that women (and their support) are 
attempting to muzzle them with (The "CoC")

(Back story links: lkml.org/lkml/2019/2/1/843 ,  
lkml.org/lkml/2019/1/23/316 )

