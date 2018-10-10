Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3281C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567E120870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567E120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJKHFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:05:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33674 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:05:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAO6D-0004q8-3g; Wed, 10 Oct 2018 23:41:05 +0000
Date:   Thu, 11 Oct 2018 00:41:05 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] code of conduct fixes
Message-ID: <20181010234104.GH32577@ZenIV.linux.org.uk>
References: <1539202053.12644.8.camel@HansenPartnership.com>
 <87efcxtmhf.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efcxtmhf.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 06:23:24PM -0500, Eric W. Biederman wrote:

> Which is very problematic.
> a) In append only logs like git we can not edit history.
>    Making it a mainters responsibility to edit the history, to do the
>    impossible is a problem.
> 
> b) There are no responsibilities of for people who are not Maintainers.
>    That is another problem.
> 
> c) The entire tone of the reponsibilities section is out of line with a
>    community where there are no enforcement powers only the power to
>    accept or not accept a patch.  Only the power to persuade not to
>    enforce.

  d) In effect, it either leaves the maillists exempt, or, if they are
     not as would seem to be the intent, dumps physically unsustainable
     load on somebody (davem, by default, for vger-based lists).
     And anyone who wants to claim that moderating l-k, l-scsi, fsdevel,
     etc., etc. is *not* physically unsustainable is welcome to try.
     Just make sure that your insurance covers the psychiatric care you
     are certain to need afterwards.

> Overall in the discussions I have heard people talking about persuading,
> educating, and not feeding trolls.   Nowhere have I heard people talking
> about policing the community which I understand that responsiblity
> section to be talking about.
> 
> Increasingly I am getting the feeling that this document does not the
> linux development community.

Quite.  Not the use of open maillists, not the amount of trees and the
depth of pull chains, not the size of community, not the cross-area work...

Frankly, it reminds me of "well, if everyone had only switched to one true
revision control system and used the one true integrated IDE with this nifty
set of plugins..." kind of proposals.  Good for you if it works for your
workflow, but forget about having everyone else switch to it.
