Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3723CC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1077A21907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBHDKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 22:10:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:58961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfBHDKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 22:10:06 -0500
Received: from homer.simpson.net ([185.221.151.12]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqV4f-1hMrSQ1Fcf-00e33d; Fri, 08
 Feb 2019 04:09:59 +0100
Message-ID: <1549595398.26710.14.camel@gmx.de>
Subject: Re: Kernel panics with recent 4.9 Kernels
From:   Mike Galbraith <efault@gmx.de>
To:     Michael Brunnbauer <brunni@netestate.de>,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 04:09:58 +0100
In-Reply-To: <20190207191359.GA14298@netestate.de>
References: <20190205091239.GA3687@netestate.de>
         <20190207191359.GA14298@netestate.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gmJzOzW+ie9PPH5Y9PbesqxZ4zCBgQkaxiM+sF0nmMzgBEESUfC
 QnpP3vVTVBzgFdc8mJdcivencZEToFjKt0Yb2t4H0RuMCt02QMWFiSaG9Os/9NxMmvZyKan
 LBCGmIuuqKQDUCu984Swby2zTPXix6IH7NK/zHIsYZ37G8F9UezqxyF6N1m+FYCSPYpKsdv
 +JMBWfseA4i2oPgxtZQTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fW/t38JTaWM=:lAdsJHlZlfxidg9A6ifGVT
 8TDcgpqBbOFUhRot5hKGtbbM5Is+zBlV79GJaF9yWzcv47TDqXVtON/2gG4t7mbCu4t/hEYcS
 uKnGML7YfoP9oqNtm3MHiWeG8iJsgnleKbBqznfByX//xbVnRi4rxP0pgiKNEusbGcwEHklhx
 nW+hep8Bst/5mmifPF7Tq9uxFLht++yY5DTyNGxCd3czszsqHm2Ktf1DoctIn3KLm2MeE9ora
 2MPB9GKc+cY6u7pY0iOGA3s9kRWoCscLYhbZy+gIx/YAlJwD0ohjPWAtqT1EOFpv12moIDUI4
 Ui1/Ph6tKCUhQAbqEEDZPDvC8J21D38Ql9n0UaTKmzHtpBnJJ/C00VfMJz/NWqjMNY50TmBjy
 nFCFXZbKZf//iBDBX+VI862SehxMhVWuAu24vGYredYlBAuTSh9tbcr1EDGoKU1mUPy5nYX9M
 mC7z7i8m4FvexYkzQpW0u0ho89R314CReMteVZFquyLXTXx/PrzFjHZorJvwrAyKtPNWKRh7O
 Ir8EOo/pZsNzrkWYr33UQgJsc+EL6JlcZLzFb36TYc8MAzOdby0cSXps+ptlX1r/LMSeVgIp2
 hbwGxakH6MuiUEUxxf2NjFSYQDyjZJfr1Os/VsJgqGWcox2y0yjVae6t0dYypzQQ0d1Fg1wB2
 0rzMu8GLi/YxR5bneq2txn37fWdHqpl/087BlQUS20STt4GToE6VEeNDVUWjaV1w5WC5FWLbY
 fjLxlCaPCcmsQrnpWklz8YJ0DyYeV5XDySGxyPxUTOGzJK4GD61Lr26rVWJnZ8vlv38A1PdIa
 kt7dfkHsBObZO671GBt8ykjAVvPjyRnWqKhRIfUlg7lG/qqyNGwNllWVxUJIOCdxyzYa/T2sU
 yQ8g28MeSf7rYcd3Vef/Uq3+1xore+tXsJoqdbL8Ntfv/jpMgEiCR9jluIgkrt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 20:13 +0100, Michael Brunnbauer wrote:
> hi,
> 
> no replies to my mail. Any suggestions what I should do or where I
> could ask for help?

I'd suggest trying to capture events with something better than an
incomplete screenshot, ie serial console, netconsole, anything that
will let you show the full event and a few lines leading up to it.

	-Mike
