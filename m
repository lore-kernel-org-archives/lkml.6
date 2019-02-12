Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7524DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3616C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfBLOlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:41:36 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:38399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:41:36 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8QBa-1gxwxj3E80-004VsU; Tue, 12 Feb 2019 15:41:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: change linux-4.x references to 5.x
Date:   Tue, 12 Feb 2019 15:41:01 +0100
Message-Id: <20190212144126.18487-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tk0w5l7Ubt8+ZUP/168LKRK/vEugGWzP6ICFUZte1fOrmHN7r16
 HWKqflstXzE4IAbqtiC02GxdaqKWVVVR2Gq+wuuZIvl+IRTjU7l+aMuemtzGXTBT3WLd0lA
 bJ0Z0RhgkpK5QpfYGGL8a9KD5o35FBPgO0d/tm4M4uWxCZ8yzWvZpcIMzmq5zqexRsJb+Y8
 0iQYzt61nthQXCjF33F+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vBbULCsPxF0=:Zw+t8pFBxSczIoNK5S32fL
 zk7sMmzKYRT86lsGk1dU3j8M42XLf8FDJ7fbLXkHmrSZMKh1K/3BYRtuQKKwsnkh6F2/ngsTk
 INfA+XCgkA5iUUjXjVN9UOuNGR8EfwZeprvz18yBHHtpU6cdY0z1kgthYIuf3rozvLErd8h8f
 P0KBn9IoGIznWk4aDPHYUN5e6mm2ymQh97Y+9U6gvLnDwJEMbY0HGlX6kWOQeGjBdQ0nJDYvh
 VtK2jzyVpFW0icOkENP3gHTFL9Xd3bbeLoqIoBsQP7/oJNIt12/GGztxaEzXsa3SBkieb0njB
 LzgPXrNL5YrVHON9bkJDtl9cgCH2xehHbliCKEREbdawNyzkjMxi4ztWPbrRqC41c1Rl/TR0m
 8SkUy2WiCCm9whcllQWSfIxINRcVVC2ahzoWSR0CamS7Fa89Qc3CfDOj08C6OUFeY5FjYnEgi
 ud4Wra+OJ9fnYW4Voapy6tstd6Ej0z6OiQLAMslF3nTlF7g8KI28RFndvoTxxK/zBzmRgqHC9
 oxJEsQNzLvSp8uKi+uNc0w+7ZmMeXbyIkJNWhz/yK0Ke/TrQC2O57VknrtJ6IITXOv74XGCCH
 GJI/aPVKm7fM5byZ88wsZq0g/Rj9neT2Pe3itL6YKeNy3qgQ7/dJUYsnzX4bAj9Jl5ZH+ZKgo
 fwfPzLcKrfC15SwVADNjGk8JF0f9SeeOuFgR6NqV5JX9MowTi9RUpLVUKvIEZ9MtYuEdmlqH0
 APcg3Jq//HRrC1/T4096AlF0kVbOaBvW2wYC3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As linux-5.0.x is coming up soon, the documentation should match,
in particular the README.rst file, so change all 4.x references
accordingly. There was a mix of lowercase and uppercase X here,
which I changed to using lowercase consistently.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/admin-guide/README.rst          |  32 ++---
 Documentation/process/applying-patches.rst    | 117 +++++++++---------
 .../translations/it_IT/admin-guide/README.rst |   2 +-
 3 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 0797eec76be1..47e577264198 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -1,9 +1,9 @@
 .. _readme:
 
-Linux kernel release 4.x <http://kernel.org/>
+Linux kernel release 5.x <http://kernel.org/>
 =============================================
 
-These are the release notes for Linux version 4.  Read them carefully,
+These are the release notes for Linux version 5.  Read them carefully,
 as they tell you what this is all about, explain how to install the
 kernel, and what to do if something goes wrong.
 
@@ -63,7 +63,7 @@ Installing the kernel source
    directory where you have permissions (e.g. your home directory) and
    unpack it::
 
-     xz -cd linux-4.X.tar.xz | tar xvf -
+     xz -cd linux-5.x.tar.xz | tar xvf -
 
    Replace "X" with the version number of the latest kernel.
 
@@ -72,26 +72,26 @@ Installing the kernel source
    files.  They should match the library, and not get messed up by
    whatever the kernel-du-jour happens to be.
 
- - You can also upgrade between 4.x releases by patching.  Patches are
+ - You can also upgrade between 5.x releases by patching.  Patches are
    distributed in the xz format.  To install by patching, get all the
    newer patch files, enter the top level directory of the kernel source
