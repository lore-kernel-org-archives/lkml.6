Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B69720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544733431;
	bh=8c2ewI4m1UpjXDs6ALVCJMxPUGD6WU0xMzqt3Owo1Co=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=e8xl+zm0zY0sbkZM83GRFdP2SfKwpjiQWXSkgDdRHUjebexkoJJOqAowB7GItOiMp
	 +F4WfTwWiblx7EQZBF6f9K1SN9AUKTb/R1KcLybMLR7yhCOoLu0hq9+fRfVjels+EI
	 /9ApOg6sxPL2ScP+bZ2eiL+1LATPqva0V06NAi0w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B69720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeLMUhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeLMUhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:37:09 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF5420811;
        Thu, 13 Dec 2018 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544733429;
        bh=8c2ewI4m1UpjXDs6ALVCJMxPUGD6WU0xMzqt3Owo1Co=;
        h=To:Cc:From:Subject:Date:From;
        b=rySwCQd5qO29k0SLsSd7DTat3l1Mme8cr2qaLIRnvRlWemHJD0SejjviOeL+iJaI5
         F1PU9G1ePHhHoohETwEJ/f07EmMj3/zElkLhaYe7IIpSkrot6R2s7/HgLX0uA3E0Ne
         0vSTtQOjaSlRO6LVpYWA/8i5t0VXUwo5ACTOEo+A=
To:     torvalds@linux-foundation.org
Cc:     shuah <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   shuah <shuah@kernel.org>
Subject: [GIT PULL] kselftest update for Linux 4.20-rc7
Message-ID: <fe1c6815-c338-e264-cd77-7d92457acf4c@kernel.org>
Date:   Thu, 13 Dec 2018 13:37:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1259D9FF892B7FB3DD3316FA"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1259D9FF892B7FB3DD3316FA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 4.20-rc7.

This Kselftest update for Linux 4.20-rc7 consists of a single fix for
seccomp test from Kees Cook.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-4.20-rc7

for you to fetch changes up to 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13:

   selftests/seccomp: Remove SIGSTOP si_pid check (2018-12-11 17:57:30 
-0700)

----------------------------------------------------------------
linux-kselftest-4.20-rc7

This Kselftest update for Linux 4.20-rc7 consists of a single fix for
seccomp test from Kees Cook.

----------------------------------------------------------------
Kees Cook (1):
       selftests/seccomp: Remove SIGSTOP si_pid check

  tools/testing/selftests/seccomp/seccomp_bpf.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)
----------------------------------------------------------------

--------------1259D9FF892B7FB3DD3316FA
Content-Type: text/x-patch;
 name="linux-kselftest-4.20-rc7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-4.20-rc7.diff"

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index e1473234968d..c9a2abf8be1b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2731,9 +2731,14 @@ TEST(syscall_restart)
 	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
 	ASSERT_EQ(true, WIFSTOPPED(status));
 	ASSERT_EQ(SIGSTOP, WSTOPSIG(status));
-	/* Verify signal delivery came from parent now. */
 	ASSERT_EQ(0, ptrace(PTRACE_GETSIGINFO, child_pid, NULL, &info));
-	EXPECT_EQ(getpid(), info.si_pid);
+	/*
+	 * There is no siginfo on SIGSTOP any more, so we can't verify
+	 * signal delivery came from parent now (getpid() == info.si_pid).
+	 * https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
+	 * At least verify the SIGSTOP via PTRACE_GETSIGINFO.
+	 */
+	EXPECT_EQ(SIGSTOP, info.si_signo);
 
 	/* Restart nanosleep with SIGCONT, which triggers restart_syscall. */
 	ASSERT_EQ(0, kill(child_pid, SIGCONT));

--------------1259D9FF892B7FB3DD3316FA--
