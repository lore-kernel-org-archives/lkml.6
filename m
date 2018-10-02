Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1520878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="Yv3eDiAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF1520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firemail.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeJBMzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:55:53 -0400
Received: from cock.li ([185.100.85.212]:53518 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeJBMzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:55:53 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1538460858; bh=+TQqQf8pKWz3jS0Af2zsP2n38tL72aYLikLhdHQsGzM=;
        h=Date:From:To:Subject:From;
        b=Yv3eDiAQqiCIerR5u1LT2RyxCc4LSaxx0BHzWkOp0HBTsWPKCZ7vnNZ75gYUL8KUH
         flKBEitzu0OtOYxO+BzAzlmMwIWiIv9lVrcZnqFKL4haTkAdhb+Kn48bzBiiNZOg1F
         zy2Juvdxadqjw2GuE1f9DjkuMdBAljjUKQgh31j+3qItMJxhZQVoifmnWAWcNQTiaF
         Am7ClOIhZkY4nIHscdZKjhNV8HJvYeN7ufAQGAHquNJ1c8K3too04iN0oad6nGaBIe
         ldZHB3wHhosh0fn1jCEaHIGsi4PCYPVFfKLtdINPXVX9jEL02+grAlXloeAZj48gQJ
         8Iztn6+GEfiCg==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Oct 2018 06:14:18 +0000
From:   clarityabovecompulsion@firemail.cc
To:     linux-kernel@vger.kernel.org
Subject: On default rules, and license given.
Message-ID: <62cb727b231c4c9f257ed1656476d7d3@firemail.cc>
X-Sender: clarityabovecompulsion@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> by jd ( 1658 ) <`imipak' `at' `yahoo.com'> on Saturday September 29, 
> 2018 @02:38PM (#57395698) Homepage Journal
> The author has no right granted by the GPL to revoke the freedoms of 
> others. Indeed, the GPL is explicit. Nobody, not even the author, can 
> remove the freedom of another.



You're completely wrong. The rule is not "If the GPL doesn't grant the 
copyright holder this, he may not do it".
The rule is "The licensee only has the privileges bestowed upon him that 
the owner of the property has granted"

Do you understand that? No. Thought not.

Version 2 of the GPL bares no "irrevocability by grantor" clause, 
specifies no duration, and the "You" it speaks of (cited by the 
SFConservancy.org) is explicitly declared to be the licensee in section 
0 (not the copyright holder, as the SFConservancy tries to argue).

Here's some lay-mans reading for you:
Licenses and revocability, in a paragraph or less.

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