-   (linux-4.X) and execute::
+   (linux-5.x) and execute::
 
-     xz -cd ../patch-4.x.xz | patch -p1
+     xz -cd ../patch-5.x.xz | patch -p1
 
-   Replace "x" for all versions bigger than the version "X" of your current
+   Replace "x" for all versions bigger than the version "x" of your current
    source tree, **in_order**, and you should be ok.  You may want to remove
    the backup files (some-file-name~ or some-file-name.orig), and make sure
    that there are no failed patches (some-file-name# or some-file-name.rej).
    If there are, either you or I have made a mistake.
 
-   Unlike patches for the 4.x kernels, patches for the 4.x.y kernels
+   Unlike patches for the 5.x kernels, patches for the 5.x.y kernels
    (also known as the -stable kernels) are not incremental but instead apply
-   directly to the base 4.x kernel.  For example, if your base kernel is 4.0
-   and you want to apply the 4.0.3 patch, you must not first apply the 4.0.1
-   and 4.0.2 patches. Similarly, if you are running kernel version 4.0.2 and
-   want to jump to 4.0.3, you must first reverse the 4.0.2 patch (that is,
-   patch -R) **before** applying the 4.0.3 patch. You can read more on this in
+   directly to the base 5.x kernel.  For example, if your base kernel is 5.0
+   and you want to apply the 5.0.3 patch, you must not first apply the 5.0.1
+   and 5.0.2 patches. Similarly, if you are running kernel version 5.0.2 and
+   want to jump to 5.0.3, you must first reverse the 5.0.2 patch (that is,
+   patch -R) **before** applying the 5.0.3 patch. You can read more on this in
    :ref:`Documentation/process/applying-patches.rst <applying_patches>`.
 
    Alternatively, the script patch-kernel can be used to automate this
@@ -114,7 +114,7 @@ Installing the kernel source
 Software requirements
 ---------------------
 
-   Compiling and running the 4.x kernels requires up-to-date
+   Compiling and running the 5.x kernels requires up-to-date
    versions of various software packages.  Consult
    :ref:`Documentation/process/changes.rst <changes>` for the minimum version numbers
    required and how to get updates for these packages.  Beware that using
@@ -132,12 +132,12 @@ Build directory for the kernel
    place for the output files (including .config).
    Example::
 
-     kernel source code: /usr/src/linux-4.X
+     kernel source code: /usr/src/linux-5.x
      build directory:    /home/name/build/kernel
 
    To configure and build the kernel, use::
 
-     cd /usr/src/linux-4.X
+     cd /usr/src/linux-5.x
      make O=/home/name/build/kernel menuconfig
      make O=/home/name/build/kernel
      sudo make O=/home/name/build/kernel modules_install install
diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
index dc2ddc345044..fbb9297e6360 100644
--- a/Documentation/process/applying-patches.rst
+++ b/Documentation/process/applying-patches.rst
@@ -216,14 +216,14 @@ You can use the ``interdiff`` program (http://cyberelk.net/tim/patchutils/) to
 generate a patch representing the differences between two patches and then
 apply the result.
 
-This will let you move from something like 4.7.2 to 4.7.3 in a single
+This will let you move from something like 5.7.2 to 5.7.3 in a single
 step. The -z flag to interdiff will even let you feed it patches in gzip or
 bzip2 compressed form directly without the use of zcat or bzcat or manual
 decompression.
 
-Here's how you'd go from 4.7.2 to 4.7.3 in a single step::
+Here's how you'd go from 5.7.2 to 5.7.3 in a single step::
 
-	interdiff -z ../patch-4.7.2.gz ../patch-4.7.3.gz | patch -p1
+	interdiff -z ../patch-5.7.2.gz ../patch-5.7.3.gz | patch -p1
 
 Although interdiff may save you a step or two you are generally advised to
 do the additional steps since interdiff can get things wrong in some cases.
@@ -245,62 +245,67 @@ The patches are available at http://kernel.org/
 Most recent patches are linked from the front page, but they also have
 specific homes.
 
-The 4.x.y (-stable) and 4.x patches live at
+The 5.x.y (-stable) and 5.x patches live at
 
-	https://www.kernel.org/pub/linux/kernel/v4.x/
+	https://www.kernel.org/pub/linux/kernel/v5.x/
 
-The -rc patches live at
+The -rc patches are not stored on the webserver but are generated on
+demand from git tags such as
 
-	https://www.kernel.org/pub/linux/kernel/v4.x/testing/
+	https://git.kernel.org/torvalds/p/v5.1-rc1/v5.0
 
+The stable -rc patches live at
 
-The 4.x kernels
+	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/
+
+
+The 5.x kernels
 ===============
 
 These are the base stable releases released by Linus. The highest numbered
 release is the most recent.
 
 If regressions or other serious flaws are found, then a -stable fix patch
-will be released (see below) on top of this base. Once a new 4.x base
+will be released (see below) on top of this base. Once a new 5.x base
 kernel is released, a patch is made available that is a delta between the
-previous 4.x kernel and the new one.
+previous 5.x kernel and the new one.
 
-To apply a patch moving from 4.6 to 4.7, you'd do the following (note
-that such patches do **NOT** apply on top of 4.x.y kernels but on top of the
-base 4.x kernel -- if you need to move from 4.x.y to 4.x+1 you need to
-first revert the 4.x.y patch).
+To apply a patch moving from 5.6 to 5.7, you'd do the following (note
+that such patches do **NOT** apply on top of 5.x.y kernels but on top of the
+base 5.x kernel -- if you need to move from 5.x.y to 5.x+1 you need to
+first revert the 5.x.y patch).
 
 Here are some examples::
 
