Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09217C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F2A23C20
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="d5sbtbz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F2A23C20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937059AbeF3NEj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:04:39 -0400
Received: from imap.thunk.org ([74.207.234.97]:43338 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936658AbeF3NEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2ts+f0bWGYevp8weMSEdRpGvO7jKBjC5Rcu07I6rXA0=; b=d5sbtbz8IzAeDAq75es0a7RM0O
        kDoDvh5yzSBVGyjaemvjBPESRJj+GaE471RcFaHhKXMoAUg4WWqdxV+hxFbj2//SPf3yf/14eYjvP
        1NF9zsaxYbCJB0wNDUghaw2Jm0weew/YspUCoPQh9J0O1BUVSQUFizEON7HK+d1LF6GI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fZFYE-0004aZ-9U; Sat, 30 Jun 2018 13:04:30 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F13DF7A447A; Sat, 30 Jun 2018 09:04:29 -0400 (EDT)
Date:   Sat, 30 Jun 2018 09:04:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IFtQQVRDSF0gZXh0NDogZTJmc3Byb2dzOiBmaXggaW5v?=
 =?utf-8?Q?de_bitma?= =?utf-8?Q?p?= num not integer,incompatible for ancient
 android devices
Message-ID: <20180630130429.GA26529@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Gaoming (ming, consumer BG)" <gaoming20@huawei.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liqingchao (sorp)" <sorp.liqingchao@huawei.com>,
        "Shenchen (harry)" <harry.shen@huawei.com>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        "yangfei (D)" <yangfei39@huawei.com>,
        "Renlipeng (OS driver)" <renlipeng@huawei.com>
References: <1530014046-62466-1-git-send-email-gaoming20@huawei.com>
 <20180627140937.GA3348@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41667@dggemm511-mbx.china.huawei.com>
 <20180628022900.GA663@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC416E8@dggemm511-mbx.china.huawei.com>
 <20180628153022.GA8521@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC4179B@dggemm511-mbx.china.huawei.com>
 <20180629142612.GE1231@thunk.org>
 <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FDC91B229D965C458E3615E98C48ADDD0EC41869@dggemm511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 01:26:43AM +0000, Gaoming (ming, consumer BG) wrote:
> Yes, it is caused by using 1024 blocksize.
> It is historical problem, and I have to admit that's not good idea.  I don't know why somebody choose it some years before. 
> It has been corrected two years before or more early. But some ancient devices exist. 
> It is not user data, no need to do file-based encryption. It is a small partition for some use.
> 
> However, 1024 is legal though not good, somebody may use it. 
> And we should fix it.

So you understand my position --- the reason why I've been pushing so
hard is I'm trying to figure out how big of a problem this is.
Specifically speaking, is this a Huawei-specific problem, or something
across the entire Android ecosystem.  I *thought* I had fixed most of
the disaster back in 2011.  There have periodic headaches where
testers would discover problems where android handsets get bricked
after doing a factory reset that I had tracked down to make_ext4fs,
and the existence of make_ext4fs is not something I agreed to, and
have been fighting for years.  So I've been cleaning up after
make_ext4fs for a while, even though it's not my responsiblity.  (For
one thing my work responsibilities are for data center servers at
Google, *not* Android; for another, no one asked *me* before they came
up with the abomination which is make_ext4fs.)

So I don't feel particularly, or personally, responsible for bugs
caused by make_ext4fs, because if it had been up to me, it would have
never existed in the first place.

If it's only in ancient Huawei devices, I don't see a strong reason to
support his in upstream e2fsprogs.  Are you really going to be
backporting the latest e2fsprogs into these ancient Huawei devices?
In my experience, the Android team has a hard enough time getting
their Android partners to backport kernel fixes for severe security
bugs into old Android devices --- never mind versions of e2fsprogs.

If not, what's the point?

Regards,

						- Ted
