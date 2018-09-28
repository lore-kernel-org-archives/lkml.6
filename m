Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0992216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aaathats3as.com header.i=@aaathats3as.com header.b="HMwdQW6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0992216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aaathats3as.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeI1Jv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:51:59 -0400
Received: from cock.li ([185.100.85.212]:56378 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeI1Jv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:51:59 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaathats3as.com;
        s=mail; t=1538105422;
        bh=ev4ZchU/AR3bUFqrambRt2HKZ1IAKKEyiWaI1xiVbjw=;
        h=Date:From:To:Subject:From;
        b=HMwdQW6HsmJuqfAPU2VlR4xrQEk77POibW9NVeE7O4DgNbakUn/iEu4RKKr7k6uRk
         EP++atUSv/Fg88W6oCVCkFrlWu5JnA5/BbLNcD+oJ1boJufDKPxINEho6oXaSA5MK8
         JJh2Hfx6CsiifwNlime7WmZNUVcBrr0kPouteLBIWZ7HA+lcX4E9HyBtWUgkQOF+Ho
         d7T5JHx3MwrP8ktyLGUSQ8hDbtOs5xGgZqysRNkW8T5g1WAsSrYzsCi6x8wtYdOOR4
         oo83G+H5qPr7O7w/DF7Luq16JbhLvTGebGBhmD/GhHM6Ai1/qL1t+kmZofnerEEudM
         5Mche3eSCQ6uQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Sep 2018 03:30:22 +0000
From:   freedomfromruin@aaathats3as.com
To:     linux-kernel@vger.kernel.org
Subject: Licenses and revocability, in a paragraph or less.
Message-ID: <6ed65e31150937cad0733374eb8a9ef4@aaathats3as.com>
X-Sender: freedomfromruin@aaathats3as.com
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


