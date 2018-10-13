Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06046C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB48120835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB48120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJMQgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:36:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:59585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeJMQgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:36:17 -0400
Received: from localhost.localdomain ([79.203.67.175]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7UUd-1fQ94M3wfP-00xNPG; Sat, 13 Oct 2018 10:59:50 +0200
Received: from localhost.localdomain ([79.203.67.175]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7UUd-1fQ94M3wfP-00xNPG; Sat, 13 Oct 2018 10:59:50 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 9AE3380097; Sat, 13 Oct 2018 10:59:47 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.123
References: <20181013085007.GA1293@kroah.com>
Date:   Sat, 13 Oct 2018 10:59:47 +0200
In-Reply-To: <20181013085007.GA1293@kroah.com> (Greg KH's message of "Sat, 13
        Oct 2018 10:50:07 +0200")
Message-ID: <871s8uw7b0.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:MRD3fJp8OQsYVYFs7PNEByn1RA8FhnYc79G2cxC9INcmSbLRmZr
 aZ83O7OiUg+B0rlB4PJbAAijiVjVVGzw2wsE6fVzffvyOXDFLurSA88t9N0VBrYU3YJecao
 2kIqWFgMgU3EmJuyDlUB1hvXs4QyQRcJ0qX2y+AMFUtC2oDgtc3iweWprtl3umrewaaFaOg
 r29TQASc5Dn6Gim68RheQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yw5AzGqTS70=:xnlKgDwiMzmEWx0SIUGBAX
 ycQzYzb1Iv8Fw5c5+1y5m/afttKCf5cXZNYSExh+DibJLiUmtrnOYfw/ZtEd71wfQfya67S7j
 jP+7WTpb96TCMagRRL1s0vss7HLegINtXRJLh+WrRKDj0gpLX4yyc0somUEIlcSIgrf3R33dz
 lTEReJZvIr2fdNxIwDByecg7qLOsmLzxaUi2gQduxc/eo/2hnKB96Kf9klrnIwdm03GoHnOgF
 rZYi/by0C9DyUW60wDxSAMGCon2c0U6kSS7DNiFWtZ7duSNi2VELaDww//ZEMg5aB5kH8NaRQ
 AYhj9rKb5AOuKbYZTt/sPu6YHBFtI1VqKaDITqx3hSA0ORRmbgH71gJslbWB0Y6PWCU1xmo7i
 pLVwBvgU8DyozX3XbiVNkX0v72/MgVjPyU3U6gReu4mX5957AO2cJEezMKvVuEcwiN6QNYPq5
 Bqz6UPdkbeoq2SKDWAqAZEEuaAH7o5fn7AJBEnnvBqB7WSn5u+pUMdzlHQ0RcH9NoaXPMJ2Bg
 Bd+o8ahjylOGwGU0BHHuU5E4IPcxx0uovwubPv/V8NqicO6wKMR0BjqLd8p7kc6fjLYuIMqbp
 X+8gwYB/H6ly4ScpDrTtSh5QUDAWaXm+XkgovBhzV+KS7dTYz8WgxCW4FZ0gerjh4nPudYCG5
 C0+jgP+PotCV1AFwsypwzFEp939CGRv5mHxehTjHjI68rCR+4VppTh0mdZLrfnUiilr9H0h+T
 POzkWO0UGGFmLi/5Jzk0rFCdlMyADmzXvhUah7lCSV6EAILZSFEnhF7KzEeVU5l1hAQXovVNw
 2k4hr9FQqQcNs4MiOZSDjHXYOcrGCJXr30iYSG4vw6CKrofnf0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-13 10:50 +0200, Greg KH wrote:

> I'm announcing the release of the 3.18.124 kernel.

$Subject inadvertently says 3.18.123, something wrong with your scripts?

Cheers,
       Sven
