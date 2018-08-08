Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABE7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1624F208D4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1624F208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darmarit.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeHHSrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:47:22 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:59392 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeHHSrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:47:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 3243023F3E3;
        Wed,  8 Aug 2018 18:26:52 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SWa2M92dRkof; Wed,  8 Aug 2018 18:26:51 +0200 (CEST)
Received: from ryzen (host-091-097-244-086.ewe-ip-backbone.de [91.97.244.86])
        by smtp3.goneo.de (Postfix) with ESMTPSA id B18A023F2AB;
        Wed,  8 Aug 2018 18:26:50 +0200 (CEST)
Message-ID: <1cfb4fb3406621c1ffd98e8072f2cc38812107d8.camel@darmarit.de>
Subject: Re: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
From:   Markus Heiser <markus.heiser@darmarit.de>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <me@tobin.cc>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Aug 2018 18:26:50 +0200
In-Reply-To: <99c50323-601e-91ea-cac3-98c1f381f9ac@iogearbox.net>
References: <20180801050908.29970-1-me@tobin.cc>
         <20180801050908.29970-13-me@tobin.cc>
         <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
         <20180808014248.GF11191@eros> <20180808072310.4695cea4@lwn.net>
         <99c50323-601e-91ea-cac3-98c1f381f9ac@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am Mittwoch, den 08.08.2018, 15:45 +0200 schrieb Daniel Borkmann:
> On 08/08/2018 03:23 PM, Jonathan Corbet wrote:
> > On Wed, 8 Aug 2018 11:42:48 +1000
> > "Tobin C. Harding" <me@tobin.cc> wrote:
> > 
> > > Thanks for doing such a careful review that you noticed this.  I'm
> > > working on this more ATM and I've moved the document to use double
> > > spaces between _all_ full stops.  Currently the document uses mostly
> > > single spaces but there are some sections with double space.  The
> > > internet tells me this is a 'style' issue not a rule.  And I've seen
> > > single and double spacing in tree and do not know if one is favoured.
> > > 
> > > Do you care? 
> > 
> > I'm not Daniel, but let me just say that, for docs in general, I'm
> > absolutely uninterested in patches adjusting the number of spaces after
> > periods.  It really doesn't matter one way or the other, and I don't think
> > we benefit from that kind of churn.
> 
> Yep, agree.

FWIW: even if it is not a patch worth, 'fill-paragraph' within emacs benefit
from.


-- Markus --

