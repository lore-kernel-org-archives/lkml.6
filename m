Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D1CC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C553121019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 04:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeLaEQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 23:16:26 -0500
Received: from namei.org ([65.99.196.166]:53796 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeLaEQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 23:16:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id wBV4GPUw001788;
        Mon, 31 Dec 2018 04:16:25 GMT
Date:   Mon, 31 Dec 2018 15:16:25 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: Smack changes for v4.21
Message-ID: <alpine.LRH.2.21.1812311515150.1435@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-996557093-1546229750=:1435"
Content-ID: <alpine.LRH.2.21.1812311516100.1435@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-996557093-1546229750=:1435
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.1812311516101.1435@namei.org>

From Casey:

"I have two Smack patches for 4.21. One Jose's patch adds
missing documentation and Zoran's fleshes out the access checks
on keyrings."

The following changes since commit 1072bd678547f8663cfb81a22fdb50c589e4976e:

  security: fs: make inode explicitly non-modular (2018-12-12 14:58:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-smack

for you to fetch changes up to 20bb4cb4fb9fb994d757932abc4404cf0f0f56cc:

  Merge branch 'smack-for-4.21-a' of https://github.com/cschaufler/next-smack into next-smack (2018-12-13 19:30:33 -0800)

----------------------------------------------------------------
James Morris (1):
      Merge branch 'smack-for-4.21-a' of https://github.com/cschaufler/next-smack into next-smack

José Bollo (1):
      Smack: Improve Documentation

Zoran Markovic (1):
      smack: fix access permissions for keyring

 Documentation/admin-guide/LSM/Smack.rst |  4 ++++
 security/smack/smack_lsm.c              | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)
--1665246916-996557093-1546229750=:1435--
