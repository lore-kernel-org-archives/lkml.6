Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98582C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E97320870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E97320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJKGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:48:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59561 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:48:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gANpU-0003ya-UR; Wed, 10 Oct 2018 17:23:48 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gANpF-0006h9-H0; Wed, 10 Oct 2018 17:23:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1539202053.12644.8.camel@HansenPartnership.com>
Date:   Wed, 10 Oct 2018 18:23:24 -0500
In-Reply-To: <1539202053.12644.8.camel@HansenPartnership.com> (James
        Bottomley's message of "Wed, 10 Oct 2018 13:07:33 -0700")
Message-ID: <87efcxtmhf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gANpF-0006h9-H0;;;mid=<87efcxtmhf.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/6qA/LX4yBPgvHTgUQIdzoAuDJCWX9Vw=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] code of conduct fixes
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> Resend to show accumulated tags and also to add a third patch listing
> the TAB as the reporting point as a few people seem to want.  If it
> gets the same level of support, I'll send it in with the other two.


There is also:

> Our Responsibilities
> ====================
> 
> Maintainers are responsible for clarifying the standards of acceptable behavior
> and are expected to take appropriate and fair corrective action in response to
> any instances of unacceptable behavior.
> 
> Maintainers have the right and responsibility to remove, edit, or reject
> comments, commits, code, wiki edits, issues, and other contributions that are
> not aligned to this Code of Conduct, or to ban temporarily or permanently any
> contributor for other behaviors that they deem inappropriate, threatening,
> offensive, or harmful.

Which is very problematic.
a) In append only logs like git we can not edit history.
   Making it a mainters responsibility to edit the history, to do the
   impossible is a problem.

b) There are no responsibilities of for people who are not Maintainers.
   That is another problem.

c) The entire tone of the reponsibilities section is out of line with a
   community where there are no enforcement powers only the power to
   accept or not accept a patch.  Only the power to persuade not to
   enforce.

Overall in the discussions I have heard people talking about persuading,
educating, and not feeding trolls.   Nowhere have I heard people talking
about policing the community which I understand that responsiblity
section to be talking about.

Increasingly I am getting the feeling that this document does not the
linux development community.  Perhaps a revert and trying to come up
with better language from scratch would be better.

I don't know how to rephrase that reponsibility section but if we don't
go with the revert something looks like it need sot be done there.

Eric








