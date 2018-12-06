Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C431020661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C431020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLFRJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:09:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:33804 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeLFRJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:09:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DC69A2B6;
        Thu,  6 Dec 2018 17:09:17 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:09:12 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     NeilBrown <neilb@suse.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: convert path-lookup from markdown to
 resturctured text
Message-ID: <20181206100912.535b351d@lwn.net>
In-Reply-To: <87woonelit.fsf@notabene.neil.brown.name>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name>
        <87sgzc7v50.fsf@notabene.neil.brown.name>
        <20181205124644.3f8a452a@lwn.net>
        <87woonelit.fsf@notabene.neil.brown.name>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2018 08:00:58 +1100
NeilBrown <neilb@suse.com> wrote:

> > Is there a reason you used "include" rather than just adding it to the
> > TOC tree with the rest?  
> 
> Simple.  I didn't know what I was doing, and so randomly made changes until
> the result seemed acceptable - then I stopped.  If there is a better
> way, feel free to tweak that when applying.

OK, tweaked and applied, thanks.

jon
