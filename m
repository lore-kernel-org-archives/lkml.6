Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F778ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5F920850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5F920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGRMka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:40:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:58108 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeGRMka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:40:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BDD622BA;
        Wed, 18 Jul 2018 12:02:53 +0000 (UTC)
Date:   Wed, 18 Jul 2018 06:02:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] docs/mm: add boot time memory management docs
Message-ID: <20180718060249.6b45605d@lwn.net>
In-Reply-To: <20180718114730.GD4302@rapoport-lnx>
References: <1530370506-21751-1-git-send-email-rppt@linux.vnet.ibm.com>
        <20180702113255.1f7504e2@lwn.net>
        <20180718114730.GD4302@rapoport-lnx>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 14:47:30 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> > So this seems like good stuff overall.  It digs pretty deeply into the mm
> > code, though, so I'm a little reluctant to apply it without an ack from an
> > mm developer.  Alternatively, I'm happy to step back if Andrew wants to
> > pick the set up.  
> 
> Jon, does Michal's reply [1] address your concerns?
> Or should I respin and ask Andrew to pick it up? 
> 
> [1] https://lore.kernel.org/lkml/20180712080006.GA328@dhcp22.suse.cz/

Michal acked #11 (the docs patch) in particular but not the series as a
whole.  But it's the rest of the series that I was most worried about :)
I'm happy for the patches to take either path, but I'd really like an
explicit ack before I apply that many changes directly to the MM code...

Thanks,

jon
