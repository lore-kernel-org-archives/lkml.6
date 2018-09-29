Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E5AC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025662084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aaathats3as.com header.i=@aaathats3as.com header.b="b1TIwP1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025662084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aaathats3as.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeI2Lhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 07:37:37 -0400
Received: from cock.li ([185.100.85.212]:58504 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeI2Lhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 07:37:37 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaathats3as.com;
        s=mail; t=1538197836;
        bh=ev4ZchU/AR3bUFqrambRt2HKZ1IAKKEyiWaI1xiVbjw=;
        h=Date:From:To:Subject:From;
        b=b1TIwP1DID7F//sP54KXwngEpZuxqtY41Ke7lw/yWeUpi96O0f5TCVb3m5NmKNaVl
         l0u/uiTCc7WckdhQ2jqd0BG0/lTXZMhD/ppgxCLOBuQf1aNztQt8CnpW3gRu8jzwhu
         rNsuwiVRLyvKh8wYnNZs/skVLt3smlI1d5AbhxoxvuFjtkYVCTs/DPwux8doFJU87G
         nSFdOtyvyeIJTtQmHnfVXMAEjoFrr4aAbA/3YAlLkWO2dXvFHNLm8vQfmW+lsySvPk
         tPxpqDLQ6Vt31cN6yU65FJ31OgusdvhT7rzGEm/HQxUhFLmam5L7qvYHExe3IQaKue
         CgUNBd+0F6UgQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Sep 2018 05:10:36 +0000
From:   freedomfromruin@aaathats3as.com
To:     linux-kernel@vger.kernel.org
Subject: Reminder: Licenses and revocability, in a paragraph or less. GPL 2 is
 revocable at the will of the grantor.
Message-ID: <1190d46845695d112198d9ed5a3ad67c@aaathats3as.com>
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


