Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9800218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBKMDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:03:48 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:34119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:03:47 -0500
Received: from orion.localdomain ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Myb4H-1hIHOl2v4H-00yw7L; Mon, 11 Feb 2019 13:03:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     michal.lkml@markovi.net, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org
Subject: debian packaging refinements
Date:   Mon, 11 Feb 2019 13:03:33 +0100
Message-Id: <1549886616-12609-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:dx/crsG3d441XteA2EadFH2j8eGTmdlNJRW1bd2s1sTnAmzXj5X
 aCeoxxc+asgcmrrrOc7u1Zt/QE66FtzAo8+ehaF/4uIQ7mk5S9pUdfkVZvatxqNhjVR7TNF
 5P5v2ZUIRwkTBqHipxXFgj0/GwxIthEV9cgaQTupw3MePp+QmfbMJhGTMX0GqxcP2X1nDE0
 36MW64xrILsiloZVvENNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7O5PdRLNoM=:4tdL4yGiv3DfMQDhaEaJRU
 HKRyU5yjEg2staWK4quE+/3ZwwK2ES9ppUBIlobFd46zXGI/DfH8/ggrPFEuGbeR88MnmBG/s
 QQTkQs+t/qXUrHsPK/Jq/64rEsmMMr0AwNWWDIxlalnCV8TaJhL0qeH1E1hxepIy3C7/CrS+C
 kGmGpOQoHNPPFjTYxZrEd/mXrvVDBNTnPseiJINcoxrnUhBalt1rYudTu6VXwWnMc0pq3BPLA
 kMygrbUg+x8g++SQQ89mlLjlx1at1NUGP03f5121m9xevl/b0BIWIJtw/IysLtu2WBxcfIM1l
 NWDMGMK5l3PPrtOo6vUwDyyW4TEuXhSyRLKNQQSuSfyiSipez3qhoFrP6pbMckNPb+8j1DHqY
 GZZ70ZcoK1h8Acsaq5VRyyg3UzoA/qyoyP62dXksIxpEnJOjmbAJYtD2zGR2z+LfwO0lZqAp8
 20gmddRyeebCnSVEvIYUr19FaV81RjELqYLxWdSMjEKB4kYe7kXnongodrzztkhEpZtEyY7bm
 aZV0F7KILgQJNmzHHzheF6MKG0K7NDJybS+5D4kv2xkyOqO6wejRIjvu8ZkbHOnrCRdBXANQz
 YcZcqxNfFFsb3vEIrlwkbt26V0fBERxxf8ov7kB71XgNxHzevfElHX7Fsqn8NoIjZLru5zAAY
 dLUtKuWlxyKZB7wZf3Qu/Vikt604++7X1p56K7WW0QjqaHNY9UZ3mVBaQ2bMx1GFUgShgcfi9
 ybLoQjqouJBlW700CoGV18QGgLqEF++wKKp/HQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

here're some small patches for making mkdebian a bit more flexible, so it
can be used eg. with an given debian/rules file.

I'm using this along w/ local (adding debian/rules and .config) in order
to build the kernel via usual debian toolchains (git-buildpackage,
git-buildpackage, ...) in a canonical way.

Didn't post the patch for debian/rules yet, as it's likely not suited for
mainline yet. (I can post it, if you wish).


--mtx

