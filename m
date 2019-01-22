Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F08C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C722F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548180651;
	bh=OI2DY08+W1kUzppo9fCoVKy7uYTCFwCHeoK2bkVsI7Q=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=FSWQDdQlY7XqALkOpWjbfKQUcpkqoUtuY+QemxHzBy57FxHf55YsaGtnjf0uNfdNv
	 Y7NwnLifKakvJIpHoYa20cadiKqij2oQM4qtsRxhLjNYvRRTIbgrPmzXiWbzVhvxkZ
	 hhn3Utp4WZr2bklNCxkurC4mPwNv1O26Ynyh2vZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfAVSKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfAVSKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:10:49 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1909A21019;
        Tue, 22 Jan 2019 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548180648;
        bh=OI2DY08+W1kUzppo9fCoVKy7uYTCFwCHeoK2bkVsI7Q=;
        h=To:Cc:From:Subject:Date:From;
        b=rOJlMDMejl9/TMxSEkY1s8cGzjMIYYIm5krolZF4s2gVbU6RF4eil/wUQFQorYhsm
         OXvnS5aXfqmbk6MZMuwJPGfqbIh84JnUGyO9qfFsHQIPxDgfyVWgWsRBrGgSL99fby
         C9yumVXlRT8a533I2JCuT4ukAjkiP3RCpwRSx34k=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
From:   shuah <shuah@kernel.org>
Subject: {GIT PULL] Kselftest update for Linux 5.0-rc4
Message-ID: <8e4a8f43-c135-1ac6-8ca1-5bc75f02d787@kernel.org>
Date:   Tue, 22 Jan 2019 11:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------02C8BC1EBF4B8E0FFD88A09E"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------02C8BC1EBF4B8E0FFD88A09E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.0-rc4

This Kselftest update for Linux 5.0-rc4 consists of fixes to rtc,
seccomp and other tests.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.0-rc4

for you to fetch changes up to 3d244c192afeee7dd4f5fb1b916ea4e47420d401:

   selftests/seccomp: Abort without user notification support 
(2019-01-17 11:00:23 -0700)

----------------------------------------------------------------
linux-kselftest-5.0-rc4

This Kselftest update for Linux 5.0-rc4 consists of fixes to rtc, seccomp
and other tests.

----------------------------------------------------------------
Alexandre Belloni (2):
       selftests: rtc: rtctest: fix alarm tests
       selftests: rtc: rtctest: add alarm test on minute boundary

Alison Schofield (1):
       selftests/vm/gup_benchmark.c: match gup struct to kernel

Colin Ian King (1):
       x86/mpx/selftests: fix spelling mistake "succeded" -> "succeeded"

Fathi Boudra (1):
       selftests: seccomp: use LDLIBS instead of LDFLAGS

Geert Uytterhoeven (1):
       selftests: gpio-mockup-chardev: Check asprintf() for error

Kees Cook (1):
       selftests/seccomp: Abort without user notification support

Sabyasachi Gupta (1):
       tools/testing/selftests/x86/unwind_vdso.c: Remove duplicate header

  tools/testing/selftests/gpio/gpio-mockup-chardev.c |   9 +-
  tools/testing/selftests/rtc/rtctest.c              | 109 
++++++++++++++++++++-
  tools/testing/selftests/seccomp/Makefile           |   2 +-
  tools/testing/selftests/seccomp/seccomp_bpf.c      |  10 +-
  tools/testing/selftests/vm/gup_benchmark.c         |   1 +
  tools/testing/selftests/x86/mpx-mini-test.c        |   2 +-
  tools/testing/selftests/x86/unwind_vdso.c          |   1 -
  7 files changed, 118 insertions(+), 16 deletions(-)

----------------------------------------------------------------

--------------02C8BC1EBF4B8E0FFD88A09E
Content-Type: text/x-patch;
 name="linux-kselftest-5.0-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.0-rc4.diff"

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index f8d468f54e98..aaa1e9f083c3 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -37,7 +37,7 @@ static int get_debugfs(char **path)
 	struct libmnt_table *tb;
 	struct libmnt_iter *itr = NULL;
 	struct libmnt_fs *fs;
-	int found = 0;
+	int found = 0, ret;
 
 	cxt = mnt_new_context();
 	if (!cxt)
@@ -58,8 +58,11 @@ static int get_debugfs(char **path)
 			break;
 		}
 	}
-	if (found)
-		asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+	if (found) {
+		ret = asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
+		if (ret < 0)
+			err(EXIT_FAILURE, "failed to format string");
+	}
 
 	mnt_free_iter(itr);
 	mnt_free_context(cxt);
diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index e20b017e7073..b2065536d407 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -145,15 +145,12 @@ TEST_F(rtc, alarm_alm_set) {
 
 	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
 	ASSERT_NE(-1, rc);
-	EXPECT_NE(0, rc);
+	ASSERT_NE(0, rc);
 
 	/* Disable alarm interrupts */
 	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
 	ASSERT_NE(-1, rc);
 
-	if (rc == 0)
-		return;
-
 	rc = read(self->fd, &data, sizeof(unsigned long));
 	ASSERT_NE(-1, rc);
 	TH_LOG("data: %lx", data);
@@ -202,7 +199,109 @@ TEST_F(rtc, alarm_wkalm_set) {
 
 	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
 	ASSERT_NE(-1, rc);
-	EXPECT_NE(0, rc);
+	ASSERT_NE(0, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
+TEST_F(rtc, alarm_alm_set_minute) {
+	struct timeval tv = { .tv_sec = 62 };
+	unsigned long data;
+	struct rtc_time tm;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&tm) + 60 - tm.tm_sec;
+	gmtime_r(&secs, (struct tm *)&tm);
+
+	rc = ioctl(self->fd, RTC_ALM_SET, &tm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_ALM_READ, &tm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d:%02d:%02d.",
+	       tm.tm_hour, tm.tm_min, tm.tm_sec);
+
+	/* Enable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_ON, 0);
+	ASSERT_NE(-1, rc);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	ASSERT_NE(0, rc);
+
+	/* Disable alarm interrupts */
+	rc = ioctl(self->fd, RTC_AIE_OFF, 0);
+	ASSERT_NE(-1, rc);
+
+	rc = read(self->fd, &data, sizeof(unsigned long));
+	ASSERT_NE(-1, rc);
+	TH_LOG("data: %lx", data);
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &tm);
+	ASSERT_NE(-1, rc);
+
+	new = timegm((struct tm *)&tm);
+	ASSERT_EQ(new, secs);
+}
+
+TEST_F(rtc, alarm_wkalm_set_minute) {
+	struct timeval tv = { .tv_sec = 62 };
+	struct rtc_wkalrm alarm = { 0 };
+	struct rtc_time tm;
+	unsigned long data;
+	fd_set readfds;
+	time_t secs, new;
+	int rc;
+
+	rc = ioctl(self->fd, RTC_RD_TIME, &alarm.time);
+	ASSERT_NE(-1, rc);
+
+	secs = timegm((struct tm *)&alarm.time) + 60 - alarm.time.tm_sec;
+	gmtime_r(&secs, (struct tm *)&alarm.time);
+
+	alarm.enabled = 1;
+
+	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
+	if (rc == -1) {
+		ASSERT_EQ(EINVAL, errno);
+		TH_LOG("skip alarms are not supported.");
+		return;
+	}
+
+	rc = ioctl(self->fd, RTC_WKALM_RD, &alarm);
+	ASSERT_NE(-1, rc);
+
+	TH_LOG("Alarm time now set to %02d/%02d/%02d %02d:%02d:%02d.",
+	       alarm.time.tm_mday, alarm.time.tm_mon + 1,
+	       alarm.time.tm_year + 1900, alarm.time.tm_hour,
+	       alarm.time.tm_min, alarm.time.tm_sec);
+
+	FD_ZERO(&readfds);
+	FD_SET(self->fd, &readfds);
+
+	rc = select(self->fd + 1, &readfds, NULL, NULL, &tv);
+	ASSERT_NE(-1, rc);
+	ASSERT_NE(0, rc);
 
 	rc = read(self->fd, &data, sizeof(unsigned long));
 	ASSERT_NE(-1, rc);
diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index fce7f4ce0692..1760b3e39730 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -9,7 +9,7 @@ BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
 
 seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) -lpthread $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
 
 TEST_PROGS += $(BINARIES)
 EXTRA_CLEAN := $(BINARIES)
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 067cb4607d6c..496a9a8c773a 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3044,7 +3044,7 @@ TEST(user_notification_basic)
 	/* Check that the basic notification machinery works */
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	/* Installing a second listener in the chain should EBUSY */
 	EXPECT_EQ(user_trap_syscall(__NR_getpid,
@@ -3103,7 +3103,7 @@ TEST(user_notification_kill_in_middle)
 
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	/*
 	 * Check that nothing bad happens when we kill the task in the middle
@@ -3152,7 +3152,7 @@ TEST(user_notification_signal)
 
 	listener = user_trap_syscall(__NR_gettid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -3215,7 +3215,7 @@ TEST(user_notification_closed_listener)
 
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	/*
 	 * Check that we get an ENOSYS when the listener is closed.
@@ -3376,7 +3376,7 @@ TEST(seccomp_get_notif_sizes)
 {
 	struct seccomp_notif_sizes sizes;
 
-	EXPECT_EQ(seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes), 0);
+	ASSERT_EQ(seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes), 0);
 	EXPECT_EQ(sizes.seccomp_notif, sizeof(struct seccomp_notif));
 	EXPECT_EQ(sizes.seccomp_notif_resp, sizeof(struct seccomp_notif_resp));
 }
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 880b96fc80d4..c0534e298b51 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -25,6 +25,7 @@ struct gup_benchmark {
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
+	__u64 expansion[10];	/* For future use */
 };
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index 50f7e9272481..bf1bb15b6fbe 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -1503,7 +1503,7 @@ void check_mpx_insns_and_tables(void)
 		exit(20);
 	}
 	if (successes != total_nr_tests) {
-		eprintf("ERROR: succeded fewer than number of tries (%d != %d)\n",
+		eprintf("ERROR: succeeded fewer than number of tries (%d != %d)\n",
 				successes, total_nr_tests);
 		exit(21);
 	}
diff --git a/tools/testing/selftests/x86/unwind_vdso.c b/tools/testing/selftests/x86/unwind_vdso.c
index 00a26a82fa98..97311333700e 100644
--- a/tools/testing/selftests/x86/unwind_vdso.c
+++ b/tools/testing/selftests/x86/unwind_vdso.c
@@ -44,7 +44,6 @@ int main()
 #include <stdbool.h>
 #include <sys/ptrace.h>
 #include <sys/user.h>
-#include <sys/ucontext.h>
 #include <link.h>
 #include <sys/auxv.h>
 #include <dlfcn.h>

--------------02C8BC1EBF4B8E0FFD88A09E--
