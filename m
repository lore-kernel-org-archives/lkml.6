Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7060C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AA42089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="YKDjx5yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA42089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeJAKnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 06:43:31 -0400
Received: from cock.li ([185.100.85.212]:43106 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeJAKnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 06:43:31 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538366864; bh=ev4ZchU/AR3bUFqrambRt2HKZ1IAKKEyiWaI1xiVbjw=;
        h=Date:From:To:Subject:From;
        b=YKDjx5ydEz8leRikPRcvrjrxW6vqcWNU/OKPIzDnole43DjI0dPJP367HKhjegv81
         zgOzFYwkYHyc3dvfpBRF6JLlBBtIzIlTjVMRuPQ2+cdDHd4bcJ/ICBaKqgzorzwf+2
         l3XK/O2yrYwFdD0IR13WTcTl2k+wrAF52fVeWNui+fkEtcYDY+OP9R87CE5bRWcm9c
         IwhZY1p12ncKz+9DwZbYOQbdrMzTO8soMXQGX70XEqSRevW5HC+l7FRoIZ8SuWmF+E
         OJH4YmovHL8kf7Uw76c9dbpTF6+27aFPvKnmTNnTxJwOGgd0kF88nMNOxdYOw28Bt4
         m/RRL96BtGcYw==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Oct 2018 04:07:44 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Licenses and revocability, in a paragraph or less. (for the lay-man)
Message-ID: <a4351a6c82aea9d80a9e87565493d532@redchan.it>
X-Sender: freedomfromruin@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As has been stated in easily accessible terms elsewhere:
"Most courts hold that simple, non-exclusive licenses with unspecified 
durations that are silent on revocability are revocable at will. This 
means that the licensor may terminate the license at any time, with or 
without cause." +

Version 2 of the GPL specifies no duration, nor does it declare that it 
is non-revocable by the grantor.

(Also note: A perpetual license may violate the rule against 
perpetuities in various jurisdictions where it is applied not only to 
real property but additionally to personal property (and the like), 
which is why the GPL-3's term of duration is set as the duration of 
copyright on the program (and not "forever"))

+[https://www.sidley.com/en/insights/newsupdates/2013/02/the-terms-revocable-and-irrevocable-in-license-agreements-tips-and-pitfalls]



