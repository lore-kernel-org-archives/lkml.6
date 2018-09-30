Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAEFC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01254206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 18:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=redchan.it header.i=@redchan.it header.b="hWRe4hNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01254206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=redchan.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeJABOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 21:14:03 -0400
Received: from cock.li ([185.100.85.212]:53896 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeJABOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 21:14:03 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redchan.it; s=mail;
        t=1538332793; bh=ev4ZchU/AR3bUFqrambRt2HKZ1IAKKEyiWaI1xiVbjw=;
        h=Date:From:To:Subject:From;
        b=hWRe4hNzT4RXxPS1OsyaxlWtjFWScIiIx/VvzlFJj9DKRBF2LwJyTUQzkL2DCEG7R
         Wt6V4LkO2eHZ2sVA7x+y0Oc1KGuUKdq6mrWY2LY9UTnSdx59sxRMvLjEv0lu4DpHoX
         /nWiJBOWggmNDyt2N3GJAxE6na6W9aKfhOmvn5GdEjFoCB6P350cgz0OOWHw5qtEKi
         OQtlF9fufHx/7AUQ8U1OQktfqNGTi5KT8NxiHE+/PU7o4AngaxvKALEolR1y/2/r1N
         cNj2RRljsSg2a09mKtAME/kO+gkXUs2k2ztnh9JU7OD+rlZOMKJ80Kx2jnDX1LJpoI
         oIh1m5sqBC62Q==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 30 Sep 2018 18:39:53 +0000
From:   freedomfromruin@redchan.it
To:     linux-kernel@vger.kernel.org
Subject: Licenses and revocability, in a paragraph or less. (for the lay-man)
Message-ID: <473dcf0918da3b4beaaa1fd0576c06ba@redchan.it>
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



