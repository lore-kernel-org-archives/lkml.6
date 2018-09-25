Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5997C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C030214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C030214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=christoph-conrads.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeIYSoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:44:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeIYSoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:44:01 -0400
Received: from theta ([88.75.240.18]) by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N5G1V-1ffvwI1XQT-011Egm; Tue, 25
 Sep 2018 14:36:31 +0200
Date:   Tue, 25 Sep 2018 14:36:45 +0200
From:   Christoph Conrads <contact@christoph-conrads.name>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Edward Cree <ec429@cantab.net>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-Id: <20180925143645.af1457944142ecfec7199d80@christoph-conrads.name>
In-Reply-To: <20180925112832.GA10951@amd>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
        <20180919081812.020f19e3@lwn.net>
        <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
        <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
        <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
        <20180925112832.GA10951@amd>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e+EdQ+Rjk77KlqOIKUUEtakkjGkSCwlbI67upYejP0tzsRvJMm6
 fEI3fDDFiR9kmLOC1rdXRSMCGrj4xRlgc9myzCvKf2hZs9dGUtxExJj+6UzKOXebO/nrki9
 nZm89NmDrS3FEa7QtJoVAJn4PTdMsARR/58eT2lIJdSNLyIkJcI+8YrQ/8qr7HzQGi2Wgas
 gMEmhUbjgCAKKa03mQ1EA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DsouYEG30rA=:gegpkz6N4DPMzQ1no8Sjrw
 KTiXkfDqd3K2J1R/Ns/6q/4hUWXuvbpaWrUAArdHPn0BWBG7XqVWIJcuLZ7RryWzbj9vtdxg4
 o8ssMweUSRA0mdbvCVh0GHLe2MO/+6I2NPBNKOywg1ITNvGIJRxhulgQz0WVtwIzryOg2EtCN
 FDlEml8lHgfkKxQsH96IjdUb6N1kqxpgo0my9VY9hJZ6DWy1qCqQ4VQp+Jo+JCNU/evugrUye
 hrUp/N/I89dj1SpNSAhIuUAol+f2sBEtNszcRe8piVXXF4uFK+kjlaiZ3cIWHmQBNobrJkkvD
 RGWbbpJ4RuBVDEhpZ/nHy8YgE3LuiwMk5x1oYqs6x8hj1PXE4CGbxNL0Zi6PMArDSWkuLobl8
 eEO8oMu5/VuSIys3EjTfBuBRL62itgBWNpnZDQFpkAYkYk6m06wZJDhqIqxKDv/pt2zlvAMdm
 VcxEOoQvN5kFHgahjPPMYPc+YxjP7X5X/P6Vv0roNg8Rr11mgwfA/YpbXUR0fuZ8TOg+mC/Qp
 zoYzgDy0MPyufcuHx7taDrRuhzrzhzwQ5ahKNgHLQX8h817+xJzKnYVCb5khgT1Ia/zzP5iEF
 Lr/x+2hvrf6uZDMfFygIBXsdNb7ok4uClCyDuRpFeVghh5iJ2VhnSptiLOGIW7bQjV7CK0ZOO
 R0gzwVuuK0Bu9QSnFSdVrAd9zLnGaGrRRtakEU11Gsxd5o/btUe9oQOCsZ5fxYFnyiOCyYfIG
 dsyA9wK9YMgrl60v
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Pavel,

> > > Your above argument that the Code of Conduct is problematic because of
> > > who wrote it seems to contradict your statement that we shall judge by
> > > code (or text) alone.
> > I think there are important differences between code to be run by CPUs
> >  and a Code to be run by humans.  And when the author goes on a victory
> >  lap on Twitter and declares the Code to be "a political document", is
> >  it any surprise I'm worried?
> 
> Would you have link on that?

The CoC is a political document:
https://web.archive.org/web/20180924234027/https://twitter.com/coralineada/status/1041465346656530432

Possible victory lap 1:
https://web.archive.org/web/20180921104730/https://twitter.com/coralineada/status/1041441155874009093

Possible victory lap 2:
https://web.archive.org/web/20180920211406/https://twitter.com/coralineada/status/1042249983590838272

Note the statement in the second victory lap is wrong, it is 40,000 developers and not 40,000 projects as you can see in this commit:
https://github.com/ContributorCovenant/contributor_covenant/commit/c5ac3dfc0274b8e58e04f112aae38caaa1f2e338

> I'd really want to know who authored the
> document, because it is making statements that are untrue.

Here is the author's post-meritocracy manifesto:
https://postmeritocracy.org/

Here is the author's patreon:
https://www.patreon.com/coraline

Sincerely
Christoph Conrads

PS: Get back to work!

https://web.archive.org/web/20180925122931/https://twitter.com/CoralineAda/status/1043338366002114561
