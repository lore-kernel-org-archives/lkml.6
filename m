Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA48C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5672A2148D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBAXPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:15:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:33540 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAXPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:15:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CC31F2BD;
        Fri,  1 Feb 2019 23:15:34 +0000 (UTC)
Date:   Fri, 1 Feb 2019 16:15:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Joel Nider <joeln@il.ibm.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] update infiniband uverbs documentation
Message-ID: <20190201161533.5000ad95@lwn.net>
In-Reply-To: <20190201165252.GA13002@ziepe.ca>
References: <1548151235-386-1-git-send-email-joeln@il.ibm.com>
        <20190201165252.GA13002@ziepe.ca>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 09:52:52 -0700
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> Doc folks, what is the feedback on these patches? Should I take
> them through the rdma tree?

If you think they are ready (it seemed that there were still comments on
one of the patches?) I'll take them, just let me know.

Thanks,

jon (aka "doc folks" :)