-	# moving from 4.6 to 4.7
+	# moving from 5.6 to 5.7
 
-	$ cd ~/linux-4.6		# change to kernel source dir
-	$ patch -p1 < ../patch-4.7	# apply the 4.7 patch
+	$ cd ~/linux-5.6		# change to kernel source dir
+	$ patch -p1 < ../patch-5.7	# apply the 5.7 patch
 	$ cd ..
-	$ mv linux-4.6 linux-4.7	# rename source dir
+	$ mv linux-5.6 linux-5.7	# rename source dir
 
-	# moving from 4.6.1 to 4.7
+	# moving from 5.6.1 to 5.7
 
-	$ cd ~/linux-4.6.1		# change to kernel source dir
-	$ patch -p1 -R < ../patch-4.6.1	# revert the 4.6.1 patch
-					# source dir is now 4.6
-	$ patch -p1 < ../patch-4.7	# apply new 4.7 patch
+	$ cd ~/linux-5.6.1		# change to kernel source dir
+	$ patch -p1 -R < ../patch-5.6.1	# revert the 5.6.1 patch
+					# source dir is now 5.6
+	$ patch -p1 < ../patch-5.7	# apply new 5.7 patch
 	$ cd ..
-	$ mv linux-4.6.1 linux-4.7	# rename source dir
+	$ mv linux-5.6.1 linux-5.7	# rename source dir
 
 
-The 4.x.y kernels
+The 5.x.y kernels
 =================
 
 Kernels with 3-digit versions are -stable kernels. They contain small(ish)
 critical fixes for security problems or significant regressions discovered
-in a given 4.x kernel.
+in a given 5.x kernel.
 
 This is the recommended branch for users who want the most recent stable
 kernel and are not interested in helping test development/experimental
 versions.
 
-If no 4.x.y kernel is available, then the highest numbered 4.x kernel is
+If no 5.x.y kernel is available, then the highest numbered 5.x kernel is
 the current stable kernel.
 
 .. note::
@@ -308,23 +313,23 @@ the current stable kernel.
  The -stable team usually do make incremental patches available as well
  as patches against the latest mainline release, but I only cover the
  non-incremental ones below. The incremental ones can be found at
- https://www.kernel.org/pub/linux/kernel/v4.x/incr/
+ https://www.kernel.org/pub/linux/kernel/v5.x/incr/
 
-These patches are not incremental, meaning that for example the 4.7.3
-patch does not apply on top of the 4.7.2 kernel source, but rather on top
-of the base 4.7 kernel source.
+These patches are not incremental, meaning that for example the 5.7.3
+patch does not apply on top of the 5.7.2 kernel source, but rather on top
+of the base 5.7 kernel source.
 
-So, in order to apply the 4.7.3 patch to your existing 4.7.2 kernel
-source you have to first back out the 4.7.2 patch (so you are left with a
-base 4.7 kernel source) and then apply the new 4.7.3 patch.
+So, in order to apply the 5.7.3 patch to your existing 5.7.2 kernel
+source you have to first back out the 5.7.2 patch (so you are left with a
+base 5.7 kernel source) and then apply the new 5.7.3 patch.
 
 Here's a small example::
 
-	$ cd ~/linux-4.7.2		# change to the kernel source dir
-	$ patch -p1 -R < ../patch-4.7.2	# revert the 4.7.2 patch
-	$ patch -p1 < ../patch-4.7.3	# apply the new 4.7.3 patch
+	$ cd ~/linux-5.7.2		# change to the kernel source dir
+	$ patch -p1 -R < ../patch-5.7.2	# revert the 5.7.2 patch
+	$ patch -p1 < ../patch-5.7.3	# apply the new 5.7.3 patch
 	$ cd ..
