Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107D32082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="D7rMKtfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107D32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeLDRQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:16:35 -0500
Received: from one.firstfloor.org ([193.170.194.197]:47298 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:16:34 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id C1027868D9; Tue,  4 Dec 2018 18:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1543943792;
        bh=OTxkiUYkk+dbVlylcFXlcYJgitqx6Vt7IWTLa60K/U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7rMKtfHm2v4248JxjTFfNpInvtNi/sHVemLJBkU63r93sOWYzWhfGFkIeqcoPTiT
         ki7cvbqC9JI8//V4ko2AF94ntf8sSCAV5t4XzTnBQ29vK5pH+ONd1aRtKq/h8ydeUY
         kteSvQgI9ybtLL8Qy/2pCpiVcu2M0BDSJYXNCT54=
Date:   Tue, 4 Dec 2018 09:16:32 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] tools: Fix diverse typos
Message-ID: <20181204171632.42jhm25oimlvac3c@two.firstfloor.org>
References: <20181203102200.GA104797@gmail.com>
 <20181203103107.GC11573@hirez.programming.kicks-ass.net>
 <20181203105219.GA104329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203105219.GA104329@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've let the JSON maintainers know.

-Andi
