Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937648AbeE1KoM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937443AbeE1KoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 066/496] selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=m
Date: Mon, 28 May 2018 11:57:31 +0200
Message-Id: <20180528100322.576713645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naresh Kamboju <naresh.kamboju@linaro.org>

[ Upstream commit 9a379e77033f02c4a071891afdf0f0a01eff8ccb ]

pstore_tests and pstore_post_reboot_tests need CONFIG_PSTORE_RAM=m

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/pstore/config |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/pstore/config
+++ b/tools/testing/selftests/pstore/config
@@ -2,3 +2,4 @@ CONFIG_MISC_FILESYSTEMS=y
 CONFIG_PSTORE=y
 CONFIG_PSTORE_PMSG=y
 CONFIG_PSTORE_CONSOLE=y
+CONFIG_PSTORE_RAM=m
