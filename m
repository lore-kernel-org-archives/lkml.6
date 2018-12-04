Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5BF2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="brScI2mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5BF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeLDRk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbeLDRk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:40:56 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F75120659;
        Tue,  4 Dec 2018 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543945256;
        bh=LjtSmIAe42/eyEMp2N+S1vGCZYt2I5fHOwHYL5TjVF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brScI2mjW4IGZRaKwzz74mYVt47lggm52/Q6jbKiUc0kqr/Bi3D6N3NX8j6G2+6pK
         SDiCJ1XE2mNJlj9MQ5zCRnHXZOiGS12/v8SL6ZsBuFtrtARbhPo7hCQunxC/oaFOuF
         vvEkIc2x+2r7sqSKEH2mGPydtSQcqYl4JO1wlfhA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80CB84042C; Tue,  4 Dec 2018 14:40:50 -0300 (-03)
Date:   Tue, 4 Dec 2018 14:40:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools: Fix diverse typos
Message-ID: <20181204174050.GE19069@kernel.org>
References: <20181203102200.GA104797@gmail.com>
 <20181203103107.GC11573@hirez.programming.kicks-ass.net>
 <20181203105219.GA104329@gmail.com>
 <20181204171632.42jhm25oimlvac3c@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204171632.42jhm25oimlvac3c@two.firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 04, 2018 at 09:16:32AM -0800, Andi Kleen escreveu:
> 
> I've let the JSON maintainers know.

Thanks!

- Arnaldo
