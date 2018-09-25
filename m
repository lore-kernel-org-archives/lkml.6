Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6017120880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6017120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeIYTsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:48:33 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39463 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbeIYTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:48:33 -0400
Received: from theta ([88.75.240.18]) by mrelayeu.kundenserver.de (mreue002
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Ldhch-1fMd0W38RH-00j0RW; Tue, 25
 Sep 2018 15:40:47 +0200
Date:   Tue, 25 Sep 2018 15:41:01 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     esr@thyrsus.com
Cc:     Pavel Machek <pavel@ucw.cz>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-Id: <20180925154101.e13613306da9c0e7408771b6@christoph-conrads.name>
In-Reply-To: <20180925131344.GB7479@thyrsus.com>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
        <20180919081812.020f19e3@lwn.net>
        <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
        <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
        <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
        <20180925112832.GA10951@amd>
        <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
        <20180925131344.GB7479@thyrsus.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OBFnNKjxXQE6YuSLMXSMCh1VDsNqu13WKdJ4kwJxWBOxQZqN59m
 z/Dka1uwwu9W74gNeyruyqnsbP2rBv6IEB95Gubu0IfsFP5c2Ev+0AltKZSlLL0AIpoX4Hx
 t1HIu00S1PXwGgfSLoQrG0BMqRmX3ND1YHMqawhxYeVUth0yEpMR9XEQs2IV92YNG5vwk0b
 IvhRiib2YT0JRuyiaNXpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Otok5wRDirA=:bmq+duQR4OXP2SoY7BpXG9
 cEDdo4/rj7GkYRh/kjybzlC1yQn4d0AbRyRmQ7mS9kbIpyjOjZg34Hf2Ga4DK5o4bhcANEO1/
 HjPY7NVfb4gtDf8Dm06pb8npf9RTbx7K8wKSqOknQ5GLhJpxGozW2hbf3PrRshCk2JF9Zucrm
 bx+tVAGisQ+lLfFr3nrE5NuHj0bxdedPZW+Cu63hcqjpgeR40ZAchjlotiLE26jZkRNyWJoYp
 3OdqDSFdsAoiGeBSE+QOcQLd7ZdXbkil2lmbjxVx027svmwrYxc+0kDM4IUTjBtBXjpDQVCoK
 5gcE9ZDPUHZ98J+M2R/XUy1anqVyB/DZG0SpUs5ppyi/7W4uZT6tnvj27GyoS3QgXeiJxvtbH
 HVMoGuudIwcZPKPK+mOysbuHjmpx5CZaFXPdI/XDZf0tqe6BANL0h2US2n0lxxWKxSWxZNHsd
 UExPrvu7gKNq7CR+usc1H7Yfg+odKoTEyV9VwWc9xfuHn8ZPmJri0uU5zb45dKWnh9s2WFh92
 Wa87nGlBB1OLblHSHSqHVOrGRLEhnZMjdDpCTCeFqsNJZd3+kJeZsiUO9EWUBG1sG/S67HM0E
 zL9Rl9yDPRq5z47jrbL4A126p+dAtKuMORXYznodjYumUBcRl6lh1pJSkBJDyd0phmhIHy5gL
 dPgO53htnH1AYeoMbgJIjyRYznoCbh+227Os9Nwvs/qqRskkZaLC4OwRGg9Y/WdGxlXZPKt6l
 uFYh/C3s86y2HkMB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Eric,

> > The CoC is a political document:
> > https://web.archive.org/web/20180924234027/https://twitter.com/coralineada/status/1041465346656530432
> 
> And there is no level on which this is anything but bad.
> 
> The kernel devs are a very large, very diverse, multi-national, multi-cultural
> group. We have nothing to gain by getting entangled with political culture
> wars, and everything to lose.

In this context, I want to mention the tweet by the CoC author from
August 29, 2018 [1]:

> All software is political.

This tweet was posted as a response to your article "Non-discrimination
is a core value of open source" stating that politics should be kept
separate from work (in an open source community):

> The Lerna project’s choice is, moreover, destructive of one of the deep
> norms that keeps the open-source community functional – keeping
> politics separated from our work. If we do not maintain that norm, we
> risk fractionating into a collection of squabbling tribes arguing
> particularisms and unable to sustain really large-scale cooperation.

[1]
https://web.archive.org/web/20180925132931/https:/twitter.com/CoralineAda/status/1035009876152467456
[2] http://esr.ibiblio.org/?p=8106

Sincerely
Christoph Conrads
