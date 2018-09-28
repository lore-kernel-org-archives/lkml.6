Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F44C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E6D216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aaathats3as.com header.i=@aaathats3as.com header.b="GqgPKqWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E6D216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aaathats3as.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeI1Jva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:51:30 -0400
Received: from cock.li ([185.100.85.212]:56058 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeI1Jva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:51:30 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaathats3as.com;
        s=mail; t=1538105392;
        bh=3wUwRoRNZM7Ocma2Fep+cGIPhi+6OuHqGzW1erjI3yA=;
        h=Date:From:To:Subject:From;
        b=GqgPKqWHDuH7HqRh6UBxqNFnP+bH/caurTzqTuNf64Ojn0K7cOJjm1NE/WJGjBMei
         1DPG+JW5R5Qit16MO4vsqejEMkIR/4Cw7Q9rj6kXmNS0wUeE+KSNVi7mQSdBS0BXUp
         KyNZchyGY8eNz0nFFofMfB4BMUUxPkyziw7IuCbXW4KFA6JcHemRo0eRX/8pmBiXlj
         SJzrQcza2jgz/mJZ5gcjjJWp7oyKn5OUqCB/ax1EAgWIDTIZ801qWNBUe1s7ZlDFDv
         3x+wEnjoXzjAyhduyNcncFn/lbcQo+V0Vb80T1zfdnuyWGfaGO6t1TkffZoJtJ8yM0
         ptgBUbEASxXHA==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Sep 2018 03:29:52 +0000
From:   freedomfromruin@aaathats3as.com
To:     linux-kernel@vger.kernel.org
Subject: GPL v2 licensing, continued
Message-ID: <85862189a9314c9425585b5b671a0106@aaathats3as.com>
X-Sender: freedomfromruin@aaathats3as.com
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gnu GPL version 2, section 0:
"Each licensee is addressed as "you". "

The "you" is not referring to the licensor (copyright owner). It is 
referring to the licensees and then future 
sub-licensees/additional-licensees receiving the work from said previous 
licensee.

It is independently clear from the context of the clauses if you read 
them in full.

...and then section 0 comes around and makes it _explicit_ that "you" 
refers to the licensee. (if you had any doubt)

Additionally, you should know that the copyright owner is not bound by 
the gratuitous license he proffers to potential licensees regarding his 
property. The licensees are bound to his terms: he is the owner. They 
take at his benefaction.

<blockquote>
                     GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

   0. This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law:
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)  Each licensee is addressed as "you".
</blockquote>


