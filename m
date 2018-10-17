Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A094ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0621A2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0621A2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJQXUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:20:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41675 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:20:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id c32so26573665otb.8;
        Wed, 17 Oct 2018 08:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0K1aFQ8/XZ8HCls+6/2G7Ve0JWnnbAtChk68WtMu68=;
        b=sG0mTGyWq1kl4Jy+vji4qJhT8EjP2OKtD9ZRoLnNAYqH+Rl5GWWKWeIaFk9LjPALk+
         sdD/SOvkM/BQ6LkFSNMw+jsXS7GOD+sJEdMBEHnIqsAtlTmdYm4CpUIbvH+J4TwmBIcQ
         eC3SEhfhfRghpjMCXALeYEyvunSIWZPjgt5GeIQ8TCJW6n5EUsnqUdQ5i+FFolHpIIKo
         kM/kGWSpcO5EdNG575gtQQ4walFZpUM1bisgq2qqPlFP9WQuojvTUKEeCtyt/Hps3weR
         /OpG0hc3E7NF2KYQAryS6cAmKV4/hvss0dJoYkxjB3dPifekEA79ysL3HzrKyHYn+0GM
         5WYg==
X-Gm-Message-State: ABuFfohuTfKapkRwQLfhlRQpKLplL+lPV8V058K4K8z6xvWeAAFop+kS
        cPQScWA5+wsewmwOjyZhjKMkcqI=
X-Google-Smtp-Source: ACcGV60nILbir8GN7lV07BdL2Xf9qkM1nnh1xXsXqE3Lb5s3wwP2XQ89f7JaGEdXdFCyzxWKB/2kHw==
X-Received: by 2002:a9d:2538:: with SMTP id k53mr15836318otb.156.1539789835775;
        Wed, 17 Oct 2018 08:23:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g188-v6sm7368913oic.10.2018.10.17.08.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:23:55 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:23:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX
 + 1
Message-ID: <20181017152354.GA9268@bogus>
References: <cover.1539036280.git.gustavo@embeddedor.com>
 <3a1a95a4832af33dcd1842b0298d257bbcf1f5ab.1539036280.git.gustavo@embeddedor.com>
 <20181009072723.mshyvplpo2xmkyfl@qschulz>
 <dab86dfb-d56b-b7c3-8e2a-6955803a2842@embeddedor.com>
 <20181017150931.GA385@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017150931.GA385@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:09:31AM -0500, Rob Herring wrote:
> On Tue, Oct 16, 2018 at 10:44:52AM +0200, Gustavo A. R. Silva wrote:
> > Hi,
> > 
> > On 10/9/18 9:27 AM, Quentin Schulz wrote:
> > > Hi Gustavo,
> > > 
> > > On Tue, Oct 09, 2018 at 12:21:36AM +0200, Gustavo A. R. Silva wrote:
> > >> SERDES_MAX is a valid value to index ctrl->phys in
> > >> drivers/phy/mscc/phy-ocelot-serdes.c. But, currently,
> > >> there is an out-of-bounds bug in the mentioned driver
> > >> when reading from ctrl->phys, because the size of
> > >> array ctrl->phys is SERDES_MAX.
> > >>
> > >> Partially fix this by updating SERDES_MAX to be SERDES6G_MAX + 1.
> > >>
> > >> Notice that this is the first part of the solution to
> > >> the out-of-bounds bug mentioned above. Although this
> > >> change is not dependent on any other one.
> > >>
> > > 
> > > Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > > 
> > 
> > Friendly ping. Who can you take this?
> 
> Applied. No need (nor benefit) to ping me. You can check the status of 
> DT patches on patchwork[1]. If it is there and in the "New" state, it is 
> in my queue.

Actually, this doesn't apply to my tree as the file doesn't exist. It 
needs to go thru the phy tree. You didn't Cc the maintainer nor list, so 
resend.

Acked-by: Rob Herring <robh@kernel.org>

Rob
