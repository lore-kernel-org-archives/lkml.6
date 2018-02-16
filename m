Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x2273WCruunxC752GDj+uH83I+xsSTGkOSJeahyOZJyq8/bhTZYeDFMqEK5sNxNUcOF3qYJOX
ARC-Seal: i=1; a=rsa-sha256; t=1518817350; cv=none;
        d=google.com; s=arc-20160816;
        b=qemrImlYknlhQoktT3ePDnvgGWdT7QuEg65kIOD2tx0zhHK3gDPeYdB2jrXFPzj7ua
         xqmlzfsNo49Be4OSBovTIYpGvhoxgalZ8NoRFa7iIczw9Lk7CFOfHn7vY1s+elJwGVsF
         +GR6C87O7bURHr/ZqxdqPliBHgIfCcSfZWwTA1kNSkSOBZszM5l/X53uUt8L/Q4qXXEB
         ncyPBU7dbDXuWrlzjObUBN75/35m/ByB0I3Vitc04yOgcjJ9WuUVtE9QjTsDfx4Q7rCL
         tuIGG5JONVkYQRsNTSOlrfQpCFJdg4syz9U8slS2ztIHjpD1wpul/NDVLETXf4Tugt+6
         JXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=H8SfGIw0IGFYOxNg59+eUUL0yYltkloS4qpbUXfs9Nc=;
        b=kc2obEwXMiXXezYotklAORGnqZvTdPQWWII/YznMdgfedMuKMN0lkmWQKVCTSI4/+N
         AzV24hibiMCHXiY+nI/zj/oOrlChlNa5p8BqPMigv32CqETDEIUfEKRlhcIN/JZjOwbV
         OZHBgiyxyxwcYyzYTgEN2h+HSSrFQzl7jyZ7Kv8L41Rel5bb/tQlDBE90Xl9f+mPOM/d
         7EtrQAr8RyJAmHbSJJNUU4IMYJ1eoFvrQM3xj9BEz7utII71sjbLSyiFULUeOuxk8j6u
         9DKoVjW5DXXr95zSkfo1B9UzlUcSRQfNyYiGCvj+DxCjHaCJZhNrqG6rjM/y/mIgTL+R
         DTCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kbuild@vger.kernel.org
Cc: "Yann E . MORIN" <yann.morin.1998@free.fr>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <mmarek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] Kconfig: add a default allrandom.config
Date: Fri, 16 Feb 2018 22:41:13 +0100
Message-Id: <20180216214117.1947175-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180216214117.1947175-1-arnd@arndb.de>
References: <20180216214117.1947175-1-arnd@arndb.de>
X-Provags-ID: V03:K0:2DIC57SRIHN6L4/FxhZbOjyeoe3iQokjdOLws9JYYmeSPhCJjJs
 KzokFHkD0erXyUpBKYtP5suh5NwCGQLo7f2Fx5GVTwkvI2oYF6wqEMwZafGTFmbSlc8cPve
 FdV+9ZzfDRjdq6F2WPVGboEux5U2vX13eeCLIpO5AFDgxvPJQfVRAarnaa4eput5mCmDMaw
 AfDxfZ4CZNf8m7g72wp1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XZn+0LO7HE4=:Czydb2kFXksiVAWj2pPhUd
 L/V4gSeru1vxzj5jhbe5gisWB7vJ5UgD2bv7IzX1Uccb/EK00Rc5BYQ+c3tRko+IYQQAVSZXX
 frB7t4Oh4+WvwU6OXvs4FIjyWWQ/5BKUvcP1xxf7x45+n8+N641yP3b7pZrSb7xfZev7W8jTi
 r3GFI4e8HTiC8a4jdaGbvNrqp9oQoNrnyOykhx3+iwzbU9q2dUat2aGBSv1diaHzTpBj0zLu3
 X/EfUjk2tKMvjonYsqvG/gkfEMtPn0kOY/qhjS0SD2m1+KVK11pWy1i8zA6HdkUqVrExoKRmA
 RTDjLBUJEjylb9xrrRNbw2seC+5PFmJccowx2bkNPCYDbahNgLw+NRiik3ugYZRqCkcSX9vB4
 8Rjs02oiwiVoPjfSwvJxvZDSVjOJzhQ6EERyCq8uf+of8NvI8anBVTsjP3CYZRtcN9/FF16eg
 RxVMAxeYk8r98aRbXN+veHb/4wTxSJhUvNmTWZc3ds9NzHBtebDxCqoxZc48W9Ia1HEwCR41a
 f4pITNC2B4R882AzjvSBOT0mHv9HBZi+PWj2kUYjGZMgnP4Rw6PIXWjc+L+OivRGprvQ62eRl
 F1oSd53jEnAZOcr+vYXqD12yZThF8NHAelGgSP5rbTbo5501pAii/MM1CgsEdn4pt25t1VMc+
 0L8yeDYx0CXT02YrKmp0ci3+kTdIoneaDWmKW3TFkhXGFh2/FIQHKQ2TVszvGyZ8auSobaPYo
 fyNujs+ELYynePyr1NJS+DqRAs00SEnya0M0EQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595421999203989?=
X-GMAIL-MSGID: =?utf-8?q?1592595421999203989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Building randconfig kernels frequently leads to build errors from
drivers that have additional build dependencies, or that we don't
want to build for compile-testing for some other reason.

We already have a couple of compile-time options that can deal with this
problem, but the complete set is not documented well.  We also have a
method to override some options during 'make randconfig' and a couple
of other make targets. However, we don't yet combine those two.

This adds a new allrandom.config file to turn on CONFIG_COMPILE_TEST,
CONFIG_STANDALONE and CONFIG_PREVENT_FIRMWARE_BUILD for all randconfig
builds. This in turn disables some other options that we already try
to avoid in 'allmodconfig' builds and that make no sense in a general
randconfig build.

Building with 'make randconfig KCONFIG_ALLCONFIG=1' should now always
succeed without warnings on x86 and arm64, aside from recent regressions.
Other architectures probably need additional bugfixes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/configs/allrandom.config | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 kernel/configs/allrandom.config

diff --git a/kernel/configs/allrandom.config b/kernel/configs/allrandom.config
new file mode 100644
index 000000000000..67294ef2e3a2
--- /dev/null
+++ b/kernel/configs/allrandom.config
@@ -0,0 +1,6 @@
+# maximize search space, disable options not worth testing
+CONFIG_COMPILE_TEST=y
+
+# reduce compile-time dependencies
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
-- 
2.9.0
