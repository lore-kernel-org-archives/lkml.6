Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A97C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C420E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeLSTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:30:13 -0500
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:59742 "EHLO
        dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbeLSTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:30:13 -0500
X-AuditID: 1209190c-7c5ff700000014b1-1e-5c1a9c421bdd
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id F3.05.05297.34C9A1C5; Wed, 19 Dec 2018 14:30:12 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-2.mit.edu (8.14.7/8.9.2) with ESMTP id wBJJU9Nt018053;
        Wed, 19 Dec 2018 14:30:09 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBJJU6ws011260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Dec 2018 14:30:06 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8F5A57A51B5; Wed, 19 Dec 2018 14:30:05 -0500 (EST)
Date:   Wed, 19 Dec 2018 14:30:05 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181219193005.GB6889@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO/det7uxW2fT8jgrcBqFYRYFXcikyOgWFVFGkUFe3c2ttmn3
        TlGhktDEJTWiSFfpUsoeRjUFoyxxmTgnClb20LSHveyFDl9p0r0+0v++v9/nfL5wOIfENe1+
        WtJosXK8hTXpZEpCI48Oi4i5pN2//EYZoPPP1frRb39X+dGV9Z2Avl09itNeewlGd99x4HRh
        UYeMbi3ZRPcUDRB09SMPQTc018vpZw8uyegumw2nP5z+KafrKupk6+YwjSWIcbpSmYrr4Yzr
        Zp6MaSgYIZh37gqCeej0YUzvpzcEk13TJmN8roU7lPuUUXrOZEzj+MjoeKUhf+gjkVIG04cH
        7smzgJOyAQWJ4CpU9fI8YQNKUgPLMfSgKRdMDPcAcl15Pjn0YGjwmlcuKRrIo5LSx5iUCbgI
        Xc4rk0lZBpeg8k9/CSkHwG3Ifr8Fl2QcZhMop7V7XPCH61Hph1/jmYJLUbm7YTK3EOj8idCJ
        rEaewu7xIhyGo1dj38QzpJiDUdkYKa0VcDf64h0cX8+FYcjnhHagdsyQHTNkx7TsBPhNsEBv
        zowws0aTwCVGCImsxcLxESuWmY3WZZw+1QWkN1QEqe6Dph9b3ACSQKeiCvZp92v82DQhw+wG
        QSSmm0spCsXV7IRkfYaBFQwH+FQTJ7gBInFdANVnFxmlZzMyOT55CgWThC6QGgn4GKeBSayV
        O8xxKRw/ReeTpA5R9QWiqOa5JC79oNFkncYYqZDKVWK52iGVCymsWTAmTfBGEKINpF5IAErA
        kGr570p/0pAzi+sBgeJV/Knii+Iplfhj/9s9YjEmFpsqManYyk4jbRbwlA9Y2n7MOhLpCwFD
        2f5rVlflkMv5GuPD/pDeo7q0pENPd+Zt932PsrUGhcXUho16jcTXta9HuVjvqc9xt/ZsvNWf
        XPy0d97eptuxqj9PVJm5IxdOFnUMNV99X2zf1RtwJvTusXg03LnyeMKN0PazDnPO4r43XcwG
        g2fzVr1AJzbqCMHArgjHeYH9B/Z1l/1uAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 01:19:53PM +1100, Dave Chinner wrote:
> Putting metadata in user files beyond EOF doesn't work with XFS's
> post-EOF speculative allocation algorithms.
> 
> i.e. Filesystem design/algorithms often assume that the region
> beyond EOF in user files is a write-only region.  e.g. We can allow
> extents beyond EOF to be uninitialised because they are in a write
> only region of the file and so there's no possibility of stale data
> exposure. Unfortunately, putting filesystem/security metadata beyond
> EOF breaks these assumptions - it's no longer a write-only region.

On Tue, Dec 18, 2018 at 11:14:20PM -0800, Christoph Hellwig wrote:
> Filesystems already use blocks beyond EOF for preallocation, either
> speculative by the file system itself, or explicitly by the user with
> fallocate.  I bet you will run into bugs with your creative abuse
> sooner or later.  Indepnd of that the interface simply is gross, which
> is enough of a reason not to merge it.

Both of these concerns aren't applicable for fs-verity because the
entire file will be read-only.  So there will be no preallocation or
fallocation going on --- or allowed --- for a file which is protected
by fs-verity.  Since no writes are allowed at all, it won't break any
file systems' assumptions about "write-only regions".

As far as whether it's "gross" --- that's a taste question, and I
happen to think it's more "clever" than "gross".  It allows for a very
simple implementation, *leveraging* the fact that the file will never
change --- and especially, grow in length.  So why not use the space
after EOF?

The alternative requires adding Solaris-style alternate data streams
support.  Whether or not ADS is a good idea or just an invitation to
malware authors[1] is something which can be debated, but my position
is it's unnecessary given the requirements of fs-verity.  And avoiding
such complexity is a *good* thing, not a bad thing.

[1] https://www.deepinstinct.com/2018/06/12/the-abuse-of-alternate-data-stream-hasnt-disappeared/

						- Ted
