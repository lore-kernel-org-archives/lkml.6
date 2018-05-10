Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2746254-1525985296-2-4735621819825795332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525985295; b=V/J9z1GRitSBcS6TKcy6MiGiHyoCTML7OAbhKzaBJx9ZSh4aHv
    7GUfFXptTIMiEznIgiBxcRpM7J9Ljvu5dgCtlGiq9RdQmhbjMap6Zbvm3Yir5r55
    c6hMCPH40D2E/CO6FjR3w359ntYxdtD7gnwl8d8l/zZ+laXQIeRToBniBiKz/E7y
    DEldwucXgU00acsCbIRneC1Oa+67s4pmDJYXiGITRx7yctoXK2M8MnKBDdyiXcEA
    fFEgcFEGk3XUBJzyRjO+qlrCh0zCa3WUB1MZKNHuhdUt3OfFzg26xDy6QTmd/DBW
    aqsOLUoMlvLfCcsnQlEpGkIgST0g4+4Ezn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525985295; bh=7b0Th38pdpmyKfwIY50ZV4OVzt4X/9
    OKYQMH7aXfFjU=; b=c3Ux8HeHDL+Pvz0hNjGaTw4sIgPxI/+SIVphQLKixu7DFq
    ecSqq4T+ncJYxXSuBGNVxVS18HmnkuIz0Y6r6kXCMmMLOkiYwCY+gj8jOLavqzBV
    M1GEjM4titMwUgdJLFg/nXKj2fSfxz6O2VzQqW0U9Qm2qPVC2TMRHwNXTLbcJnwS
    h+hJ2TscBWcOwux+nGQn54cu2RsZxPv2a8ej7lZNfMb8aDI8IJ0Z1szXqE/MvrJ2
    cDy0nh/sa+bNe9copsU60Pl9YMbRV2YbUe3ItrH6+2RIFcdW+jZk/tBHCrHY5zvv
    KsqPCHPVL3wiLHSlA5BW4/eaCqXDcLHW3+q8BO9g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
    header.result=warn header_org.domain=linux.org.uk
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zeniv.linux.org.uk header.mx.error=NOERROR
      header.result=warn header_org.domain=linux.org.uk
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIodicg+NiH066npPIJdE26kfy8NA/Trx6iksZ0Ynw2mGUnGm4BN3sAOLEEa8Aw6UNgmOjMxC+7c36jbzDjmqbnFzsUg47d7Fi4pFKopcoDo495+cE0t
    Mz6spYphFxLxLl5beSqiI/IzSZPZLgUFy83qG3n9S0D6aRWDkVSYzr0+CLCUNyng8Qr7GEKoElkzrSasnNhMlh+3ykhdzZtfx8uN3WuS4A7hRI6yByj+wUA5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Gy2oqKvDCts8vtp6em4A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbeEJUsO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 16:48:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56996 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeEJUsN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 May 2018 16:48:13 -0400
Date: Thu, 10 May 2018 21:48:07 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sandeen@sandeen.net, darrick.wong@oracle.com, dhowells@redhat.com,
        tytso@mit.edu, fliu@suse.com, jack@suse.cz, jeffm@suse.com,
        nborisov@suse.com, jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] vfs: skip extra attributes check on removal for symlinks
Message-ID: <20180510204807.GV30522@ZenIV.linux.org.uk>
References: <20180426234639.12480-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426234639.12480-1-mcgrof@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 04:46:39PM -0700, Luis R. Rodriguez wrote:

> Since we cannot set these attributes we should special-case the
> immutable/append on delete for symlinks, this would be consistent with
> what we *do* allow on Linux for all filesystems.

Er...  So why not simply sanity-check it in places that set it on
inodes?  If anything, I would suggest
	* converting all places that set those in ->i_flags to
inode_set_flags()
	* making inode_set_flags() check and return an error on
that...
