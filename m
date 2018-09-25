Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF25C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BA82098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BA82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thyrsus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeIYTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:21:40 -0400
Received: from thyrsus.com ([71.162.243.5]:50490 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbeIYTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:21:39 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 865823A42A5; Tue, 25 Sep 2018 09:13:44 -0400 (EDT)
Date:   Tue, 25 Sep 2018 09:13:44 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Christoph Conrads <contact@christoph-conrads.name>
Cc:     Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180925131344.GB7479@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Conrads <contact@christoph-conrads.name>:
> The CoC is a political document:
> https://web.archive.org/web/20180924234027/https://twitter.com/coralineada/status/1041465346656530432

And there is no level on which this is anything but bad.

The kernel devs are a very large, very diverse, multi-national, multi-cultural
group. We have nothing to gain by getting entangled with political culture
wars, and everything to lose.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

My work is funded by the Internet Civil Engineering Institute: https://icei.org
Please visit their site and donate: the civilization you save might be your own.


