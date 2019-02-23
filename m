Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1684FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E490E20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfBWVV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:21:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:58945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfBWVVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:21:54 -0500
Received: from [79.139.19.70] ([79.139.19.70]) by web-mail.gmx.net
 (3c-app-mailcom-bs08.server.lan [172.19.170.176]) (via HTTP); Sat, 23 Feb
 2019 22:21:53 +0100
MIME-Version: 1.0
Message-ID: <trinity-7e81cf73-8c9d-40d2-a2fb-f82baf1c35bd-1550956913386@3c-app-mailcom-bs08>
From:   "John Doe" <inquiz@gmx.com>
To:     linux-kernel@vger.kernel.org
Subject: Linux 5.0 Git performance
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 23 Feb 2019 22:21:53 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:76pVQu1LjOi9x7H3+xSrJWakbrLKVCqUBIMjFWQT4loizoKxj5Ja5/2OVR8cIPcYlMUYZ
 /eDtd/Ig3ogUhITpdRL5NUgK0DmUtsOS+WkdOcR64+GuVSD5HgntDARx8roae7y+jI6VdX6e7R8K
 TxVHAel5PiUZoeAvTOVwIJ/zcw61PI1bayim24YU2pLy3uScU3+eRVwGCSYrQVbT+LKSILYykzYt
 KBfXbEwTpIZAcQi+GNvtYXc+PRjUwrekFBXLpqAgIZi7iVkVAsORzGJoTKkUJ60v9SyaK3qmCxw1
 Nk=
X-UI-Out-Filterresults: notjunk:1;V03:K0:uy582YB8aI4=:LMkM/EfhwQ8Lbf3obmLiWH
 h2TfOFLRDm7YkMVQgbvx9f5yPs7r4MfJK0bGcfeA4/Vfhtj3paA2pIPQhwc1jVcf4a717gSpM
 Y+eDvnPkGE8aMR0rGB5DM9+delxDKBCWAOV+rEsHVHwKwzPiaXOu23HWY/QPQl6uYTdZXC7Tb
 YdW2bDI3nK8PGU7XVVeIlJyBIimxeNqx/VKehXo/CziDVrJxGbV0vVBBvUMjrYq4F49Aqbsj6
 gLkxlqFuQZphYIGAfeiXxkd7mLOpok2mv3YPLheEyY2KM+xn4U4kQTjHPhQzkvS72DG9MoEhU
 XajZaSovAaEvkofkFITgHuhBNruWIDmrX2QzXKLp1eXr0jDX74CVEJHioguTsBBLHIoQLyg8g
 C1Lb3ai1PVDe8sPmmQxlpzhZ2siEc2W5zkd/0QYqwTYzXPTksQ1guC1F990D/BzsOJXOOkI5F
 +LDmhfP6u6QAF5dxRA8dEIa3W5DgqMvCFZClM+n5/EbTwiad0Bp8azgxFd5jLZ0hy3uWknIUM
 VIRgqZAo9U3ByzT0XikvWD5JLkroEs9bsQaV2RNJxsm3fE6GaMnjLiTAMDttxm+HW0YelrN0a
 c2rbWq+n48YpY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dears,
 
The Linux 5.0 Git performance test results are alarming:
https://www.phoronix.com/vr.php?view=27563
 
Since the adoption of Linux Code of Conduct it appears that the prevailing
view is that the man's penis is not an anatomical part but a social construct !
 
John
