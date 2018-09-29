Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0462C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF7220779
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aaathats3as.com header.i=@aaathats3as.com header.b="i2FwedGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF7220779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aaathats3as.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeI2HW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 03:22:57 -0400
Received: from cock.li ([185.100.85.212]:46642 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbeI2HW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 03:22:57 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaathats3as.com;
        s=mail; t=1538182595;
        bh=ev4ZchU/AR3bUFqrambRt2HKZ1IAKKEyiWaI1xiVbjw=;
        h=Date:From:To:Subject:From;
        b=i2FwedGfyabWTdvT77qL0d4ipnRiqbd2afuFjvozr+UjxEKi7NEgm4/rBOCevIhib
         zr5gcXvXvXgz4u2N9ANns7CnVMlBZNgLAJjZimUPhltDuI/8ZIruWzd0znBO78gBt7
         t4D/DO8bYPWzIRcZ5YRDu6t0H17wQnm4j+3xpKIavQpDl3Nd7BxoBNjp2kVtxM73bS
         ZhW3NoM9cumr484WAIK7iN2+N2N3eqtSM3xLVIyDXWY/hkPWtfPd4Eqz9z0ncmFWtZ
         nrjh40/9dK+xFCPIbHl+A5eQwLggT4ruTA1ic6KV3moBfsHpcZJ03b+k4nzIbC7QWm
         n9I6w4pvHi42A==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Sep 2018 00:56:35 +0000
From:   freedomfromruin@aaathats3as.com
To:     linux-kernel@vger.kernel.org
Subject: Again: Licenses and revocability, in a paragraph or less. GPL 2 is
 revocable at the will of the grantor.
Message-ID: <3d67109ea68362d1f87b0bfbd37bc3df@aaathats3as.com>
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


