Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47720841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="BhrTZc2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A47720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeJKIDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:03:42 -0400
Received: from cock.li ([185.100.85.212]:35764 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeJKIDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:03:41 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1539218338; bh=+gxLaUHCdql05tMc9SHU044gDCWQfdTo3n4IMCnct9c=;
        h=Date:From:To:Cc:Subject:From;
        b=BhrTZc2vIYOaSGst+0udYV8UaGXqklYM0LulmPkG4r5WhCwM5yTkneaOYcvBJwet/
         BrmzVYAIbFM8xYwuZbPx1DMivi/mGOE2qKDe9O1GDs8HhzVDzY7EmzZlBgfS6nlo9t
         nD9LBazUWAca69VtdaljYefMAFhWelzf7EnaYz4JCvk4A5GxfLPAchXn2mw+pz8jKe
         +AAj7IhFJXeXVbrMw1QeZlwnFfd0TKhTokM1SqlbumgTPGnqGEbEjCUOXayyjBHWGy
         dkTo3YlDiusXdaSw0kwMJLBRKtnay7O7B4aWVSGdWxwpFM18UVqGliZ+7zvG+WWGlI
         XjqQRyeIUAcHA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Oct 2018 00:38:58 +0000
From:   missingterms@redchan.it
To:     linux-kernel@vger.kernel.org
Cc:     rms@gnu.org, bruce@perens.com, esr@thyrsus.com,
        moglen@columbia.edu, bkuhn@sfconservancy.org, editor@lwn.net,
        torvalds@osdl.org
Subject: Three avenues to rescind GPLv2 property. RAP strategy added.
Message-ID: <8bae6240e13b8cf7f75de9e8ffd18e19@redchan.it>
X-Sender: missingterms@redchan.it
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a case in NY where a Software distributor agreement violated New 
York's Rule Against Perpetuities
McAllister Software Systems, Inc. v. Henry Schein, Inc., No. 06-0093, 
2008 WL 922328 (E.D. Mo. April 2, 2008)

So we see that atleast one court in an important* jurisdiction is 
applying the RAP with regards to intellectual property.

So:
Attack 1: license rescission under property law (non-exclusive gratuity 
for which no consideration was given, and no utterances to 
irrevokability by grantor vis-a-vis licensee uttered, thus can be 
rescinded at will).
Attack 2: license rescission citing no term-of-years, thus at-will 
licensing (until the parties no-longer agree). (This one works in the 
UK)

Jurisdictional attack: if defendant claims license is perpetual [Or you 
could simply use it as an alternative argument from the get-go]
Attack 2b: license is a nullity (void from it's inception) due to RAP.

*(Wallstreet is in NY. I wonder if they use and/or modify linux kernel 
for anything?)

