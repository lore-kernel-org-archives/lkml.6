Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032555AbeBOCN1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:13:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40618 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032454AbeBOCN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:13:26 -0500
Date: Thu, 15 Feb 2018 02:13:21 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Pittman <jpittman@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Change 'unsigned' to 'unsigned int' throughout
 block layer
Message-ID: <20180215021321.GB30522@ZenIV.linux.org.uk>
References: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518658622-5931-1-git-send-email-jpittman@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 08:37:02PM -0500, John Pittman wrote:
> In quite a few files throughout the block layer, the bare 'unsigned' is
> used rather than the preferred 'unsigned int'.

Preferred by whom?

>  The issue was

What is that "issue" and why is it a problem in the first place?

> exposed by checkpatch.pl.  Warnings encountered were:

Oh, good - so presumably it does have some explanations beyond "The Most Holy
checkpatch.pl Spake Unto Us"; could the esteemed sir share those with us?
