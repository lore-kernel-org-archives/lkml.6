Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92035ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 10:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479652084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479652084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeGULbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 07:31:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:54776 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeGULbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 07:31:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB5CA2C4;
        Sat, 21 Jul 2018 10:38:49 +0000 (UTC)
Date:   Sat, 21 Jul 2018 04:38:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Sphinx version dependencies?
Message-ID: <20180721043847.59a2cb0a@lwn.net>
In-Reply-To: <20180720131206.GM30706@thunk.org>
References: <20180719181556.GA21435@thunk.org>
        <20180719190400.GB4800@magnolia>
        <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
        <20180720131206.GM30706@thunk.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 09:12:06 -0400
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:

> A forth solution is to force everyone to use something correleted to
> what the community distro's are packaging, but roughly every 12-18
> months, we leapfrog to a newer version of Sphinx.  This decreases the
> continuous upgrade burden, but doesn't make it go away.

[I'm mostly AFK at the moment, so haven't been following this discussion
in anything approaching real time].

The above is roughly what I've been aiming for; I'd really like for
people to be able to just build the docs without having to go beyond
their distribution's repos.  It gets challenging at times because Kids
These Days seem to have a different view on issues like long-term
compatibility.  But we've mostly done it; it's pretty rare that we've had
docs build problems that have been tied to a specific version of Sphinx.

You all just got lucky :)

jon
