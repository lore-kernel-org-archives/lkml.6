Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830DBECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DD21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298DD21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbeIURZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:25:05 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56143 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIURZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:25:05 -0400
Received: from theta ([188.102.174.54]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MnZwp-1fKNzf1oKD-00jYPh; Fri, 21
 Sep 2018 13:36:30 +0200
Date:   Fri, 21 Sep 2018 13:36:42 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Code of Conduct: Let's revamp it.
Message-Id: <20180921133642.f1bbbc2b613f24ae8fbafc0d@christoph-conrads.name>
In-Reply-To: <2808315.UYOVJ65Qvk@merkaba>
References: <20180920231823.46d282ce40c91f39988bd34e@christoph-conrads.name>
        <2808315.UYOVJ65Qvk@merkaba>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j6mPVex/0Zbtdd4M5COJGk34+cVx2NHvvy8XDVEUEEATcT6yDku
 aD/bS3vhK2FAoZyvESjfaTWw76ySNWKJGNDsfegs09bgGkILCHcvDee47+7SG35h4YRS9QY
 ksB47u7yWnEVUgVM4T9tLgRwfnT4mUI4MBb6aslMPZgRjNeSpuDMcHUsmRfZWA5ZG785FNW
 wrbHHsgGvg8S7MN309tKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q4WDsIQeZ0E=:ozk5JHHZx+cz3ciH6fN/YR
 DphHXMATu0wAdjyy0pwDnECpDIuv0+iyXjXk4iPTS57rvX1syO37fXyH88Hximi+PJJrwx05E
 DOOojFjalZpAwurYH15WF3tUNQMr5hwD5oHVSwkM5X9wvvXk65R3FzHnQHiGd+uexAJZ/gITs
 XOGBG2BuB3Sn0ZdMBsnLHZoQ0rZNBs0xuFaT1p/NfR0cFw/AWzsbmc2BjpR+R/569ivbui/zy
 4bmJ+hHhYUMt6qCurWXYoZ2ma9lbBy9JWbunMaATsGxtlXARsIqnqr07NaNwz6BDiEVEiGZBU
 f8V3vCbLWB1KMwD2VXRXVAPbnn1ykLrzENtGPEB7K6eoV126NYoDEA33v1UjfQzghdyg4RyWi
 6CZ7hhB7LQ3Z2kQfdjv1fAh+DsUN3ETV7a2DCp5DjV1tzp1mxfoZ566zovEpsY05Sg8Ti9l+q
 E6ljYVCCa5FP04TV52KM+cVFZMyDLVIhXh4bisGy5wZ2Vhsu9kiOEmsP5rOIFkGQUZR+xsKnl
 Nz8fxk5CvzuuPPesvjcbP6miPF0kcK6WXjED8VjzPDBs3RD1gtq770g8VXmwXQXDKmBZuiZXe
 OIumJDU0Rf593U/s5qEXa4FCNXCt5IJEewEi3lw+FGa4VE2U9vYjgj60MZCYzVSBDMquCZfH1
 MuiOCykkCOo//I7jMxO5ti1KhI9k5kWyJL1myRAFeHwuJt7wVipE7CWEbPD102EMjb/Hcejcn
 ZPYz7QBAexnb07SB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Martin,

> What I see here is that a lot of people who are not even contributing to 
> the Linux kernel in a major way apparently want to make their opinion 
> about Code of Conduct heard loudly.
> 
> I ask myself: What the point of it?

So far, the Contributor Covenant CoC always left a path of destruction
in its wake, see for example the list posted by Michael Woods [1].
There is not a single success story to be heard. Add to that the
very political and very vocal crowd associated with the CoC: These
people drive away contributors, they do not contribute themselves
because they are busy policing the behavior of the remaining
contributors (see OpalGate), and they will not stop until each and
every software project abides to their CoC. To top it off, none of the
Linux maintainers seem to be aware of or bothered by the incidents in
other projects adopting the Contributor Covenant CoC.

> Some of the major contributors apparently see that the way of 
> communicating here and elsewhere sometimes (!) does not serve Linux 
> kernel development and the community. By just continuing the way it is, 
> it is unlikely to receive a different outcome. So it is important to 
> change *something*.

Again, I have yet to see a single success story related to the
Contributor Covenant CoC.

Communication issues and the magic word "harassment" are just
pretexts to establish "investigative" boards operating in secrecy to
maintain anonymity of accusers and to give a "legal" foundation for
censorship based on subjective judgement inside and outside of the
LKML. The Rod Vagg case is a nice example of what can come of this
secrecy [2]. Note that Node.js applies the same CoC.

> There is a kernel developer summit where they like to discuss exactly 
> things like this. I do not see it up to me to try to control the outcome 
> of that process.

Removing or modifying an existing CoC is very different from agreeing
to a new one. I bet 10 Dollars that at least one person who proposes the
remove the CoC at the summit, will be called out for supporting
harassment -- if you can still attend without signing the CoC.

> KDE.org has a code of conduct¹.
> [snip]
> [1] https://www.kde.org/code-of-conduct/

The KDE CoC does not force maintainers to take "corrective action".
Additionally, the Contributor Covenant CoC may also apply outside of
development and it gives a carte blanche to the maintainers to punish
behaviors deemed unfit for contribution. The KDE CoC does stipulate the
existence of committees operating in secrecy.

> I really don´t see the point of most of the discussion here. What 
> happened now won´t be the end of Linux and that´s about it. There is no 
> point for predicting doom unless you want it to happen.

Let's make doom happen with the aid of the Contributor Covenant CoC.

[1] https://lkml.org/lkml/2018/9/17/1147
[2] https://github.com/nodejs/CTC/issues/165
