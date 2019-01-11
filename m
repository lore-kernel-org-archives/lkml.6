Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A9C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfAKG1y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:27:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:32931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfAKG1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:27:53 -0500
Received: from frank-bq ([91.14.68.96]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lj1jy-1hGd9L0tNW-00dGCP; Fri, 11
 Jan 2019 07:27:45 +0100
Date:   Fri, 11 Jan 2019 07:27:40 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <685063fd-a1c2-954a-db1e-b1339ad90e15@gmail.com>
References: <20190111144818.0fe8bde2@canb.auug.org.au> <685063fd-a1c2-954a-db1e-b1339ad90e15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: linux-next: Signed-off-by missing for commit in the net tree
Reply-to: frank-w@public-files.de
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <6892B6C2-5432-41BD-AAD2-28C8D7233273@public-files.de>
X-Provags-ID: V03:K1:70q7tXRiBYeh+HxmlfzIhQmck/MDskJTyzhNykfKzhki1NSIEMx
 9LNNl/608JgQHtF/HmBLuMlCoP4PxYpZ+F7rzFXhC1a/r/xCDKTsOrOHxlscYPTRQXzHHpb
 HlSHVKunfa4/dfEHwlSEjjjekv8rpQLpyP4QFczGP2UonXYmyCITjYl1lJRRl9KJVXr+PEB
 5+81UyiUtaigOrWgyz7wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gmoOoBUCX/I=:F2fR771sjubIG7dTPXf7la
 YPp9F4tD5QGA5wHpNANcba9EwqFppNgQlOGikkc7jQKEOXwssAC4Rc1v+qR9Gt9SwDcumNgE3
 5eac3sbjnFCXLeBqxV7Yuor0BmRLpIw+0JnkTCoSVXcbH8fSvhO5+0vSVp8ufn1vYiB+9oNTX
 J1RaO9fgLTZsAvRDQh9uoXEZXUN2ifz0k9bJei9yhKw3FN1G+m9yJ2PIJ1m4aZX3EdcQKE7To
 jD/WNbKDe36aaWuZeLxOnpDU37onigrHz8PnMyTehajdXB3EwEtujua6fQqJxnwfGhv/Zi3h3
 R3s5PEsSFhzf+qLPWzUmYb+SN4BNN+FtCfRgpkEZ2oHEvGkcxkGBPElo/KlRSCfOsfZYLkTWk
 a9SBNSwWd/C9RFPzlFjfbh7z4GqeQgRTW2rdVG56SdFkFtXp7VGz7peMdPx8/rcy/vJx891NA
 xB+q6xJs8QRdlMDWPmp2Ksxkda8AR0R3IzusoB0IXW443x2HJt2ClwL739nBBR/TkPtd40FRb
 zLIWYJ3eXIuS7SMhMF8pFKkP4pb15GRZtGkgSSegUoGi9CZi00jBxJ+p6zUjT7abfA63uXup5
 rHuCpKw6AMWorxFhjYX5U2fM1PCYFfLQH4W2vKc7OB98t3f+/UptyNbI7i4mAGXfRYzx9IZhs
 piIJSvVG2sYyL0AK7y6ZEnKmY8UZo8J4OZPlKxY5+cN4/c2OV4wnxLiYWD7LSHkWj1P4NPc89
 aeNrvm/PaTt1ggXAe0qSg58y/tblVYOwuo+0iLHCHh4jeFeh0lDgbDylCrEpu+ntcAaX5iutq
 ahRN8dVtKaCNQGGFmgeGg/jIRfs4NuI0GaAIyNjkLpNsrrhR7oWt/X4cQgATeN9habHaOcr41
 cq7VfRFCmljk/GhtdG0tl+QleZzXwOuNyk0+XMgn5ZygOFd2DnH9p8m3lV2w2ldRpYmZ+Fdfw
 XHDXDuRonmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should i make v3 with all tags or me as author?

Regards Frank
