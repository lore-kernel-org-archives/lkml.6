Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7FBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C1B20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C1B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIZEkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:40:40 -0400
Received: from thyrsus.com ([71.162.243.5]:37836 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725736AbeIZEkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:40:39 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 3BD663A42A5; Tue, 25 Sep 2018 18:30:31 -0400 (EDT)
Date:   Tue, 25 Sep 2018 18:30:31 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Conrads <contact@christoph-conrads.name>,
        Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180925223031.GA20619@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Conrads <contact@christoph-conrads.name>,
        Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <20180925112832.GA10951@amd>
 <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
 <20180925151406.GB2933@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925151406.GB2933@thunk.org>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o <tytso@mit.edu>:
> There have been those who have characterized the GPL as being more
> than just a license, but also a political statement.  And yet, many
> projects, include Linus, use the GPL without necessarily subscribing
> to all of Richard Stallman's positions, political or otherwise.

The case isn't parallel. Every kernel dev knew they were joining a
commons defined by GPL terms when they signed on.  Regulation of
soi-disant "hateful" speech and "diversity" objectives, on the other
hand, are a *new* set of claims and norms not entailed in established
practice.

There ought to be much broader consensus before anything like that is done -
and I would say that even about new political claims I myself supported.
Instead, what we have is open revolt from a dissident faction that thinks
the project would be better destroyed than under the CoC.

That should be a clue that imposing the CoC without a lot of public
discussion and preparation was a mistake, and it should be revereted until
at least rough consensus in fovor of some improvement on the old
Code is achieved.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


