Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F6E2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 15:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeL2P62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 10:58:28 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:32998 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbeL2P62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 10:58:28 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBTFwIwf012692;
        Sat, 29 Dec 2018 16:58:18 +0100
From:   Willy Tarreau <w@1wt.eu>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/3] rcutorture: minor nolibc fixes
Date:   Sat, 29 Dec 2018 16:58:14 +0100
Message-Id: <20181229155817.12647-1-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on adding some documentation to the nolibc header provided
with rcutorture, I noticed a few accidently deleted lines losing clobbered
registers and some leftover spaces that I fixed. In addition, I finally
added some documentation to the file, as requested by Ingo.

Willy Tarreau (3):
  rcutorture/nolibc: fix the clobbered registers in the MIPS syscall
    definition
  rcutorture/nolibc: fix some poor indentation and alignment
  rcutorture/nolibc: add a bit of documentation to explain how to use
    nolibc

 tools/testing/selftests/rcutorture/bin/nolibc.h | 116 +++++++++++++++++++-----
 1 file changed, 91 insertions(+), 25 deletions(-)

-- 
2.9.0

