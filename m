Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC32ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C3D208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C3D208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733095AbeIXXVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:21:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45240 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbeIXXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:21:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id j2-v6so3639297edp.12;
        Mon, 24 Sep 2018 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=stqb3sC4bsi7+FVU3qTZFQ2qIQ8ZS4hAa3YPz1rbdAw=;
        b=PQk7YwtFYCRMIk7oL99Mu1a2+LVZaezzObJ3Y0nUM9i9WzEk6/LWUWIvAo6gv4WFvL
         VZNuZ5NHBDc54ie/qS7GI01tWLbuLansLISSNE0nfyK1bZhqtxxO7RtURTtQfOWuAejF
         AS+aZmWkl+iZHsnscq2uoWJ4QPdGHt7LAjQR+56tgWjdnInXrEiACcU3oAQhDrAuwLFA
         /dM3JWhkbq4geV1XB3ggksqtlWr4tVyel8jWvr1391J67LHxM1NnDtghYkmiHm0e7Bn8
         AMVLGDk4vfpEnc6J4dmb1Dr94YAkKezj6deDGxO2F43NUOI1ngAbnwG5wBI1Gg2uzl2k
         ad3A==
X-Gm-Message-State: ABuFfohNoDOEPK59N5Bvz/hhMf723pR8l6keNL7llMW0Cfp/fOnN7FkI
        x926vqFEog9dmXuZGsz4oBE=
X-Google-Smtp-Source: ACcGV63uzFb5dSAB2svAZMJMY4+7+bG5kFHYHNg6exocJJcI1dLoj/JcgPcuaBwe5zxAYRy9js+WvQ==
X-Received: by 2002:aa7:c759:: with SMTP id c25-v6mr1259781eds.231.1537809524521;
        Mon, 24 Sep 2018 10:18:44 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id y42-v6sm4320448edb.83.2018.09.24.10.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:18:43 -0700 (PDT)
Date:   Mon, 24 Sep 2018 19:18:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/2] ARM: dts: exynos: DT for v4.20 (or 5.0)
Message-ID: <20180924171841.GA11520@kozik-lap>
References: <20180921174520.9126-1-krzk@kernel.org>
 <20180923134742.pugsdeozfp3lp56a@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180923134742.pugsdeozfp3lp56a@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 06:47:42AM -0700, Olof Johansson wrote:
> Hi,
> 
> On Fri, Sep 21, 2018 at 07:45:19PM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Nothing special, description in tag.
> 
> Hmm. Point 12 is special, I'd say.
> 
> I commented on the patch, and I don't want to hold everything else up so it
> might make sense to separate that out and send a fresh pull request with the
> base material while that part is discussed a bit more.

I was thinking about any special merging care and effects. I did not
hide this point 12 as it received pretty big explanation.

I will resend this pull without this commit. Thanks!

Best regards,
Krzysztof

