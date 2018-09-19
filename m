Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022ECECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DCB2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DCB2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbeIST4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:56:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:58738 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbeIST4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:56:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 53E512C9;
        Wed, 19 Sep 2018 14:18:14 +0000 (UTC)
Date:   Wed, 19 Sep 2018 08:18:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Edward Cree <ec429@cantab.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180919081812.020f19e3@lwn.net>
In-Reply-To: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 07:00:26 +0100
Edward Cree <ec429@cantab.net> wrote:

> By placing a corporate body (the LF) in
>   the position of arbiter, an avenue is opened for commercial pressure to be
>   applied; and the legalistic phrasing of the Code practically invites 
> rules-
>   lawyering whereby the most abusive may twist it into a weapon to further
>   their abuse.

I'd like to address just this part, speaking only for myself.

The LF is not in the position of arbitrating anything here.  The body
charged with that is the LF Technical Advisory Board, which is a
different thing.  It's currently this motley crowd:

  https://www.linuxfoundation.org/about/technical-advisory-board/

I think most of us would agree that those folks lack the desire to go
around harassing developers, and they lack the time to do so in any
case.

The TAB is chosen by a vote of developers at the kernel summit; that will
happen in Vancouver in November.  

jon
