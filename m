Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D33C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F7F2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeL3Rkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:40:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:54648 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeL3Rkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:40:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A683A9B3;
        Sun, 30 Dec 2018 17:40:30 +0000 (UTC)
Date:   Sun, 30 Dec 2018 10:40:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-doc@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: cgroup: use graphviz code instead of ASCII art
Message-ID: <20181230104020.1074d807@lwn.net>
In-Reply-To: <20181230164945.GA2644@personal>
References: <20181230164945.GA2644@personal>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2018 17:49:45 +0100
Otto Sabart <ottosabart@seberm.com> wrote:

> The graphviz looks better. This patch also fixes multiple build warnings:
> "WARNING: Block quote ends without a blank line; unexpected unindent."
> 
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>

The graphviz looks better *in some settings*, such as the formatted
version of the docs.  Please remember, though, that we need to preserve
the readability of the plain-text documents as well, and my own feeling
is that this patch is a step backward in that regard.  I'll defer to
Tejun on this if he feels otherwise, but my sense is that this is not
something we want to do.

OTOH fixing the warnings would be a good thing; I think it just needs a
bit more use of literal blocks.  I would gladly accept a patch that did
just that.

Thanks,

jon