-	$ mv linux-4.7.2 linux-4.7.3	# rename the kernel source dir
+	$ mv linux-5.7.2 linux-5.7.3	# rename the kernel source dir
 
 The -rc kernels
 ===============
@@ -343,38 +348,38 @@ This is a good branch to run for people who want to help out testing
 development kernels but do not want to run some of the really experimental
 stuff (such people should see the sections about -next and -mm kernels below).
 
-The -rc patches are not incremental, they apply to a base 4.x kernel, just
-like the 4.x.y patches described above. The kernel version before the -rcN
+The -rc patches are not incremental, they apply to a base 5.x kernel, just
+like the 5.x.y patches described above. The kernel version before the -rcN
 suffix denotes the version of the kernel that this -rc kernel will eventually
 turn into.
 
-So, 4.8-rc5 means that this is the fifth release candidate for the 4.8
-kernel and the patch should be applied on top of the 4.7 kernel source.
+So, 5.8-rc5 means that this is the fifth release candidate for the 5.8
+kernel and the patch should be applied on top of the 5.7 kernel source.
 
 Here are 3 examples of how to apply these patches::
 
-	# first an example of moving from 4.7 to 4.8-rc3
+	# first an example of moving from 5.7 to 5.8-rc3
 
-	$ cd ~/linux-4.7			# change to the 4.7 source dir
-	$ patch -p1 < ../patch-4.8-rc3		# apply the 4.8-rc3 patch
+	$ cd ~/linux-5.7			# change to the 5.7 source dir
+	$ patch -p1 < ../patch-5.8-rc3		# apply the 5.8-rc3 patch
 	$ cd ..
-	$ mv linux-4.7 linux-4.8-rc3		# rename the source dir
+	$ mv linux-5.7 linux-5.8-rc3		# rename the source dir
 
-	# now let's move from 4.8-rc3 to 4.8-rc5
+	# now let's move from 5.8-rc3 to 5.8-rc5
 
-	$ cd ~/linux-4.8-rc3			# change to the 4.8-rc3 dir
-	$ patch -p1 -R < ../patch-4.8-rc3	# revert the 4.8-rc3 patch
-	$ patch -p1 < ../patch-4.8-rc5		# apply the new 4.8-rc5 patch
+	$ cd ~/linux-5.8-rc3			# change to the 5.8-rc3 dir
+	$ patch -p1 -R < ../patch-5.8-rc3	# revert the 5.8-rc3 patch
+	$ patch -p1 < ../patch-5.8-rc5		# apply the new 5.8-rc5 patch
 	$ cd ..
-	$ mv linux-4.8-rc3 linux-4.8-rc5	# rename the source dir
+	$ mv linux-5.8-rc3 linux-5.8-rc5	# rename the source dir
 
-	# finally let's try and move from 4.7.3 to 4.8-rc5
+	# finally let's try and move from 5.7.3 to 5.8-rc5
 
-	$ cd ~/linux-4.7.3			# change to the kernel source dir
-	$ patch -p1 -R < ../patch-4.7.3		# revert the 4.7.3 patch
-	$ patch -p1 < ../patch-4.8-rc5		# apply new 4.8-rc5 patch
+	$ cd ~/linux-5.7.3			# change to the kernel source dir
+	$ patch -p1 -R < ../patch-5.7.3		# revert the 5.7.3 patch
+	$ patch -p1 < ../patch-5.8-rc5		# apply new 5.8-rc5 patch
 	$ cd ..
-	$ mv linux-4.7.3 linux-4.8-rc5		# rename the kernel source dir
+	$ mv linux-5.7.3 linux-5.8-rc5		# rename the kernel source dir
 
 
 The -mm patches and the linux-next tree
diff --git a/Documentation/translations/it_IT/admin-guide/README.rst b/Documentation/translations/it_IT/admin-guide/README.rst
index 80f5ffc94a9e..b37166817842 100644
--- a/Documentation/translations/it_IT/admin-guide/README.rst
+++ b/Documentation/translations/it_IT/admin-guide/README.rst
@@ -4,7 +4,7 @@
 
 .. _it_readme:
 
-Rilascio del kernel Linux  4.x <http://kernel.org/>
+Rilascio del kernel Linux  5.x <http://kernel.org/>
 ===================================================
 
 .. warning::
-- 
2.20.0

