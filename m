Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F28D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfAVMBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:01:55 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfAVMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:01:55 -0500
Received: from orion.localdomain ([95.115.125.104]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDhV1-1gsolR0C3z-00AjCB for <linux-kernel@vger.kernel.org>; Tue, 22 Jan
 2019 13:01:54 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] .gitignore: add some missing excludes
Date:   Tue, 22 Jan 2019 13:01:53 +0100
Message-Id: <1548158513-21895-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:moez6aWrQbYN+DM/Ib9/zRSNDfYqc3SFR3U4yv9dxZLzWo3yTKR
 5rnA/NoQOp0GXouSVaLBh06fYGI6A6ZOVumzE2BsezbnF7I3flRmBD8kaXBJTDtOJ69R0l0
 KOO/ZbB3rrSHBDcB4sizU0eiZiCOEazTk5MtNmJgM58j04eLgSd66fJE9Yhr4x+C7MDGmYY
 V2O8C1yYxlk8dXd/bbnDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0SB07ANGTk=:FFVYhnfATAMTSV4NKCTw8C
 E1JXvWzkWK4cAH11oeh6BOJWJ17/EwEjknO9ENMiwn0o1TLW/INy/z2Js079sJfOO4wF+dY+7
 V/3MJ/XaLFdTQ2T02QlkSte+XdDSZKxd+NPyDa/TM7gzHW5D4UGXA1Reg0N5PZA98FeYQ6rs6
 aN1ZtiMD5g3u4/dxxPNtI5GKlv5aX8r9uXfijD/F2YUdjBl/nKAVAFtpDpQQUhayR3smttptk
 ecKSzzCHBnHTkUQbEQ25OavcEwFjMsk5FNDWQD37uzfMCNKPogL0VQFBsKtYniPrrX8stIlFe
 PP9kAwoo+JZmrCFdYlvkQkBA3jFcpaOuuadhxZLndchpPynLVj0QvLaCeX9YRce+OkB7D/5C3
 nxHKcO81sbPhLW8iG3m0DayqxHNJuSt/aWnnzK7VNGM2YzmKxx7vbLwgGGWNuKZhA9GFPhCk6
 FBxFS0IUxIWxOQm087N2XhUSKXmdzHmguqaVF56A9UzhO6SQ5DSwPWQVuKsgXvukKhJ3XXFYD
 L1KiQc+imawVfVVp9gkf+Qij8V9918r0TVsk8iL38gH1ZAsuG6GMHgqjP2P1rG1T0fx+eqSvk
 IY74pLAX01UD/6H2GKmDtHTwmCX/bm/968UZAgp089RABEYQ2SQtqcuW6yUpHmrgYtcEqAUS3
 6Z68PRLkNILEO5vmFUp50xNjFQH1a5vSQBZsSwQ+sjcC8xPQgeqWkHf9AV5HTySOUfKpom552
 C9KpiMA/EGt84u1r/ilg1iiCsJ8e8R+Zg1Esbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now they're all catched by ".*", but some folks might remove
that in order to add their own .config file.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 .gitignore                 | 6 ++++++
 scripts/kconfig/.gitignore | 1 +
 2 files changed, 7 insertions(+)

diff --git a/.gitignore b/.gitignore
index 97ba6b7..294452e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,11 +10,14 @@
 # Normal rules (sorted alphabetically)
 #
 .*
+*.cmd
+*.config.old
 *.a
 *.asn1.[ch]
 *.bin
 *.bz2
 *.c.[012]*.*
+.*.d
 *.dtb
 *.dtb.S
 *.dwo
@@ -35,12 +38,15 @@
 *.order
 *.patch
 *.s
+.scmversion
 *.so
 *.so.dbg
 *.su
 *.symtypes
+.tmp_*
 *.tab.[ch]
 *.tar
+*.version
 *.xz
 Module.symvers
 modules.builtin
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index 0aabc1d..db990ae 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -2,6 +2,7 @@
 # Generated files
 #
 *.moc
+.mconf-cfg
 
 #
 # configuration programs
-- 
1.9.1

