Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3708595-1526244728-2-3336825386939112299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526244727; b=NbtbVPViQvhvDyXKGMUSk8/4FDJ+LmcK0zgzIqNeG5PjmcaKUh
    PdHnQ9xnXdixs2mF1pFJfpGl/iSVdtBiz5qbeuu0REcXKeja+OZZtEQsi95rLFon
    bJmibxtgrdwsmFsFsT+iLCZqC+fMGiKL0+9AJfTc/rTAKrJOfvptC6kGyDeNyj4c
    J/4AtHjp8OcO3DcEPF/aZJjWiEt6xhFcEMpjmpNpSWLTJI+HVk1zDD79eKOqjgwi
    RqyaShcBWaLi4QEviD5uTZ9ntQ8k7DMe+ol0aool8/sn5bFbtnWvwR2caZ9MGPCG
    exKSGAvQYadK/VfOzDn4gCo8QQrpQcjPnPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526244727; bh=h2PGfJ2BL1QqPbazo1vgoGQUAs/Jyt
    Fvwyma91CcSo0=; b=C+MI3QZ6Qp/Bz6PtJdqY+jrXlO4ewEwEel+A/vf4CcEacz
    yRFSvKYrHYaAzp1rX8Mw5qID/g9r8Amb88mbEsGUPgEPOuAADOX9aVp+PYmwC6zQ
    YyAPAk6PIFnSsDVvz7ZhJ62UU6VfuFyQyGNWKMTmqxzyKCgkYGMguNBKCVV17/at
    buauDJA9ILrmm2uiH4l6v8ZjydHtvTpvmFsk9hG99og5T9wwjr0ucoVJrUkpEwk2
    9dEHSWgnKFWIjrrpDmJ7J9bAca7f4F6PMvhJMAPjemmJYTdNHejNV6vLHaw55b8c
    k6Fm/4WGIuq8/47gTB3+/gJnEcpBvhzmBkm7YPgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=aGHaHMyj x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=aGHaHMyj x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOPwFGAXIw1ivccsUUjT8MawjRhAju3TcZHxaLFXcoH6giCJKSN51hShfRk7y3fLRv+568i9cVVHE5yv+JMFOM5HPcTLeVQXaqpRjMImfmuz6y1avNd2
    6VCq13DRPRybdla3QaqiNC3h29h+gV0fzHlAictIFhj/++zjiC1jS2Nx4BAJRPsb+Hw8N1jNj2C0PpbZQPupaxFLb3whJA6tsnxpY1YG6BsE3j2mygWZTUnm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=-qtDWbW2J8xMYbQJMGAA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeEMUvs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 16:51:48 -0400
Received: from imap.thunk.org ([74.207.234.97]:46904 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbeEMUvr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 13 May 2018 16:51:47 -0400
Date: Sun, 13 May 2018 16:51:32 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, adilger.kernel@dilger.ca, clm@fb.com,
        jbacik@fb.com, dsterba@suse.com, sandeen@sandeen.net,
        dhowells@redhat.com, fliu@suse.com, jeffm@suse.com,
        nborisov@suse.com, jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/4] ext4: add verifier check for symlink with
 append/immutable flags
Message-ID: <20180513205132.GG14763@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com, sandeen@sandeen.net, dhowells@redhat.com,
        fliu@suse.com, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180510231359.16899-1-mcgrof@kernel.org>
 <20180510231359.16899-4-mcgrof@kernel.org>
 <20180511211218.rs365ftuw53c4qj2@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511211218.rs365ftuw53c4qj2@quack2.suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 11:12:18PM +0200, Jan Kara wrote:
> On Thu 10-05-18 16:13:58, Luis R. Rodriguez wrote:
> > The Linux VFS does not allow a way to set append/immuttable
> > attributes to symlinks, this is just not possible. If this is
> > detected inform the user as the filesystem must be corrupted.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied into the ext4 tree after verifying that e2fsck already handles
this case:

% e2fsck -fy /tmp/foo.img
e2fsck 1.44.1 (24-Mar-2018)
Pass 1: Checking inodes, blocks, and sizes
Special (device/socket/fifo/symlink) file (inode 13) has immutable
or append-only flag set.  Clear? yes

(The btrfs and xfs maintainers might want to make a similar check
before accepting their respective patches.)

						- Ted
