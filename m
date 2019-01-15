Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EEFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D920859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbfAOSCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:02:20 -0500
Received: from ms.lwn.net ([45.79.88.28]:43866 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfAOSCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:02:20 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 709142DD;
        Tue, 15 Jan 2019 18:02:19 +0000 (UTC)
Date:   Tue, 15 Jan 2019 11:02:18 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Joel Nider <joeln@il.ibm.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs-rst: Convert user verbs doc to rst
Message-ID: <20190115110218.3d844efc@lwn.net>
In-Reply-To: <20190115151402.GA22045@ziepe.ca>
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
        <1547547991-5314-2-git-send-email-joeln@il.ibm.com>
        <20190115151402.GA22045@ziepe.ca>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 08:14:02 -0700
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> > Move user_verbs from infiniband to userspace while changing the
> > format. Replace the existing Documentation/infiniband/user_verbs.txt
> > with Documentation/userspace-api/user_verbs.rst. No substantial changes
> > to the content - just some minor reformatting to have the rendering
> > come out nicely.
> > 
> > Since this documents a userspace API, its home should be with the
> > other userspace API docs.
> > 
> > This is in preparation for updating the content in a subsequent
> > patch.
> > 
> > Signed-off-by: Joel Nider <joeln@il.ibm.com>
> > ---
> >  Documentation/infiniband/user_verbs.txt    | 69 -----------------------------
> >  Documentation/userspace-api/index.rst      |  1 +
> >  Documentation/userspace-api/user_verbs.rst | 70 ++++++++++++++++++++++++++++++
> >  3 files changed, 71 insertions(+), 69 deletions(-)
> >  delete mode 100644 Documentation/infiniband/user_verbs.txt
> >  create mode 100644 Documentation/userspace-api/user_verbs.rst  
> 
> Need to update MAINTAINERS for the new file.. Maybe call this
> rdma_user_verbs.rst as we could also have rdma_umad, rdma_cm, etc

Both of those suggestions make sense.  Joel, can you do a quick respin
along those lines?  Then I think this one is ready.

Thanks,

jon
